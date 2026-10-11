import 'package:drift/drift.dart';

class InstituteSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get instituteName => text().withLength(min: 1, max: 160)();
  TextColumn get ownerName => text().nullable().withLength(max: 160)();
  TextColumn get phone => text().nullable().withLength(max: 32)();
  TextColumn get address => text().nullable().withLength(max: 500)();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
  DateTimeColumn get updatedAt => dateTime().clientDefault(DateTime.now)();
}

@TableIndex(name: 'students_name_idx', columns: {#fullName})
@TableIndex(name: 'students_phone_idx', columns: {#phone})
class Students extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get fullName => text().withLength(min: 1, max: 160)();
  TextColumn get phone => text().nullable().withLength(max: 32)();
  TextColumn get guardianName => text().nullable().withLength(max: 160)();
  TextColumn get guardianPhone => text().nullable().withLength(max: 32)();
  TextColumn get address => text().nullable().withLength(max: 500)();
  DateTimeColumn get dateOfBirth => dateTime().nullable()();
  DateTimeColumn get joinedAt => dateTime()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
  DateTimeColumn get updatedAt => dateTime().clientDefault(DateTime.now)();
}

@TableIndex(name: 'class_groups_name_unique', columns: {#name}, unique: true)
class ClassGroups extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().nullable().withLength(max: 500)();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
  DateTimeColumn get updatedAt => dateTime().clientDefault(DateTime.now)();
}

@TableIndex(
  name: 'batches_class_name_unique',
  columns: {#classId, #name},
  unique: true,
)
class Batches extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get classId => integer().references(ClassGroups, #id)();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().nullable().withLength(max: 500)();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
  DateTimeColumn get updatedAt => dateTime().clientDefault(DateTime.now)();
}

@TableIndex(
  name: 'student_assignments_student_start_idx',
  columns: {#studentId, #effectiveFrom},
)
@TableIndex(
  name: 'student_assignments_scope_start_idx',
  columns: {#assignmentScopeKey, #effectiveFrom},
)
class StudentAssignments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get studentId =>
      integer().references(Students, #id, onDelete: KeyAction.restrict)();
  IntColumn get classId =>
      integer().references(ClassGroups, #id, onDelete: KeyAction.restrict)();
  IntColumn get batchId => integer()
      .nullable()
      .references(Batches, #id, onDelete: KeyAction.restrict)();

  // Stable non-null scope: "class:<classId>" or "batch:<batchId>".
  // This avoids SQLite NULL-uniqueness ambiguity in future scoped indexes.
  TextColumn get assignmentScopeKey => text().withLength(min: 1, max: 80)();

  // Assignment validity is [effectiveFrom, effectiveTo); null means no end yet.
  DateTimeColumn get effectiveFrom => dateTime()();
  DateTimeColumn get effectiveTo => dateTime().nullable()();
  TextColumn get changeReason => text().nullable().withLength(max: 500)();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
}


@TableIndex(
  name: 'attendance_sessions_scope_date_unique',
  columns: {#attendanceScopeKey, #attendanceDate},
  unique: true,
)
class AttendanceSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get classId =>
      integer().references(ClassGroups, #id, onDelete: KeyAction.restrict)();
  IntColumn get batchId =>
      integer().nullable().references(Batches, #id, onDelete: KeyAction.restrict)();
  TextColumn get attendanceScopeKey => text().withLength(min: 1, max: 80)();
  DateTimeColumn get attendanceDate => dateTime()();
  BoolColumn get isFinalized => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
  DateTimeColumn get updatedAt => dateTime().clientDefault(DateTime.now)();
}

@TableIndex(
  name: 'attendance_entries_session_student_unique',
  columns: {#sessionId, #studentId},
  unique: true,
)
@TableIndex(
  name: 'attendance_entries_student_idx',
  columns: {#studentId},
)
class AttendanceEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get sessionId => integer()
      .references(AttendanceSessions, #id, onDelete: KeyAction.restrict)();
  IntColumn get studentId =>
      integer().references(Students, #id, onDelete: KeyAction.restrict)();
  TextColumn get status => text().withLength(min: 1, max: 16)();
  TextColumn get correctionReason => text().nullable().withLength(max: 500)();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
  DateTimeColumn get updatedAt => dateTime().clientDefault(DateTime.now)();
}
