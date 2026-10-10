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

  test('enables SQLite foreign-key enforcement', () async {
    final result = await database
        .customSelect('PRAGMA foreign_keys', readsFrom: {}).getSingle();
    expect(result.read<int>('foreign_keys'), 1);
  });

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

  test('SQLite allows adjacent half-open intervals from direct SQL',
      () async {
    final studentId = await createStudent();
    final classId = await createClass('Class A');

    await assignmentsDao.assign(
      studentId: studentId,
      classId: classId,
      effectiveFrom: DateTime(2026, 1, 1),
      effectiveTo: DateTime(2026, 2, 1),
    );

    // Bypass the DAO to verify the SQLite trigger uses strict overlap checks:
    // [Jan 1, Feb 1) and [Feb 1, infinity) do not overlap.
    await expectLater(
      database.customStatement('''
        INSERT INTO student_assignments
          (student_id, class_id, batch_id, assignment_scope_key,
           effective_from, effective_to, change_reason, created_at)
        VALUES ($studentId, $classId, NULL, 'class:$classId',
                1769904000000, NULL, NULL, 1769904000000)
      '''),
      completes,
    );

    final rows = await database.customSelect(
      'SELECT id FROM student_assignments WHERE student_id = $studentId',
      readsFrom: {database.studentAssignments},
    ).get();
    expect(rows, hasLength(2));
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
      throwsA(isA<Exception>()),
    );
  });

  test('rejects duplicate class names in SQLite', () async {
    await createClass('Class A');
    await expectLater(
      createClass('Class A'),
      throwsA(isA<Exception>()),
    );
  });

  test('rejects duplicate batch names within the same class', () async {
    final classId = await createClass('Class A');
    await database.into(database.batches).insert(
          BatchesCompanion.insert(classId: classId, name: 'Morning'),
        );

    await expectLater(
      database.into(database.batches).insert(
            BatchesCompanion.insert(classId: classId, name: 'Morning'),
          ),
      throwsA(isA<Exception>()),
    );
  });

  test('allows same batch name in different classes', () async {
    final classA = await createClass('Class A');
    final classB = await createClass('Class B');

    await database.into(database.batches).insert(
          BatchesCompanion.insert(classId: classA, name: 'Morning'),
        );
    await expectLater(
      database.into(database.batches).insert(
            BatchesCompanion.insert(classId: classB, name: 'Morning'),
          ),
      completes,
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

  test('SQLite rejects direct assignment with mismatched batch and class',
      () async {
    final studentId = await createStudent();
    final classA = await createClass('Class A');
    final classB = await createClass('Class B');
    final batchB = await database.into(database.batches).insert(
          BatchesCompanion.insert(classId: classB, name: 'Batch B'),
        );

    await expectLater(
      database.into(database.studentAssignments).insert(
            StudentAssignmentsCompanion.insert(
              studentId: studentId,
              classId: classA,
              batchId: Value(batchB),
              assignmentScopeKey: 'batch:$batchB',
              effectiveFrom: DateTime(2026, 1, 1),
              effectiveTo: const Value(null),
              changeReason: const Value(null),
              createdAt: Value(DateTime(2026, 1, 1)),
            ),
          ),
      throwsA(isA<Exception>()),
    );
  });

  test('SQLite rejects overlapping assignments inserted outside the DAO',
      () async {
    final studentId = await createStudent();
    final classId = await createClass('Class A');

    await assignmentsDao.assign(
      studentId: studentId,
      classId: classId,
      effectiveFrom: DateTime(2026, 1, 1),
      effectiveTo: DateTime(2026, 3, 1),
    );

    await expectLater(
      database.into(database.studentAssignments).insert(
            StudentAssignmentsCompanion.insert(
              studentId: studentId,
              classId: classId,
              batchId: const Value(null),
              assignmentScopeKey: 'class:$classId',
              effectiveFrom: DateTime(2026, 2, 1),
              effectiveTo: const Value(null),
              changeReason: const Value(null),
              createdAt: Value(DateTime(2026, 2, 1)),
            ),
          ),
      throwsA(isA<Exception>()),
    );
  });


  test('SQLite rejects update that introduces assignment overlap', () async {
    final studentId = await createStudent();
    final classId = await createClass('Class A');
    final firstId = await assignmentsDao.assign(
      studentId: studentId,
      classId: classId,
      effectiveFrom: DateTime(2026, 1, 1),
      effectiveTo: DateTime(2026, 2, 1),
    );
    await assignmentsDao.assign(
      studentId: studentId,
      classId: classId,
      effectiveFrom: DateTime(2026, 2, 1),
      effectiveTo: DateTime(2026, 3, 1),
    );

    await expectLater(
      (database.update(database.studentAssignments)
            ..where((row) => row.id.equals(firstId)))
          .write(
        StudentAssignmentsCompanion(
          effectiveTo: Value(DateTime(2026, 2, 15)),
        ),
      ),
      throwsA(isA<Exception>()),
    );
  });

  test('SQLite rejects update that changes assignment to another class batch',
      () async {
    final studentId = await createStudent();
    final classA = await createClass('Class A');
    final classB = await createClass('Class B');
    final batchB = await database.into(database.batches).insert(
          BatchesCompanion.insert(classId: classB, name: 'Batch B'),
        );
    final assignmentId = await assignmentsDao.assign(
      studentId: studentId,
      classId: classA,
      effectiveFrom: DateTime(2026, 1, 1),
    );

    await expectLater(
      (database.update(database.studentAssignments)
            ..where((row) => row.id.equals(assignmentId)))
          .write(
        StudentAssignmentsCompanion(
          batchId: Value(batchB),
          assignmentScopeKey: Value('batch:$batchB'),
        ),
      ),
      throwsA(isA<Exception>()),
    );
  });


  test('SQLite rejects direct SQL update with mismatched batch and class',
      () async {
    final studentId = await createStudent();
    final classA = await createClass('Class A');
    final classB = await createClass('Class B');
    final batchB = await database.into(database.batches).insert(
          BatchesCompanion.insert(classId: classB, name: 'Batch B'),
        );
    final assignmentId = await assignmentsDao.assign(
      studentId: studentId,
      classId: classA,
      effectiveFrom: DateTime(2026, 1, 1),
    );

    // Bypass Drift's update builder and DAO checks: SQLite must enforce
    // batch/class consistency even for raw SQL issued by another code path.
    await expectLater(
      database.customStatement(
        'UPDATE student_assignments SET batch_id = $batchB '
        'WHERE id = $assignmentId',
      ),
      throwsA(isA<Exception>()),
    );

    final row = await (database.select(database.studentAssignments)
          ..where((item) => item.id.equals(assignmentId)))
        .getSingle();
    expect(row.classId, classA);
    expect(row.batchId, null);
  });


  test('SQLite rejects direct SQL assignment with mismatched scope key',
      () async {
    final studentId = await createStudent();
    final classId = await createClass('Class A');

    // Raw SQL bypasses DAO normalization; the database must protect the
    // non-null scope key used by indexes and future scoped queries.
    await expectLater(
      database.customStatement('''
        INSERT INTO student_assignments
          (student_id, class_id, batch_id, assignment_scope_key,
           effective_from, effective_to, change_reason, created_at)
        VALUES ($studentId, $classId, NULL, 'class:999',
                1767225600000, NULL, NULL, 1767225600000)
      '''),
      throwsA(isA<Exception>()),
    );

    final rows = await database.customSelect(
      'SELECT id FROM student_assignments WHERE student_id = $studentId',
      readsFrom: {database.studentAssignments},
    ).get();
    expect(rows, isEmpty);
  });

}
