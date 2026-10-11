import 'package:drift/native.dart';
import 'package:edumanage_offline/core/database/app_database.dart';
import 'package:edumanage_offline/core/database/classes_batches_dao.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late ClassesBatchesDao dao;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    dao = ClassesBatchesDao(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('normalizes class and batch names and optional descriptions', () async {
    final classId = await dao.createClass(
      name: '  Class A  ',
      description: '  Science group  ',
    );
    final batchId = await dao.createBatch(
      classId: classId,
      name: '  Morning  ',
      description: '  ',
    );

    final classRow = await dao.findClassById(classId);
    final batchRow = await dao.findBatchById(batchId);
    expect(classRow!.name, 'Class A');
    expect(classRow.description, 'Science group');
    expect(batchRow!.name, 'Morning');
    expect(batchRow.description, isNull);
  });

  test('rejects blank class or batch names without inserting records', () async {
    expect(() => dao.createClass(name: '   '), throwsArgumentError);
    final classId = await dao.createClass(name: 'Class A');
    await expectLater(
      dao.createBatch(classId: classId, name: '  '),
      throwsArgumentError,
    );
    expect(await dao.listActiveClasses(), hasLength(1));
    expect(await dao.listActiveBatches(classId: classId), isEmpty);
  });

  test('class list is sorted and excludes archived classes', () async {
    final zeta = await dao.createClass(name: 'Zeta');
    await dao.createClass(name: 'Alpha');
    await dao.archiveClass(zeta);

    final active = await dao.listActiveClasses();
    expect(active.map((row) => row.name), ['Alpha']);
  });

  test('batch names are scoped to a class', () async {
    final classA = await dao.createClass(name: 'Class A');
    final classB = await dao.createClass(name: 'Class B');
    await dao.createBatch(classId: classA, name: 'Morning');
    await dao.createBatch(classId: classB, name: 'Morning');

    await expectLater(
      dao.createBatch(classId: classA, name: 'Morning'),
      throwsA(isA<Exception>()),
    );
  });

  test('cannot create a batch for a missing or archived class', () async {
    await expectLater(
      dao.createBatch(classId: 999, name: 'Morning'),
      throwsArgumentError,
    );

    final classId = await dao.createClass(name: 'Class A');
    await dao.archiveClass(classId);
    await expectLater(
      dao.createBatch(classId: classId, name: 'Morning'),
      throwsStateError,
    );
  });

  test('archiving preserves class and batch rows and is idempotent', () async {
    final classId = await dao.createClass(name: 'Class A');
    final batchId = await dao.createBatch(classId: classId, name: 'Morning');

    expect(await dao.archiveBatch(batchId), isTrue);
    expect(await dao.archiveBatch(batchId), isFalse);
    expect(await dao.archiveClass(classId), isTrue);
    expect(await dao.archiveClass(classId), isFalse);

    expect((await dao.findBatchById(batchId))!.isActive, isFalse);
    expect((await dao.findClassById(classId))!.isActive, isFalse);
    expect(await dao.listActiveBatches(classId: classId), isEmpty);
  });

  test('returns false when asked to archive a missing record', () async {
    expect(await dao.archiveClass(999), isFalse);
    expect(await dao.archiveBatch(999), isFalse);
  });
}
