import 'package:drift/drift.dart';

import 'app_database.dart';

/// Local-only student persistence. Business workflows should call this DAO
/// rather than writing SQL or persistence logic in widgets.
class StudentsDao {
  StudentsDao(this._db);

  final AppDatabase _db;

  Future<List<Student>> listActive({int limit = 100, int offset = 0}) {
    final safeLimit = limit.clamp(1, 500);
    final safeOffset = offset < 0 ? 0 : offset;

    return (_db.select(_db.students)
          ..where((student) => student.isActive.equals(true))
          ..orderBy([(student) => OrderingTerm.asc(student.fullName)])
          ..limit(safeLimit, offset: safeOffset))
        .get();
  }

  Future<Student?> findById(int id) {
    return (_db.select(_db.students)
          ..where((student) => student.id.equals(id)))
        .getSingleOrNull();
  }

  Future<int> create({
    required String fullName,
    required DateTime joinedAt,
    String? phone,
    String? guardianName,
    String? guardianPhone,
    String? address,
    DateTime? dateOfBirth,
  }) {
    final normalizedName = fullName.trim();
    if (normalizedName.isEmpty) {
      throw ArgumentError.value(fullName, 'fullName', 'Must not be empty.');
    }

    final now = DateTime.now();
    return _db.into(_db.students).insert(
          StudentsCompanion.insert(
            fullName: normalizedName,
            phone: Value(_normalizeOptional(phone)),
            guardianName: Value(_normalizeOptional(guardianName)),
            guardianPhone: Value(_normalizeOptional(guardianPhone)),
            address: Value(_normalizeOptional(address)),
            dateOfBirth: Value(dateOfBirth),
            joinedAt: joinedAt,
            createdAt: Value(now),
            updatedAt: Value(now),
          ),
        );
  }

  Future<bool> updateContactDetails({
    required int id,
    required String fullName,
    String? phone,
    String? guardianName,
    String? guardianPhone,
    String? address,
  }) async {
    final normalizedName = fullName.trim();
    if (normalizedName.isEmpty) {
      throw ArgumentError.value(fullName, 'fullName', 'Must not be empty.');
    }

    final changed = await (_db.update(_db.students)
          ..where((student) => student.id.equals(id)))
        .write(
      StudentsCompanion(
        fullName: Value(normalizedName),
        phone: Value(_normalizeOptional(phone)),
        guardianName: Value(_normalizeOptional(guardianName)),
        guardianPhone: Value(_normalizeOptional(guardianPhone)),
        address: Value(_normalizeOptional(address)),
        updatedAt: Value(DateTime.now()),
      ),
    );
    return changed == 1;
  }

  Future<bool> deactivate(int id) async {
    final changed = await (_db.update(_db.students)
          ..where((student) => student.id.equals(id)))
        .write(
      StudentsCompanion(
        isActive: const Value(false),
        updatedAt: Value(DateTime.now()),
      ),
    );
    return changed == 1;
  }

  String? _normalizeOptional(String? value) {
    final normalized = value?.trim();
    return normalized == null || normalized.isEmpty ? null : normalized;
  }
}
