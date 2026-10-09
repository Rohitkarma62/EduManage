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

  test('deactivation hides a student from the active list but preserves row',
      () async {
    final id = await studentsDao.create(
      fullName: 'Ravi Verma',
      joinedAt: DateTime(2026, 4, 1),
    );

    expect(await studentsDao.deactivate(id), isTrue);
    expect(await studentsDao.listActive(), isEmpty);

    final retained = await studentsDao.findById(id);
    expect(retained, isNotNull);
    expect(retained!.isActive, isFalse);
  });
}
