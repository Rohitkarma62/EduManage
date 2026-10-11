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

  test('only one attendance session per class and calendar date', () async {
    final studentId = await students.create(
      fullName: 'Session constraint student',
      joinedAt: DateTime(2026, 1, 1),
    );
    final classId = await db.into(db.classGroups).insert(
      ClassGroupsCompanion.insert(name: 'Session constraint class'),
    );
    await assignments.assign(
      studentId: studentId,
      classId: classId,
      effectiveFrom: DateTime(2026, 1, 1),
    );

    await attendance.createSession(
      classId: classId,
      attendanceDate: DateTime(2026, 4, 8, 9),
      studentIds: [studentId],
    );

    await expectLater(
      attendance.createSession(
        classId: classId,
        attendanceDate: DateTime(2026, 4, 8, 19),
        studentIds: [studentId],
      ),
      throwsA(anything),
    );
    expect(await db.select(db.attendanceSessions).get(), hasLength(1));
    expect(await db.select(db.attendanceEntries).get(), hasLength(1));
  });
}
