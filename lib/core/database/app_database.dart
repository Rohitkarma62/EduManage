import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  InstituteSettings,
  Students,
  ClassGroups,
  Batches,
  StudentAssignments,
  AttendanceSessions,
  AttendanceEntries,
  AttendanceCorrections,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _createIntegrityTriggers();
          await _createAssignmentScopeTriggers();
          await _createAssignmentDateRangeTriggers();
          await _createAttendanceScopeTriggers();
        },
        onUpgrade: (m, from, to) async {
          // Keep all trigger DDL in one transaction. If any statement fails,
          // SQLite rolls back every trigger created earlier in this migration.
          await transaction(() async {
            if (from < 2) {
              await _createIntegrityTriggers();
            }
            if (from < 3) {
              await _createAssignmentScopeTriggers();
            }
            if (from < 4) {
              await _validateExistingAssignmentDateRanges();
              await _createAssignmentDateRangeTriggers();
            }
            if (from < 5) {
              await m.createTable(attendanceSessions);
              await m.createTable(attendanceEntries);
              await _createAttendanceScopeTriggers();
            }
            if (from < 6) {
              await m.createTable(attendanceCorrections);
            }
          });
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
          await customStatement('PRAGMA journal_mode = WAL');

          final violations =
              await customSelect('PRAGMA foreign_key_check').get();
          if (violations.isNotEmpty) {
            throw StateError(
              'Database contains foreign-key violations: ${violations.length}',
            );
          }
        },
      );

  Future<void> _createIntegrityTriggers() async {
    await customStatement('''
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

    await customStatement('''
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

    await customStatement('''
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

    await customStatement('''
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
  }
  Future<void> _validateExistingAssignmentDateRanges() async {
    final invalidRows = await customSelect('''
      SELECT id FROM student_assignments
      WHERE effective_to IS NOT NULL AND effective_to <= effective_from
      LIMIT 1
    ''', readsFrom: {}).get();
    if (invalidRows.isNotEmpty) {
      throw StateError(
        'Cannot migrate database: invalid student assignment date range exists.',
      );
    }
  }

  Future<void> _createAssignmentDateRangeTriggers() async {
    await customStatement('''
      CREATE TRIGGER student_assignments_valid_range_insert
      BEFORE INSERT ON student_assignments
      WHEN NEW.effective_to IS NOT NULL
        AND NEW.effective_to <= NEW.effective_from
      BEGIN
        SELECT RAISE(ABORT, 'student assignment effective_to must be after effective_from');
      END
    ''');

    await customStatement('''
      CREATE TRIGGER student_assignments_valid_range_update
      BEFORE UPDATE OF effective_from, effective_to ON student_assignments
      WHEN NEW.effective_to IS NOT NULL
        AND NEW.effective_to <= NEW.effective_from
      BEGIN
        SELECT RAISE(ABORT, 'student assignment effective_to must be after effective_from');
      END
    ''');
  }

  Future<void> _createAssignmentScopeTriggers() async {
    await customStatement('''
      CREATE TRIGGER student_assignments_scope_key_insert
      BEFORE INSERT ON student_assignments
      WHEN NEW.assignment_scope_key != CASE
        WHEN NEW.batch_id IS NULL THEN 'class:' || NEW.class_id
        ELSE 'batch:' || NEW.batch_id
      END
      BEGIN
        SELECT RAISE(ABORT, 'student assignment scope key mismatch');
      END
    ''');

    await customStatement('''
      CREATE TRIGGER student_assignments_scope_key_update
      BEFORE UPDATE OF batch_id, class_id, assignment_scope_key
      ON student_assignments
      WHEN NEW.assignment_scope_key != CASE
        WHEN NEW.batch_id IS NULL THEN 'class:' || NEW.class_id
        ELSE 'batch:' || NEW.batch_id
      END
      BEGIN
        SELECT RAISE(ABORT, 'student assignment scope key mismatch');
      END
    ''');
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final directory = await getApplicationSupportDirectory();
    final file = p.join(directory.path, 'edumanage.sqlite');
    return NativeDatabase.createInBackground(
      File(file),
      setup: (database) {
        database.execute('PRAGMA foreign_keys = ON');
        database.execute('PRAGMA journal_mode = WAL');
      },
    );
  });
}


  Future<void> _createAttendanceScopeTriggers() async {
    await customStatement('''
      CREATE TRIGGER attendance_sessions_scope_insert
      BEFORE INSERT ON attendance_sessions
      WHEN NEW.attendance_scope_key != CASE
        WHEN NEW.batch_id IS NULL THEN 'class:' || NEW.class_id
        ELSE 'batch:' || NEW.batch_id
      END
      BEGIN
        SELECT RAISE(ABORT, 'attendance session scope key mismatch');
      END
    ''');
    await customStatement('''
      CREATE TRIGGER attendance_sessions_scope_update
      BEFORE UPDATE OF class_id, batch_id, attendance_scope_key
      ON attendance_sessions
      WHEN NEW.attendance_scope_key != CASE
        WHEN NEW.batch_id IS NULL THEN 'class:' || NEW.class_id
        ELSE 'batch:' || NEW.batch_id
      END
      BEGIN
        SELECT RAISE(ABORT, 'attendance session scope key mismatch');
      END
    ''');
    await customStatement('''
      CREATE TRIGGER attendance_sessions_batch_class_insert
      BEFORE INSERT ON attendance_sessions
      WHEN NEW.batch_id IS NOT NULL AND NOT EXISTS (
        SELECT 1 FROM batches
        WHERE id = NEW.batch_id AND class_id = NEW.class_id
      )
      BEGIN
        SELECT RAISE(ABORT, 'attendance session batch/class mismatch');
      END
    ''');
    await customStatement('''
      CREATE TRIGGER attendance_sessions_batch_class_update
      BEFORE UPDATE OF batch_id, class_id ON attendance_sessions
      WHEN NEW.batch_id IS NOT NULL AND NOT EXISTS (
        SELECT 1 FROM batches
        WHERE id = NEW.batch_id AND class_id = NEW.class_id
      )
      BEGIN
        SELECT RAISE(ABORT, 'attendance session batch/class mismatch');
      END
    ''');
  }
