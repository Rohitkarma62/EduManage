import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:edumanage_offline/core/database/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

/// Builds the schema as it existed at version 1, before integrity triggers
/// were introduced in version 2. Seeded rows must survive the real upgrade.
void main() {
  test('upgrades a populated v1 database to v2 without losing data', () async {
    final executor = NativeDatabase.memory(
      setup: (database) {
        database.execute('''
          CREATE TABLE institute_settings (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
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
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            full_name TEXT NOT NULL,
            phone TEXT,
            guardian_name TEXT,
            guardian_phone TEXT,
            address TEXT,
            date_of_birth INTEGER,
            joined_at INTEGER NOT NULL,
            is_active INTEGER NOT NULL DEFAULT 1,
            created_at INTEGER NOT NULL,
            updated_at INTEGER NOT NULL
          )
        ''');
        database.execute('''
          CREATE INDEX students_name_idx ON students (full_name)
        ''');
        database.execute('''
          CREATE INDEX students_phone_idx ON students (phone)
        ''');
        database.execute('''
          CREATE TABLE class_groups (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            description TEXT,
            is_active INTEGER NOT NULL DEFAULT 1,
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
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            class_id INTEGER NOT NULL REFERENCES class_groups(id),
            name TEXT NOT NULL,
            description TEXT,
            is_active INTEGER NOT NULL DEFAULT 1,
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
            id INTEGER PRIMARY KEY AUTOINCREMENT,
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

        // Drift uses PRAGMA user_version to identify the database schema.
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

    // Opening AppDatabase runs the actual Drift v1 -> v2 migration.
    await database.customSelect('SELECT 1').getSingle();

    final version = await database
        .customSelect('PRAGMA user_version', readsFrom: const {})
        .getSingle();
    expect(version.read<int>('user_version'), 2);

    final institute = await database
        .customSelect(
          "SELECT institute_name, owner_name FROM institute_settings WHERE id = 7",
          readsFrom: const {},
        )
        .getSingle();
    expect(institute.read<String>('institute_name'), 'Legacy Institute');
    expect(institute.read<String>('owner_name'), 'Legacy Owner');

    final student = await database
        .customSelect(
          'SELECT id, full_name, phone FROM students WHERE id = 11',
          readsFrom: const {},
        )
        .getSingle();
    expect(student.read<int>('id'), 11);
    expect(student.read<String>('full_name'), 'Legacy Student');
    expect(student.read<String>('phone'), '9876543210');

    final assignment = await database
        .customSelect(
          'SELECT id, student_id, class_id, batch_id, assignment_scope_key, '
          'change_reason FROM student_assignments WHERE id = 19',
          readsFrom: const {},
        )
        .getSingle();
    expect(assignment.read<int>('id'), 19);
    expect(assignment.read<int>('student_id'), 11);
    expect(assignment.read<int>('class_id'), 13);
    expect(assignment.read<int>('batch_id'), 17);
    expect(assignment.read<String>('assignment_scope_key'), 'batch:17');
    expect(assignment.read<String>('change_reason'), 'Legacy assignment');

    final triggers = await database.customSelect(
      "SELECT name FROM sqlite_master WHERE type = 'trigger' "
      "AND name IN ("
      "'student_assignments_batch_class_insert', "
      "'student_assignments_batch_class_update', "
      "'student_assignments_no_overlap_insert', "
      "'student_assignments_no_overlap_update')",
      readsFrom: const {},
    ).get();
    expect(triggers.map((row) => row.read<String>('name')).toSet(), {
      'student_assignments_batch_class_insert',
      'student_assignments_batch_class_update',
      'student_assignments_no_overlap_insert',
      'student_assignments_no_overlap_update',
    });

    // The migrated database must still enforce the v2 integrity rules.
    await expectLater(
      database.customStatement('''
        INSERT INTO student_assignments
          (student_id, class_id, batch_id, assignment_scope_key,
           effective_from, effective_to, change_reason, created_at)
        VALUES (11, 13, NULL, 'class:13', 1769904000000, NULL, NULL,
                1769904000000)
      '''),
      throwsA(isA<Exception>()),
    );
  });
}
