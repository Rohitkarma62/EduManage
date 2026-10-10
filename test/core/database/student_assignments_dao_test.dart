import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:edumanage_offline/core/database/app_database.dart';
import 'package:edumanage_offline/core/database/student_assignments_dao.dart';
import 'package:edumanage_offline/core/database/students_dao.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late StudentsDao studentsDao;
  late StudentAssignmentsDao assignmentsDao;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    studentsDao = StudentsDao(database);
    assignmentsDao = StudentAssignmentsDao(database);
  });

  tearDown(() async {
    await database.close();
  });

  Future<int> createStudent() => studentsDao.create(
        fullName: 'Test Student',
        joinedAt: DateTime(2026, 1, 1),
      );

  Future<int> createClass(String name) =>
      database.into(database.classGroups).insert(
            ClassGroupsCompanion.insert(name: name),
          );

  test('accepts adjacent half-open assignment intervals', () async {
    final studentId = await createStudent();
    final classId = await createClass('Class A');

    await assignmentsDao.assign(
      studentId: studentId,
      classId: classId,
      effectiveFrom: DateTime(2026, 1, 1),
      effectiveTo: DateTime(2026, 2, 1),
    );

    await expectLater(
      assignmentsDao.assign(
        studentId: studentId,
        classId: classId,
        effectiveFrom: DateTime(2026, 2, 1),
      ),
      completes,
    );
  });

  test('rejects overlapping assignment intervals', () async {
    final studentId = await createStudent();
    final classId = await createClass('Class A');

    await assignmentsDao.assign(
      studentId: studentId,
      classId: classId,
      effectiveFrom: DateTime(2026, 1, 1),
      effectiveTo: DateTime(2026, 3, 1),
    );

    await expectLater(
      assignmentsDao.assign(
        studentId: studentId,
        classId: classId,
        effectiveFrom: DateTime(2026, 2, 1),
      ),
      throwsStateError,
    );
  });

  test('rejects a batch that belongs to a different class', () async {
    final studentId = await createStudent();
    final classA = await createClass('Class A');
    final classB = await createClass('Class B');
    final batchB = await database.into(database.batches).insert(
          BatchesCompanion.insert(classId: classB, name: 'Batch B'),
        );

    await expectLater(
      assignmentsDao.assign(
        studentId: studentId,
        classId: classA,
        batchId: batchB,
        effectiveFrom: DateTime(2026, 1, 1),
      ),
      throwsArgumentError,
    );
  });

  test('database rejects assignment with a missing student foreign key',
      () async {
    final classId = await createClass('Class A');

    await expectLater(
      database.into(database.studentAssignments).insert(
            StudentAssignmentsCompanion.insert(
              studentId: 999999,
              classId: classId,
              batchId: const Value(null),
              assignmentScopeKey: 'class:$classId',
              effectiveFrom: DateTime(2026, 1, 1),
              effectiveTo: const Value(null),
              changeReason: const Value(null),
              createdAt: Value(DateTime(2026, 1, 1)),
            ),
          ),
      throwsA(anything),
    );
  });

  test('rejects non-positive assignment interval length', () async {
    final studentId = await createStudent();
    final classId = await createClass('Class A');

    expect(
      () => assignmentsDao.assign(
        studentId: studentId,
        classId: classId,
        effectiveFrom: DateTime(2026, 2, 1),
        effectiveTo: DateTime(2026, 2, 1),
      ),
      throwsArgumentError,
    );
  });
}
