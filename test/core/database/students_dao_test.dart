import 'package:drift/native.dart';
import 'package:edumanage_offline/core/database/app_database.dart';
import 'package:edumanage_offline/core/database/students_dao.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late StudentsDao studentsDao;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    studentsDao = StudentsDao(database);
  });

  tearDown(() async {
    await database.close();
  });

  Future<int> createStudent(
    String name, {
    String? phone,
  }) =>
      studentsDao.create(
        fullName: name,
        joinedAt: DateTime(2026, 4, 1),
        phone: phone,
      );

  test('creates and retrieves a student locally', () async {
    final id = await studentsDao.create(
      fullName: '  Asha Sharma  ',
      joinedAt: DateTime(2026, 4, 1),
      phone: '  9876543210 ',
    );

    final student = await studentsDao.findById(id);

    expect(student, isNotNull);
    expect(student!.fullName, 'Asha Sharma');
    expect(student.phone, '9876543210');
    expect(student.isActive, isTrue);
  });

  test('rejects a blank student name', () {
    expect(
      () => studentsDao.create(
        fullName: '   ',
        joinedAt: DateTime(2026, 4, 1),
      ),
      throwsArgumentError,
    );
  });

  test('normalizes whitespace-only optional fields to null', () async {
    final id = await studentsDao.create(
      fullName: 'Neha Singh',
      joinedAt: DateTime(2026, 4, 1),
      phone: '  ',
      guardianName: '',
      guardianPhone: '   ',
      address: '  ',
    );

    final student = await studentsDao.findById(id);
    expect(student, isNotNull);
    expect(student!.phone, isNull);
    expect(student.guardianName, isNull);
    expect(student.guardianPhone, isNull);
    expect(student.address, isNull);
  });

  test('active student list sorts names and applies limit and offset',
      () async {
    await createStudent('Zoya');
    await createStudent('Aman');
    await createStudent('Meera');

    final page = await studentsDao.listActive(limit: 1, offset: 1);

    expect(page, hasLength(1));
    expect(page.single.fullName, 'Meera');
  });

  test('active student list paginates equal names in stable id order', () async {
    final firstId = await createStudent('Aman');
    final secondId = await createStudent('Aman');
    final thirdId = await createStudent('Aman');

    final firstPage = await studentsDao.listActive(limit: 2, offset: 0);
    final secondPage = await studentsDao.listActive(limit: 2, offset: 2);

    expect(firstPage.map((student) => student.id), [firstId, secondId]);
    expect(secondPage.map((student) => student.id), [thirdId]);
  });

  test('active student list clamps invalid pagination inputs', () async {
    await createStudent('Aman');
    await createStudent('Meera');

    final negativeLimit = await studentsDao.listActive(limit: -10);
    final negativeOffset = await studentsDao.listActive(offset: -10);

    expect(negativeLimit, hasLength(1));
    expect(negativeOffset.map((student) => student.fullName),
        ['Aman', 'Meera']);
  });

  test('contact update trims values and reports whether a row existed',
      () async {
    final id = await createStudent('  Aman  ');

    final updated = await studentsDao.updateContactDetails(
      id: id,
      fullName: '  Aman Kumar ',
      phone: '  9000000000 ',
      guardianName: '  Parent ',
      guardianPhone: ' ',
      address: '  Bhopal  ',
    );

    final student = await studentsDao.findById(id);
    expect(updated, isTrue);
    expect(student!.fullName, 'Aman Kumar');
    expect(student.phone, '9000000000');
    expect(student.guardianName, 'Parent');
    expect(student.guardianPhone, isNull);
    expect(student.address, 'Bhopal');
  });

  test('contact update rejects blank name without changing the record',
      () async {
    final id = await createStudent('Aman', phone: '9000000000');

    await expectLater(
      studentsDao.updateContactDetails(id: id, fullName: '  '),
      throwsArgumentError,
    );

    final student = await studentsDao.findById(id);
    expect(student!.fullName, 'Aman');
    expect(student.phone, '9000000000');
  });

  test('update and deactivate return false for a missing student', () async {
    expect(
      await studentsDao.updateContactDetails(
        id: 999999,
        fullName: 'Missing Student',
      ),
      isFalse,
    );
    expect(await studentsDao.deactivate(999999), isFalse);
  });

  test('deactivation hides a student from the active list but preserves row',
      () async {
    final id = await createStudent('Ravi Verma');

    expect(await studentsDao.deactivate(id), isTrue);
    expect(await studentsDao.listActive(), isEmpty);

    final retained = await studentsDao.findById(id);
    expect(retained, isNotNull);
    expect(retained!.isActive, isFalse);
  });
}
