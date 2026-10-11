import 'package:drift/native.dart';
import 'package:edumanage_offline/core/database/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

/// Frozen v1 DDL for the schema that existed before later migrations.
/// Keep table columns, constraints, and indexes aligned with v1; v2 adds four
/// integrity triggers, v3 adds assignment-scope triggers, v4 adds date-range
/// triggers, v5 adds attendance tables and scope triggers, and v6 adds the
/// attendance correction audit table.
void main() {
  test('upgrades populated v1 schema to v6 and preserves schema and data',
      () async {
    final executor = NativeDatabase.memory(
      setup: (database) {
        database.execute('''
          CREATE TABLE institute_settings (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            institute_name TEXT NOT NULL,
            owner_name TEXT,
            phone TEXT,
            address TEXT,
            created_at INTEGER NOT NULL,
            updated_at INTEGER NOT NULL
          )
        ''');
        database.execute('''
          CREATE TABLE students (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            full_name TEXT NOT NULL,
            phone TEXT,
            guardian_name TEXT,
            guardian_phone TEXT,
            address TEXT,
            date_of_birth INTEGER,
            joined_at INTEGER NOT NULL,
            is_active INTEGER NOT NULL DEFAULT 1
              CHECK (is_active IN (0, 1)),
            created_at INTEGER NOT NULL,
            updated_at INTEGER NOT NULL
          )
        ''');
        database.execute(
            'CREATE INDEX students_name_idx ON students (full_name)');
        database.execute(
            'CREATE INDEX students_phone_idx ON students (phone)');
        database.execute('''
          CREATE TABLE class_groups (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            description TEXT,
            is_active INTEGER NOT NULL DEFAULT 1
              CHECK (is_active IN (0, 1)),
            created_at INTEGER NOT NULL,
            updated_at INTEGER NOT NULL
          )
        ''');
        database.execute('''
          CREATE UNIQUE INDEX class_groups_name_unique
          ON class_groups (name)
        ''');
        database.execute('''
          CREATE TABLE batches (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            class_id INTEGER NOT NULL REFERENCES class_groups(id),
            name TEXT NOT NULL,
            description TEXT,
            is_active INTEGER NOT NULL DEFAULT 1
              CHECK (is_active IN (0, 1)),
            created_at INTEGER NOT NULL,
            updated_at INTEGER NOT NULL
          )
        ''');
        database.execute('''
          CREATE UNIQUE INDEX batches_class_name_unique
          ON batches (class_id, name)
        ''');
        database.execute('''
          CREATE TABLE student_assignments (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            student_id INTEGER NOT NULL REFERENCES students(id)
              ON DELETE RESTRICT,
            class_id INTEGER NOT NULL REFERENCES class_groups(id)
              ON DELETE RESTRICT,
            batch_id INTEGER REFERENCES batches(id) ON DELETE RESTRICT,
            assignment_scope_key TEXT NOT NULL,
            effective_from INTEGER NOT NULL,
            effective_to INTEGER,
            change_reason TEXT,
            created_at INTEGER NOT NULL
          )
        ''');
        database.execute('''
          CREATE INDEX student_assignments_student_start_idx
          ON student_assignments (student_id, effective_from)
        ''');
        database.execute('''
          CREATE INDEX student_assignments_scope_start_idx
          ON student_assignments (assignment_scope_key, effective_from)
        ''');

        // Drift identifies schema versions with PRAGMA user_version.
        database.execute('PRAGMA user_version = 1');
        database.execute('''
          INSERT INTO institute_settings
            (id, institute_name, owner_name, phone, address, created_at, updated_at)
          VALUES (7, 'Legacy Institute', 'Legacy Owner', '9876543210',
                  'Old address', 1767225600000, 1767225600000)
        ''');
        database.execute('''
          INSERT INTO students
            (id, full_name, phone, joined_at, is_active, created_at, updated_at)
          VALUES (11, 'Legacy Student', '9876543210', 1767225600000, 1,
                  1767225600000, 1767225600000)
        ''');
        database.execute('''
          INSERT INTO class_groups
            (id, name, is_active, created_at, updated_at)
          VALUES (13, 'Legacy Class', 1, 1767225600000, 1767225600000)
        ''');
        database.execute('''
          INSERT INTO batches
            (id, class_id, name, is_active, created_at, updated_at)
          VALUES (17, 13, 'Legacy Batch', 1, 1767225600000, 1767225600000)
        ''');
        database.execute('''
          INSERT INTO student_assignments
            (id, student_id, class_id, batch_id, assignment_scope_key,
             effective_from, effective_to, change_reason, created_at)
          VALUES (19, 11, 13, 17, 'batch:17', 1767225600000, NULL,
                  'Legacy assignment', 1767225600000)
        ''');
      },
    );

    final database = AppDatabase.forTesting(executor);
    addTearDown(database.close);

    // Accessing the database runs Drift's actual v1 -> v6 migration.
    await database.customSelect('SELECT 1').getSingle();

    final version = await database
        .customSelect('PRAGMA user_version', readsFrom: const {})
        .getSingle();
    expect(version.read<int>('user_version'), 6);

    final migratedTables = await database.customSelect(
      "SELECT name FROM sqlite_master WHERE type = 'table' AND name IN "
      "('attendance_sessions', 'attendance_entries', 'attendance_corrections')",
      readsFrom: const {},
    ).get();
    expect(
      migratedTables.map((row) => row.read<String>('name')).toSet(),
      {'attendance_sessions', 'attendance_entries', 'attendance_corrections'},
    );

    final expectedIndexes = {
      'students_name_idx',
      'students_phone_idx',
      'class_groups_name_unique',
      'batches_class_name_unique',
      'student_assignments_student_start_idx',
      'student_assignments_scope_start_idx',
      'attendance_sessions_scope_date_unique',
      'attendance_entries_session_student_unique',
      'attendance_entries_student_idx',
      'attendance_corrections_entry_time_idx',
    };
    final indexes = await database.customSelect(
      "SELECT name FROM sqlite_master WHERE type = 'index' AND name NOT LIKE 'sqlite_%'",
      readsFrom: const {},
    ).get();
    expect(indexes.map((row) => row.read<String>('name')).toSet(),
        expectedIndexes);

    final institute = await database.customSelect(
      'SELECT institute_name, owner_name, phone, address '
      'FROM institute_settings WHERE id = 7',
      readsFrom: const {},
    ).getSingle();
    expect(institute.read<String>('institute_name'), 'Legacy Institute');
    expect(institute.read<String>('owner_name'), 'Legacy Owner');
    expect(institute.read<String>('phone'), '9876543210');
    expect(institute.read<String>('address'), 'Old address');

    final student = await database.customSelect(
      'SELECT id, full_name, phone, is_active FROM students WHERE id = 11',
      readsFrom: const {},
    ).getSingle();
    expect(student.read<int>('id'), 11);
    expect(student.read<String>('full_name'), 'Legacy Student');
    expect(student.read<String>('phone'), '9876543210');
    expect(student.read<int>('is_active'), 1);

    final classRow = await database.customSelect(
      'SELECT id, name FROM class_groups WHERE id = 13',
      readsFrom: const {},
    ).getSingle();
    expect(classRow.read<int>('id'), 13);
    expect(classRow.read<String>('name'), 'Legacy Class');

    final batch = await database.customSelect(
      'SELECT id, class_id, name FROM batches WHERE id = 17',
      readsFrom: const {},
    ).getSingle();
    expect(batch.read<int>('id'), 17);
    expect(batch.read<int>('class_id'), 13);
    expect(batch.read<String>('name'), 'Legacy Batch');

    final assignment = await database.customSelect(
      'SELECT id, student_id, class_id, batch_id, assignment_scope_key, '
      'effective_from, effective_to, change_reason FROM student_assignments '
      'WHERE id = 19',
      readsFrom: const {},
    ).getSingle();
    expect(assignment.read<int>('id'), 19);
    expect(assignment.read<int>('student_id'), 11);
    expect(assignment.read<int>('class_id'), 13);
    expect(assignment.read<int>('batch_id'), 17);
    expect(assignment.read<String>('assignment_scope_key'), 'batch:17');
    expect(assignment.read<int>('effective_from'), 1767225600000);
    expect(assignment.readNullable<int>('effective_to'), isNull);
    expect(assignment.read<String>('change_reason'), 'Legacy assignment');

    final triggers = await database.customSelect(
      "SELECT name FROM sqlite_master WHERE type = 'trigger' "
      "AND name IN ("
      "'student_assignments_batch_class_insert', "
      "'student_assignments_batch_class_update', "
      "'student_assignments_no_overlap_insert', "
      "'student_assignments_no_overlap_update', "
      "'student_assignments_scope_key_insert', "
      "'student_assignments_scope_key_update', "
      "'student_assignments_valid_range_insert', "
      "'student_assignments_valid_range_update', "
      "'attendance_sessions_scope_insert', "
      "'attendance_sessions_scope_update', "
      "'attendance_sessions_batch_class_insert', "
      "'attendance_sessions_batch_class_update')",
      readsFrom: const {},
    ).get();
    expect(triggers.map((row) => row.read<String>('name')).toSet(), {
      'student_assignments_batch_class_insert',
      'student_assignments_batch_class_update',
      'student_assignments_no_overlap_insert',
      'student_assignments_no_overlap_update',
      'student_assignments_scope_key_insert',
      'student_assignments_scope_key_update',
      'student_assignments_valid_range_insert',
      'student_assignments_valid_range_update',
      'attendance_sessions_scope_insert',
      'attendance_sessions_scope_update',
      'attendance_sessions_batch_class_insert',
      'attendance_sessions_batch_class_update',
    });

    // Seed a second student so the date-range assertion cannot be satisfied
    // accidentally by the existing student's overlap constraint.
    await database.customStatement('''
      INSERT INTO students
        (id, full_name, joined_at, is_active, created_at, updated_at)
      VALUES (12, 'Range Test Student', 1767225600000, 1,
              1767225600000, 1767225600000)
    ''');

    // The migrated database must enforce interval, scope-key, and date-range invariants.
    await expectLater(
      database.customStatement('''
        INSERT INTO student_assignments
          (student_id, class_id, batch_id, assignment_scope_key,
           effective_from, effective_to, change_reason, created_at)
        VALUES (12, 13, NULL, 'class:13', 1767225600000, 1767225600000,
                NULL, 1767225600000)
      '''),
      throwsA(isA<Exception>()),
    );
    await expectLater(
      database.customStatement('''
        INSERT INTO student_assignments
          (student_id, class_id, batch_id, assignment_scope_key,
           effective_from, effective_to, change_reason, created_at)
        VALUES (12, 13, NULL, 'class:13', 1769904000000, 1767225600000,
                NULL, 1767225600000)
      '''),
      throwsA(isA<Exception>()),
    );
  });

  test('refuses to open a database with pre-existing foreign-key violations',
      () async {
    final executor = NativeDatabase.memory(
      setup: (database) {
        database.execute('CREATE TABLE parent_rows (id INTEGER PRIMARY KEY)');
        database.execute('''
          CREATE TABLE child_rows (
            id INTEGER PRIMARY KEY,
            parent_id INTEGER REFERENCES parent_rows(id)
          )
        ''');
        // Seed corrupt legacy data before Drift enables foreign-key checks.
        database.execute(
          'INSERT INTO child_rows (id, parent_id) VALUES (1, 404)',
        );
        database.execute('PRAGMA user_version = 4');
      },
    );

    final database = AppDatabase.forTesting(executor);
    addTearDown(database.close);

    await expectLater(
      database.customSelect('SELECT 1').getSingle(),
      throwsA(isA<StateError>()),
    );
  });


  test('refuses v3 migration when legacy assignment ranges are invalid', () async {
    final executor = NativeDatabase.memory(
      setup: (database) {
        database.execute('''
          CREATE TABLE student_assignments (
            id INTEGER PRIMARY KEY,
            effective_from INTEGER NOT NULL,
            effective_to INTEGER
          )
        ''');
        database.execute('''
          INSERT INTO student_assignments (id, effective_from, effective_to)
          VALUES (41, 200, 200)
        ''');
        database.execute('PRAGMA user_version = 3');
      },
    );

    final database = AppDatabase.forTesting(executor);
    addTearDown(database.close);

    await expectLater(
      database.customSelect('SELECT 1').getSingle(),
      throwsA(isA<StateError>()),
    );

    final versionRows = await executor.runSelect('PRAGMA user_version', const []);
    expect(versionRows.single['user_version'], 3);
    final legacyRows = await executor.runSelect(
      'SELECT id, effective_from, effective_to FROM student_assignments WHERE id = ?',
      [41],
    );
    expect(legacyRows.single['id'], 41);
    expect(legacyRows.single['effective_from'], 200);
    expect(legacyRows.single['effective_to'], 200);
    final newTriggers = await executor.runSelect(
      "SELECT name FROM sqlite_master WHERE type = 'trigger' AND name LIKE 'student_assignments_valid_range_%'",
      const [],
    );
    expect(newTriggers, isEmpty);
  });

  test('rolls back v3-to-v4 date-range trigger creation atomically', () async {
    final executor = NativeDatabase.memory(
      setup: (database) {
        database.execute('''
          CREATE TABLE student_assignments (
            id INTEGER PRIMARY KEY,
            effective_from INTEGER NOT NULL,
            effective_to INTEGER
          )
        ''');
        database.execute('''
          INSERT INTO student_assignments (id, effective_from, effective_to)
          VALUES (51, 100, 200)
        ''');
        // Force the second v4 trigger creation to fail after the insert trigger
        // has been created. The migration transaction must remove that insert
        // trigger and preserve the pre-existing conflicting trigger.
        database.execute('''
          CREATE TRIGGER student_assignments_valid_range_update
          BEFORE UPDATE ON student_assignments
          BEGIN
            SELECT RAISE(ABORT, 'fixture migration failure');
          END
        ''');
        database.execute('PRAGMA user_version = 3');
      },
    );

    final database = AppDatabase.forTesting(executor);
    addTearDown(database.close);

    await expectLater(
      database.customSelect('SELECT 1').getSingle(),
      throwsA(isA<Exception>()),
    );

    final versionRows = await executor.runSelect('PRAGMA user_version', const []);
    expect(versionRows.single['user_version'], 3);

    final assignmentRows = await executor.runSelect(
      'SELECT id, effective_from, effective_to FROM student_assignments WHERE id = ?',
      [51],
    );
    expect(assignmentRows.single['id'], 51);
    expect(assignmentRows.single['effective_from'], 100);
    expect(assignmentRows.single['effective_to'], 200);

    final triggerRows = await executor.runSelect(
      "SELECT name, sql FROM sqlite_master WHERE type = 'trigger'",
      const [],
    );
    final triggerSql = {
      for (final row in triggerRows)
        row['name'] as String: row['sql'] as String,
    };
    expect(triggerSql.keys, contains('student_assignments_valid_range_update'));
    expect(triggerSql['student_assignments_valid_range_update'], contains('fixture migration failure'));
    expect(triggerSql.keys, isNot(contains('student_assignments_valid_range_insert')));
  });

  test('rolls back a failed v1 migration and preserves schema version', () async {
    final executor = NativeDatabase.memory(
      setup: (database) {
        database.execute('CREATE TABLE batches (id INTEGER PRIMARY KEY, class_id INTEGER)');
        database.execute('''
          CREATE TABLE student_assignments (
            id INTEGER PRIMARY KEY,
            student_id INTEGER NOT NULL,
            class_id INTEGER NOT NULL,
            batch_id INTEGER,
            assignment_scope_key TEXT NOT NULL,
            effective_from INTEGER NOT NULL,
            effective_to INTEGER
          )
        ''');
        database.execute('''
          INSERT INTO student_assignments
            (id, student_id, class_id, batch_id, assignment_scope_key,
             effective_from, effective_to)
          VALUES (9, 4, 2, NULL, 'class:2', 100, NULL)
        ''');
        // Force failure after the first v2 trigger has been created.
        database.execute('''
          CREATE TRIGGER student_assignments_batch_class_update
          BEFORE UPDATE ON student_assignments
          BEGIN
            SELECT RAISE(ABORT, 'fixture migration failure');
          END
        ''');
        database.execute('PRAGMA user_version = 1');
      },
    );

    final database = AppDatabase.forTesting(executor);
    addTearDown(database.close);

    await expectLater(
      database.customSelect('SELECT 1').getSingle(),
      throwsA(isA<Exception>()),
    );

    // Query the executor directly because Drift's open future has failed.
    final versionRows = await executor.runSelect('PRAGMA user_version', const []);
    expect(versionRows.single['user_version'], 1);

    final assignmentRows = await executor.runSelect(
      'SELECT id, assignment_scope_key FROM student_assignments WHERE id = ?',
      [9],
    );
    expect(assignmentRows.single['id'], 9);
    expect(assignmentRows.single['assignment_scope_key'], 'class:2');

    final triggerRows = await executor.runSelect(
      "SELECT name FROM sqlite_master WHERE type = 'trigger' AND name = ?",
      ['student_assignments_batch_class_insert'],
    );
    expect(triggerRows, isEmpty);
  });


  test('rolls back a failed v2 migration and preserves v2 trigger behavior',
      () async {
    final executor = NativeDatabase.memory(
      setup: (database) {
        database.execute(
          'CREATE TABLE batches (id INTEGER PRIMARY KEY, class_id INTEGER)',
        );
        database.execute('''
          CREATE TABLE student_assignments (
            id INTEGER PRIMARY KEY,
            student_id INTEGER NOT NULL,
            class_id INTEGER NOT NULL,
            batch_id INTEGER,
            assignment_scope_key TEXT NOT NULL,
            effective_from INTEGER NOT NULL,
            effective_to INTEGER
          )
        ''');
        database.execute('''
          INSERT INTO student_assignments
            (id, student_id, class_id, batch_id, assignment_scope_key,
             effective_from, effective_to)
          VALUES (29, 8, 3, NULL, 'class:3', 200, 250)
        ''');
        database.execute(
          'INSERT INTO batches (id, class_id) VALUES (7, 99)',
        );
        database.execute('''
          INSERT INTO student_assignments
            (id, student_id, class_id, batch_id, assignment_scope_key,
             effective_from, effective_to)
          VALUES (32, 8, 3, NULL, 'class:3', 300, 500)
        ''');

        // Install the actual v2 trigger definitions, not no-op placeholders.
        database.execute('''
          CREATE TRIGGER student_assignments_batch_class_insert
          BEFORE INSERT ON student_assignments
          WHEN NEW.batch_id IS NOT NULL AND NOT EXISTS (
            SELECT 1 FROM batches
            WHERE id = NEW.batch_id AND class_id = NEW.class_id
          )
          BEGIN
            SELECT RAISE(ABORT, 'student assignment batch/class mismatch');
          END
        ''');
        database.execute('''
          CREATE TRIGGER student_assignments_batch_class_update
          BEFORE UPDATE OF batch_id, class_id ON student_assignments
          WHEN NEW.batch_id IS NOT NULL AND NOT EXISTS (
            SELECT 1 FROM batches
            WHERE id = NEW.batch_id AND class_id = NEW.class_id
          )
          BEGIN
            SELECT RAISE(ABORT, 'student assignment batch/class mismatch');
          END
        ''');
        database.execute('''
          CREATE TRIGGER student_assignments_no_overlap_insert
          BEFORE INSERT ON student_assignments
          WHEN EXISTS (
            SELECT 1 FROM student_assignments existing
            WHERE existing.student_id = NEW.student_id
              AND (NEW.effective_to IS NULL OR
                   existing.effective_from < NEW.effective_to)
              AND (existing.effective_to IS NULL OR
                   existing.effective_to > NEW.effective_from)
          )
          BEGIN
            SELECT RAISE(ABORT, 'student assignment intervals must not overlap');
          END
        ''');
        database.execute('''
          CREATE TRIGGER student_assignments_no_overlap_update
          BEFORE UPDATE OF student_id, effective_from, effective_to
          ON student_assignments
          WHEN EXISTS (
            SELECT 1 FROM student_assignments existing
            WHERE existing.id != NEW.id
              AND existing.student_id = NEW.student_id
              AND (NEW.effective_to IS NULL OR
                   existing.effective_from < NEW.effective_to)
              AND (existing.effective_to IS NULL OR
                   existing.effective_to > NEW.effective_from)
          )
          BEGIN
            SELECT RAISE(ABORT, 'student assignment intervals must not overlap');
          END
        ''');

        // Force failure on the second v3 trigger after the first is created.
        database.execute('''
          CREATE TRIGGER student_assignments_scope_key_update
          BEFORE UPDATE ON student_assignments
          BEGIN
            SELECT 1;
          END
        ''');
        database.execute('PRAGMA user_version = 2');
      },
    );

    final database = AppDatabase.forTesting(executor);
    addTearDown(database.close);

    await expectLater(
      database.customSelect('SELECT 1').getSingle(),
      throwsA(isA<Exception>()),
    );

    // Drift's open failed, so inspect SQLite directly through the executor.
    final versionRows = await executor.runSelect('PRAGMA user_version', const []);
    expect(versionRows.single['user_version'], 2);

    final assignmentRows = await executor.runSelect(
      'SELECT id, assignment_scope_key FROM student_assignments WHERE id = ?',
      [29],
    );
    expect(assignmentRows.single['id'], 29);
    expect(assignmentRows.single['assignment_scope_key'], 'class:3');

    final triggerRows = await executor.runSelect(
      "SELECT name, sql FROM sqlite_master WHERE type = 'trigger'",
      const [],
    );
    final triggerSql = {
      for (final row in triggerRows)
        row['name'] as String: row['sql'] as String,
    };
    expect(triggerSql.keys, containsAll({
      'student_assignments_batch_class_insert',
      'student_assignments_batch_class_update',
      'student_assignments_no_overlap_insert',
      'student_assignments_no_overlap_update',
      'student_assignments_scope_key_update',
    }));
    expect(
      triggerSql,
      isNot(contains('student_assignments_scope_key_insert')),
    );

    // Verify the original v2 trigger definitions survived intact.
    // Drift's database open failed, so inspect the persisted trigger SQL directly.
    expect(
      triggerSql['student_assignments_batch_class_insert'],
      contains('student assignment batch/class mismatch'),
    );
    expect(
      triggerSql['student_assignments_batch_class_update'],
      contains('student assignment batch/class mismatch'),
    );
    expect(
      triggerSql['student_assignments_no_overlap_insert'],
      contains('student assignment intervals must not overlap'),
    );
    expect(
      triggerSql['student_assignments_no_overlap_update'],
      contains('student assignment intervals must not overlap'),
    );
    expect(
      triggerSql['student_assignments_no_overlap_update'],
      contains('existing.id != NEW.id'),
    );
    expect(
      triggerSql['student_assignments_scope_key_update'],
      contains('SELECT 1'),
    );
  });

}
