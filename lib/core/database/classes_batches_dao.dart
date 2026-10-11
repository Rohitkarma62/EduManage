import 'package:drift/drift.dart';

import 'app_database.dart';

/// Local persistence for classes and batches. Records are archived, not
/// permanently deleted, so linked historical records can remain intact.
class ClassesBatchesDao {
  ClassesBatchesDao(this._db);

  final AppDatabase _db;

  Future<int> createClass({
    required String name,
    String? description,
  }) {
    final normalizedName = _requiredName(name, 'name');
    final now = DateTime.now();
    return _db.into(_db.classGroups).insert(
          ClassGroupsCompanion.insert(
            name: normalizedName,
            description: Value(_normalizeOptional(description)),
            createdAt: Value(now),
            updatedAt: Value(now),
          ),
        );
  }

  Future<List<ClassGroup>> listActiveClasses() {
    return (_db.select(_db.classGroups)
          ..where((row) => row.isActive.equals(true))
          ..orderBy([
            (row) => OrderingTerm.asc(row.name),
            (row) => OrderingTerm.asc(row.id),
          ]))
        .get();
  }

  Future<ClassGroup?> findClassById(int id) {
    return (_db.select(_db.classGroups)
          ..where((row) => row.id.equals(id)))
        .getSingleOrNull();
  }

  Future<bool> archiveClass(int id) async {
    final changed = await (_db.update(_db.classGroups)
          ..where((row) => row.id.equals(id) & row.isActive.equals(true)))
        .write(
      ClassGroupsCompanion(
        isActive: const Value(false),
        updatedAt: Value(DateTime.now()),
      ),
    );
    return changed == 1;
  }

  Future<int> createBatch({
    required int classId,
    required String name,
    String? description,
  }) async {
    final normalizedName = _requiredName(name, 'name');
    final parent = await findClassById(classId);
    if (parent == null) {
      throw ArgumentError.value(classId, 'classId', 'Class not found');
    }
    if (!parent.isActive) {
      throw StateError('Cannot add a batch to an archived class.');
    }

    final now = DateTime.now();
    return _db.into(_db.batches).insert(
          BatchesCompanion.insert(
            classId: classId,
            name: normalizedName,
            description: Value(_normalizeOptional(description)),
            createdAt: Value(now),
            updatedAt: Value(now),
          ),
        );
  }

  Future<List<Batche>> listActiveBatches({required int classId}) {
    return (_db.select(_db.batches)
          ..where((row) =>
              row.classId.equals(classId) & row.isActive.equals(true))
          ..orderBy([
            (row) => OrderingTerm.asc(row.name),
            (row) => OrderingTerm.asc(row.id),
          ]))
        .get();
  }

  Future<Batche?> findBatchById(int id) {
    return (_db.select(_db.batches)..where((row) => row.id.equals(id)))
        .getSingleOrNull();
  }

  Future<bool> archiveBatch(int id) async {
    final changed = await (_db.update(_db.batches)
          ..where((row) => row.id.equals(id) & row.isActive.equals(true)))
        .write(
      BatchesCompanion(
        isActive: const Value(false),
        updatedAt: Value(DateTime.now()),
      ),
    );
    return changed == 1;
  }

  String _requiredName(String value, String field) {
    final normalized = value.trim();
    if (normalized.isEmpty) {
      throw ArgumentError.value(value, field, 'Must not be empty.');
    }
    return normalized;
  }

  String? _normalizeOptional(String? value) {
    final normalized = value?.trim();
    return normalized == null || normalized.isEmpty ? null : normalized;
  }
}
