import 'package:drift/drift.dart';
import 'app_database.dart';

class StudentAssignmentsDao {
  StudentAssignmentsDao(this.db);
  final AppDatabase db;

  Future<int> assign({
    required int studentId,
    required int classId,
    int? batchId,
    required DateTime effectiveFrom,
    DateTime? effectiveTo,
    String? changeReason,
  }) {
    if (effectiveTo != null && !effectiveTo.isAfter(effectiveFrom)) {
      throw ArgumentError.value(effectiveTo, 'effectiveTo');
    }
    return db.transaction(() async {
      final student = await (db.select(db.students)
            ..where((r) => r.id.equals(studentId)))
          .getSingleOrNull();
      if (student == null) {
        throw ArgumentError.value(studentId, 'studentId', 'Student not found');
      }
      final group = await (db.select(db.classGroups)
            ..where((r) => r.id.equals(classId)))
          .getSingleOrNull();
      if (group == null) {
        throw ArgumentError.value(classId, 'classId', 'Class not found');
      }
      if (batchId != null) {
        final batch = await (db.select(db.batches)
              ..where((r) => r.id.equals(batchId)))
            .getSingleOrNull();
        if (batch == null || batch.classId != classId) {
          throw ArgumentError.value(batchId, 'batchId', 'Batch/class mismatch');
        }
      }
      final current = await (db.select(db.studentAssignments)
            ..where((r) => r.studentId.equals(studentId)))
          .get();
      final conflict = current.any((row) {
        final startsBeforeEnd =
            effectiveTo == null || row.effectiveFrom.isBefore(effectiveTo);
        final endsAfterStart =
            row.effectiveTo == null || row.effectiveTo!.isAfter(effectiveFrom);
        return startsBeforeEnd && endsAfterStart;
      });
      if (conflict) {
        throw StateError('Student assignment intervals must not overlap.');
      }
      final scope = batchId == null ? 'class:$classId' : 'batch:$batchId';
      return db.into(db.studentAssignments).insert(
            StudentAssignmentsCompanion.insert(
              studentId: studentId,
              classId: classId,
              batchId: Value(batchId),
              assignmentScopeKey: scope,
              effectiveFrom: effectiveFrom,
              effectiveTo: Value(effectiveTo),
              changeReason: Value(_clean(changeReason)),
              createdAt: Value(DateTime.now()),
            ),
          );
    });
  }

  String? _clean(String? value) {
    final result = value?.trim();
    return result == null || result.isEmpty ? null : result;
  }
}
