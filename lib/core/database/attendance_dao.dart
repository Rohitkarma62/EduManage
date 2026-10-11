import 'package:drift/drift.dart';

import 'app_database.dart';

enum AttendanceStatus { unmarked, present, absent, leave }

/// Local attendance workflow. Leave is excluded from the percentage denominator.
class AttendanceDao {
  AttendanceDao(this._db);
  final AppDatabase _db;

  Future<int> createSession({
    required int classId,
    int? batchId,
    required DateTime attendanceDate,
    required List<int> studentIds,
  }) async {
    if (studentIds.isEmpty) {
      throw ArgumentError.value(studentIds, 'studentIds', 'Must not be empty.');
    }
    if (studentIds.toSet().length != studentIds.length) {
      throw ArgumentError.value(studentIds, 'studentIds', 'Duplicate student IDs.');
    }
    final day = DateTime(attendanceDate.year, attendanceDate.month, attendanceDate.day);
    final scopeKey = batchId == null ? 'class:$classId' : 'batch:$batchId';

    return _db.transaction(() async {
      final classRow = await (_db.select(_db.classGroups)
            ..where((row) => row.id.equals(classId)))
          .getSingleOrNull();
      if (classRow == null) {
        throw ArgumentError.value(classId, 'classId', 'Class not found.');
      }
      if (batchId != null) {
        final batch = await (_db.select(_db.batches)
              ..where((row) =>
                  row.id.equals(batchId) & row.classId.equals(classId)))
            .getSingleOrNull();
        if (batch == null) {
          throw ArgumentError.value(batchId, 'batchId', 'Batch/class mismatch.');
        }
      }

      final sessionId = await _db.into(_db.attendanceSessions).insert(
            AttendanceSessionsCompanion.insert(
              classId: classId,
              batchId: Value(batchId),
              attendanceScopeKey: scopeKey,
              attendanceDate: day,
            ),
          );

      for (final studentId in studentIds) {
        final student = await (_db.select(_db.students)
              ..where((row) =>
                  row.id.equals(studentId) & row.isActive.equals(true)))
            .getSingleOrNull();
        if (student == null) {
          throw ArgumentError.value(studentId, 'studentIds', 'Active student not found.');
        }
        final assignment = await (_db.select(_db.studentAssignments)
              ..where((row) =>
                  row.studentId.equals(studentId) &
                  row.classId.equals(classId) &
                  (batchId == null
                      ? row.batchId.isNull()
                      : row.batchId.equals(batchId)) &
                  row.effectiveFrom.isSmallerOrEqualValue(day) &
                  (row.effectiveTo.isNull() |
                      row.effectiveTo.isBiggerThanValue(day)))
              ..limit(1))
            .getSingleOrNull();
        if (assignment == null) {
          throw StateError(
            'Student $studentId has no matching assignment on ${day.toIso8601String()}.',
          );
        }
        await _db.into(_db.attendanceEntries).insert(
              AttendanceEntriesCompanion.insert(
                sessionId: sessionId,
                studentId: studentId,
                status: AttendanceStatus.unmarked.name,
              ),
            );
      }
      return sessionId;
    });
  }

  Future<List<AttendanceEntry>> listEntries(int sessionId) {
    return (_db.select(_db.attendanceEntries)
          ..where((row) => row.sessionId.equals(sessionId))
          ..orderBy([(row) => OrderingTerm.asc(row.studentId)]))
        .get();
  }

  Future<void> setStatus({
    required int sessionId,
    required int studentId,
    required AttendanceStatus status,
    bool confirmHistoricalEdit = false,
    String? correctionReason,
  }) async {
    final session = await (_db.select(_db.attendanceSessions)
          ..where((row) => row.id.equals(sessionId)))
        .getSingleOrNull();
    if (session == null) {
      throw ArgumentError.value(sessionId, 'sessionId', 'Session not found.');
    }
    String? normalizedReason;
    if (session.isFinalized) {
      if (!confirmHistoricalEdit) {
        throw StateError('Historical attendance edit requires confirmation.');
      }
      normalizedReason = correctionReason?.trim();
      if (normalizedReason == null || normalizedReason.isEmpty) {
        throw ArgumentError.value(
          correctionReason, 'correctionReason',
          'A reason is required for historical correction.',
        );
      }
    }
    final changed = await (_db.update(_db.attendanceEntries)
          ..where((row) =>
              row.sessionId.equals(sessionId) & row.studentId.equals(studentId)))
        .write(AttendanceEntriesCompanion(
      status: Value(status.name),
      correctionReason: Value(normalizedReason),
      updatedAt: Value(DateTime.now()),
    ));
    if (changed != 1) {
      throw ArgumentError.value(studentId, 'studentId', 'Attendance entry not found.');
    }
  }

  Future<void> finalizeSession({
    required int sessionId,
    bool confirmIncomplete = false,
  }) async {
    await _db.transaction(() async {
      final session = await (_db.select(_db.attendanceSessions)
            ..where((row) => row.id.equals(sessionId)))
          .getSingleOrNull();
      if (session == null) {
        throw ArgumentError.value(sessionId, 'sessionId', 'Session not found.');
      }
      if (session.isFinalized) return;
      final unmarked = await (_db.select(_db.attendanceEntries)
            ..where((row) =>
                row.sessionId.equals(sessionId) &
                row.status.equals(AttendanceStatus.unmarked.name)))
          .get();
      if (unmarked.isNotEmpty && !confirmIncomplete) {
        throw StateError('Attendance is incomplete; explicit confirmation is required.');
      }
      await (_db.update(_db.attendanceSessions)
            ..where((row) => row.id.equals(sessionId)))
          .write(AttendanceSessionsCompanion(
        isFinalized: const Value(true),
        updatedAt: Value(DateTime.now()),
      ));
    });
  }

  Future<double?> attendancePercentage(int sessionId) async {
    final entries = await listEntries(sessionId);
    var present = 0;
    var denominator = 0;
    for (final entry in entries) {
      switch (entry.status) {
        case 'present':
          present++;
          denominator++;
          break;
        case 'absent':
          denominator++;
          break;
        case 'leave':
        case 'unmarked':
          break;
        default:
          throw StateError('Unknown stored attendance status: ${entry.status}');
      }
    }
    if (denominator == 0) return null;
    return present * 100 / denominator;
  }
}
