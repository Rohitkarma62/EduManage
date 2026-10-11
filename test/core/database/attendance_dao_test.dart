import 'package:drift/native.dart';
import 'package:edumanage_offline/core/database/app_database.dart';
import 'package:edumanage_offline/core/database/attendance_dao.dart';
import 'package:edumanage_offline/core/database/student_assignments_dao.dart';
import 'package:edumanage_offline/core/database/students_dao.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late AttendanceDao attendance;
  late StudentsDao students;
  late StudentAssignmentsDao assignments;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    attendance = AttendanceDao(db);
    students = StudentsDao(db);
    assignments = StudentAssignmentsDao(db);
  });
  tearDown(() async => db.close());

  Future<int> setupStudent({String name = 'Student'}) async {
    final studentId = await students.create(
      fullName: name, joinedAt: DateTime(2026, 1, 1),
    );
    final classId = await db.into(db.classGroups).insert(
      ClassGroupsCompanion.insert(name: 'Class $name'),
    );
    await assignments.assign(
      studentId: studentId, classId: classId,
      effectiveFrom: DateTime(2026, 1, 1),
    );
    return classId;
  }

  test('creates explicit Unmarked entries and normalizes calendar date', () async {
    final classId = await setupStudent();
    final studentId = (await db.select(db.students).getSingle()).id;
    final id = await attendance.createSession(
      classId: classId, attendanceDate: DateTime(2026, 3, 4, 18, 45),
      studentIds: [studentId],
    );
    final session = await (db.select(db.attendanceSessions)
      ..where((row) => row.id.equals(id))).getSingle();
    expect(session.attendanceDate, DateTime(2026, 3, 4));
    expect((await attendance.listEntries(id)).single.status, 'unmarked');
  });

  test('duplicate student IDs are rejected before writing', () async {
    final classId = await setupStudent();
    final studentId = (await db.select(db.students).getSingle()).id;
    await expectLater(attendance.createSession(
      classId: classId, attendanceDate: DateTime(2026, 3, 4),
      studentIds: [studentId, studentId],
    ), throwsArgumentError);
    expect(await db.select(db.attendanceSessions).get(), isEmpty);
  });

  test('failed session creation rolls back session and entries atomically', () async {
    final classId = await setupStudent();
    final studentId = (await db.select(db.students).getSingle()).id;
    await expectLater(attendance.createSession(
      classId: classId, attendanceDate: DateTime(2026, 3, 4),
      studentIds: [studentId, 999999],
    ), throwsA(anything));
    expect(await db.select(db.attendanceSessions).get(), isEmpty);
    expect(await db.select(db.attendanceEntries).get(), isEmpty);
  });

  test('Leave is excluded from denominator and zero denominator is null', () async {
    final classId = await setupStudent();
    final first = (await db.select(db.students).getSingle()).id;
    final second = await students.create(
      fullName: 'Student 2', joinedAt: DateTime(2026, 1, 1),
    );
    await assignments.assign(
      studentId: second, classId: classId, effectiveFrom: DateTime(2026, 1, 1),
    );
    final id = await attendance.createSession(
      classId: classId, attendanceDate: DateTime(2026, 3, 4),
      studentIds: [first, second],
    );
    await attendance.setStatus(sessionId: id, studentId: first, status: AttendanceStatus.present);
    await attendance.setStatus(sessionId: id, studentId: second, status: AttendanceStatus.leave);
    expect(await attendance.attendancePercentage(id), 100);
    await attendance.setStatus(sessionId: id, studentId: first, status: AttendanceStatus.leave);
    expect(await attendance.attendancePercentage(id), isNull);
  });

  test('incomplete finalization requires confirmation and historical edits require a reason', () async {
    final classId = await setupStudent();
    final studentId = (await db.select(db.students).getSingle()).id;
    final id = await attendance.createSession(
      classId: classId, attendanceDate: DateTime(2026, 3, 4), studentIds: [studentId],
    );
    await expectLater(attendance.finalizeSession(sessionId: id), throwsStateError);
    await attendance.finalizeSession(sessionId: id, confirmIncomplete: true);
    await expectLater(attendance.setStatus(
      sessionId: id, studentId: studentId, status: AttendanceStatus.present,
    ), throwsStateError);
    await expectLater(attendance.setStatus(
      sessionId: id, studentId: studentId, status: AttendanceStatus.present,
      confirmHistoricalEdit: true,
    ), throwsArgumentError);
    await attendance.setStatus(
      sessionId: id, studentId: studentId, status: AttendanceStatus.present,
      confirmHistoricalEdit: true, correctionReason: 'Teacher confirmed register',
    );
    expect((await attendance.listEntries(id)).single.status, 'present');
  });
}
