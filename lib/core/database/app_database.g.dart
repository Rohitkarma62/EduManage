// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $InstituteSettingsTable extends InstituteSettings
    with TableInfo<$InstituteSettingsTable, InstituteSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InstituteSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _instituteNameMeta =
      const VerificationMeta('instituteName');
  @override
  late final GeneratedColumn<String> instituteName = GeneratedColumn<String>(
      'institute_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 160),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _ownerNameMeta =
      const VerificationMeta('ownerName');
  @override
  late final GeneratedColumn<String> ownerName = GeneratedColumn<String>(
      'owner_name', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 160),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 500),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: DateTime.now);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: DateTime.now);
  @override
  List<GeneratedColumn> get $columns =>
      [id, instituteName, ownerName, phone, address, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'institute_settings';
  @override
  VerificationContext validateIntegrity(Insertable<InstituteSetting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('institute_name')) {
      context.handle(
          _instituteNameMeta,
          instituteName.isAcceptableOrUnknown(
              data['institute_name']!, _instituteNameMeta));
    } else if (isInserting) {
      context.missing(_instituteNameMeta);
    }
    if (data.containsKey('owner_name')) {
      context.handle(_ownerNameMeta,
          ownerName.isAcceptableOrUnknown(data['owner_name']!, _ownerNameMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InstituteSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InstituteSetting(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      instituteName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}institute_name'])!,
      ownerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}owner_name']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $InstituteSettingsTable createAlias(String alias) {
    return $InstituteSettingsTable(attachedDatabase, alias);
  }
}

class InstituteSetting extends DataClass
    implements Insertable<InstituteSetting> {
  final int id;
  final String instituteName;
  final String? ownerName;
  final String? phone;
  final String? address;
  final DateTime createdAt;
  final DateTime updatedAt;
  const InstituteSetting(
      {required this.id,
      required this.instituteName,
      this.ownerName,
      this.phone,
      this.address,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['institute_name'] = Variable<String>(instituteName);
    if (!nullToAbsent || ownerName != null) {
      map['owner_name'] = Variable<String>(ownerName);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  InstituteSettingsCompanion toCompanion(bool nullToAbsent) {
    return InstituteSettingsCompanion(
      id: Value(id),
      instituteName: Value(instituteName),
      ownerName: ownerName == null && nullToAbsent
          ? const Value.absent()
          : Value(ownerName),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory InstituteSetting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InstituteSetting(
      id: serializer.fromJson<int>(json['id']),
      instituteName: serializer.fromJson<String>(json['instituteName']),
      ownerName: serializer.fromJson<String?>(json['ownerName']),
      phone: serializer.fromJson<String?>(json['phone']),
      address: serializer.fromJson<String?>(json['address']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'instituteName': serializer.toJson<String>(instituteName),
      'ownerName': serializer.toJson<String?>(ownerName),
      'phone': serializer.toJson<String?>(phone),
      'address': serializer.toJson<String?>(address),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  InstituteSetting copyWith(
          {int? id,
          String? instituteName,
          Value<String?> ownerName = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          Value<String?> address = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      InstituteSetting(
        id: id ?? this.id,
        instituteName: instituteName ?? this.instituteName,
        ownerName: ownerName.present ? ownerName.value : this.ownerName,
        phone: phone.present ? phone.value : this.phone,
        address: address.present ? address.value : this.address,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  InstituteSetting copyWithCompanion(InstituteSettingsCompanion data) {
    return InstituteSetting(
      id: data.id.present ? data.id.value : this.id,
      instituteName: data.instituteName.present
          ? data.instituteName.value
          : this.instituteName,
      ownerName: data.ownerName.present ? data.ownerName.value : this.ownerName,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InstituteSetting(')
          ..write('id: $id, ')
          ..write('instituteName: $instituteName, ')
          ..write('ownerName: $ownerName, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, instituteName, ownerName, phone, address, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InstituteSetting &&
          other.id == this.id &&
          other.instituteName == this.instituteName &&
          other.ownerName == this.ownerName &&
          other.phone == this.phone &&
          other.address == this.address &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class InstituteSettingsCompanion extends UpdateCompanion<InstituteSetting> {
  final Value<int> id;
  final Value<String> instituteName;
  final Value<String?> ownerName;
  final Value<String?> phone;
  final Value<String?> address;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const InstituteSettingsCompanion({
    this.id = const Value.absent(),
    this.instituteName = const Value.absent(),
    this.ownerName = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  InstituteSettingsCompanion.insert({
    this.id = const Value.absent(),
    required String instituteName,
    this.ownerName = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : instituteName = Value(instituteName);
  static Insertable<InstituteSetting> custom({
    Expression<int>? id,
    Expression<String>? instituteName,
    Expression<String>? ownerName,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (instituteName != null) 'institute_name': instituteName,
      if (ownerName != null) 'owner_name': ownerName,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  InstituteSettingsCompanion copyWith(
      {Value<int>? id,
      Value<String>? instituteName,
      Value<String?>? ownerName,
      Value<String?>? phone,
      Value<String?>? address,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return InstituteSettingsCompanion(
      id: id ?? this.id,
      instituteName: instituteName ?? this.instituteName,
      ownerName: ownerName ?? this.ownerName,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (instituteName.present) {
      map['institute_name'] = Variable<String>(instituteName.value);
    }
    if (ownerName.present) {
      map['owner_name'] = Variable<String>(ownerName.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InstituteSettingsCompanion(')
          ..write('id: $id, ')
          ..write('instituteName: $instituteName, ')
          ..write('ownerName: $ownerName, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $StudentsTable extends Students with TableInfo<$StudentsTable, Student> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _fullNameMeta =
      const VerificationMeta('fullName');
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
      'full_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 160),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _guardianNameMeta =
      const VerificationMeta('guardianName');
  @override
  late final GeneratedColumn<String> guardianName = GeneratedColumn<String>(
      'guardian_name', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 160),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _guardianPhoneMeta =
      const VerificationMeta('guardianPhone');
  @override
  late final GeneratedColumn<String> guardianPhone = GeneratedColumn<String>(
      'guardian_phone', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 500),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _dateOfBirthMeta =
      const VerificationMeta('dateOfBirth');
  @override
  late final GeneratedColumn<DateTime> dateOfBirth = GeneratedColumn<DateTime>(
      'date_of_birth', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _joinedAtMeta =
      const VerificationMeta('joinedAt');
  @override
  late final GeneratedColumn<DateTime> joinedAt = GeneratedColumn<DateTime>(
      'joined_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: DateTime.now);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: DateTime.now);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        fullName,
        phone,
        guardianName,
        guardianPhone,
        address,
        dateOfBirth,
        joinedAt,
        isActive,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'students';
  @override
  VerificationContext validateIntegrity(Insertable<Student> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('full_name')) {
      context.handle(_fullNameMeta,
          fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta));
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('guardian_name')) {
      context.handle(
          _guardianNameMeta,
          guardianName.isAcceptableOrUnknown(
              data['guardian_name']!, _guardianNameMeta));
    }
    if (data.containsKey('guardian_phone')) {
      context.handle(
          _guardianPhoneMeta,
          guardianPhone.isAcceptableOrUnknown(
              data['guardian_phone']!, _guardianPhoneMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
          _dateOfBirthMeta,
          dateOfBirth.isAcceptableOrUnknown(
              data['date_of_birth']!, _dateOfBirthMeta));
    }
    if (data.containsKey('joined_at')) {
      context.handle(_joinedAtMeta,
          joinedAt.isAcceptableOrUnknown(data['joined_at']!, _joinedAtMeta));
    } else if (isInserting) {
      context.missing(_joinedAtMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Student map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Student(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      fullName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}full_name'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      guardianName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}guardian_name']),
      guardianPhone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}guardian_phone']),
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      dateOfBirth: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date_of_birth']),
      joinedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}joined_at'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $StudentsTable createAlias(String alias) {
    return $StudentsTable(attachedDatabase, alias);
  }
}

class Student extends DataClass implements Insertable<Student> {
  final int id;
  final String fullName;
  final String? phone;
  final String? guardianName;
  final String? guardianPhone;
  final String? address;
  final DateTime? dateOfBirth;
  final DateTime joinedAt;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Student(
      {required this.id,
      required this.fullName,
      this.phone,
      this.guardianName,
      this.guardianPhone,
      this.address,
      this.dateOfBirth,
      required this.joinedAt,
      required this.isActive,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['full_name'] = Variable<String>(fullName);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || guardianName != null) {
      map['guardian_name'] = Variable<String>(guardianName);
    }
    if (!nullToAbsent || guardianPhone != null) {
      map['guardian_phone'] = Variable<String>(guardianPhone);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || dateOfBirth != null) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth);
    }
    map['joined_at'] = Variable<DateTime>(joinedAt);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  StudentsCompanion toCompanion(bool nullToAbsent) {
    return StudentsCompanion(
      id: Value(id),
      fullName: Value(fullName),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      guardianName: guardianName == null && nullToAbsent
          ? const Value.absent()
          : Value(guardianName),
      guardianPhone: guardianPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(guardianPhone),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      dateOfBirth: dateOfBirth == null && nullToAbsent
          ? const Value.absent()
          : Value(dateOfBirth),
      joinedAt: Value(joinedAt),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Student.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Student(
      id: serializer.fromJson<int>(json['id']),
      fullName: serializer.fromJson<String>(json['fullName']),
      phone: serializer.fromJson<String?>(json['phone']),
      guardianName: serializer.fromJson<String?>(json['guardianName']),
      guardianPhone: serializer.fromJson<String?>(json['guardianPhone']),
      address: serializer.fromJson<String?>(json['address']),
      dateOfBirth: serializer.fromJson<DateTime?>(json['dateOfBirth']),
      joinedAt: serializer.fromJson<DateTime>(json['joinedAt']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fullName': serializer.toJson<String>(fullName),
      'phone': serializer.toJson<String?>(phone),
      'guardianName': serializer.toJson<String?>(guardianName),
      'guardianPhone': serializer.toJson<String?>(guardianPhone),
      'address': serializer.toJson<String?>(address),
      'dateOfBirth': serializer.toJson<DateTime?>(dateOfBirth),
      'joinedAt': serializer.toJson<DateTime>(joinedAt),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Student copyWith(
          {int? id,
          String? fullName,
          Value<String?> phone = const Value.absent(),
          Value<String?> guardianName = const Value.absent(),
          Value<String?> guardianPhone = const Value.absent(),
          Value<String?> address = const Value.absent(),
          Value<DateTime?> dateOfBirth = const Value.absent(),
          DateTime? joinedAt,
          bool? isActive,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Student(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        phone: phone.present ? phone.value : this.phone,
        guardianName:
            guardianName.present ? guardianName.value : this.guardianName,
        guardianPhone:
            guardianPhone.present ? guardianPhone.value : this.guardianPhone,
        address: address.present ? address.value : this.address,
        dateOfBirth: dateOfBirth.present ? dateOfBirth.value : this.dateOfBirth,
        joinedAt: joinedAt ?? this.joinedAt,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Student copyWithCompanion(StudentsCompanion data) {
    return Student(
      id: data.id.present ? data.id.value : this.id,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      phone: data.phone.present ? data.phone.value : this.phone,
      guardianName: data.guardianName.present
          ? data.guardianName.value
          : this.guardianName,
      guardianPhone: data.guardianPhone.present
          ? data.guardianPhone.value
          : this.guardianPhone,
      address: data.address.present ? data.address.value : this.address,
      dateOfBirth:
          data.dateOfBirth.present ? data.dateOfBirth.value : this.dateOfBirth,
      joinedAt: data.joinedAt.present ? data.joinedAt.value : this.joinedAt,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Student(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('phone: $phone, ')
          ..write('guardianName: $guardianName, ')
          ..write('guardianPhone: $guardianPhone, ')
          ..write('address: $address, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('joinedAt: $joinedAt, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      fullName,
      phone,
      guardianName,
      guardianPhone,
      address,
      dateOfBirth,
      joinedAt,
      isActive,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Student &&
          other.id == this.id &&
          other.fullName == this.fullName &&
          other.phone == this.phone &&
          other.guardianName == this.guardianName &&
          other.guardianPhone == this.guardianPhone &&
          other.address == this.address &&
          other.dateOfBirth == this.dateOfBirth &&
          other.joinedAt == this.joinedAt &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class StudentsCompanion extends UpdateCompanion<Student> {
  final Value<int> id;
  final Value<String> fullName;
  final Value<String?> phone;
  final Value<String?> guardianName;
  final Value<String?> guardianPhone;
  final Value<String?> address;
  final Value<DateTime?> dateOfBirth;
  final Value<DateTime> joinedAt;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const StudentsCompanion({
    this.id = const Value.absent(),
    this.fullName = const Value.absent(),
    this.phone = const Value.absent(),
    this.guardianName = const Value.absent(),
    this.guardianPhone = const Value.absent(),
    this.address = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.joinedAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  StudentsCompanion.insert({
    this.id = const Value.absent(),
    required String fullName,
    this.phone = const Value.absent(),
    this.guardianName = const Value.absent(),
    this.guardianPhone = const Value.absent(),
    this.address = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    required DateTime joinedAt,
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : fullName = Value(fullName),
        joinedAt = Value(joinedAt);
  static Insertable<Student> custom({
    Expression<int>? id,
    Expression<String>? fullName,
    Expression<String>? phone,
    Expression<String>? guardianName,
    Expression<String>? guardianPhone,
    Expression<String>? address,
    Expression<DateTime>? dateOfBirth,
    Expression<DateTime>? joinedAt,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fullName != null) 'full_name': fullName,
      if (phone != null) 'phone': phone,
      if (guardianName != null) 'guardian_name': guardianName,
      if (guardianPhone != null) 'guardian_phone': guardianPhone,
      if (address != null) 'address': address,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (joinedAt != null) 'joined_at': joinedAt,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  StudentsCompanion copyWith(
      {Value<int>? id,
      Value<String>? fullName,
      Value<String?>? phone,
      Value<String?>? guardianName,
      Value<String?>? guardianPhone,
      Value<String?>? address,
      Value<DateTime?>? dateOfBirth,
      Value<DateTime>? joinedAt,
      Value<bool>? isActive,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return StudentsCompanion(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      guardianName: guardianName ?? this.guardianName,
      guardianPhone: guardianPhone ?? this.guardianPhone,
      address: address ?? this.address,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      joinedAt: joinedAt ?? this.joinedAt,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (guardianName.present) {
      map['guardian_name'] = Variable<String>(guardianName.value);
    }
    if (guardianPhone.present) {
      map['guardian_phone'] = Variable<String>(guardianPhone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth.value);
    }
    if (joinedAt.present) {
      map['joined_at'] = Variable<DateTime>(joinedAt.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentsCompanion(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('phone: $phone, ')
          ..write('guardianName: $guardianName, ')
          ..write('guardianPhone: $guardianPhone, ')
          ..write('address: $address, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('joinedAt: $joinedAt, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ClassGroupsTable extends ClassGroups
    with TableInfo<$ClassGroupsTable, ClassGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClassGroupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 500),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: DateTime.now);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: DateTime.now);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, description, isActive, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'class_groups';
  @override
  VerificationContext validateIntegrity(Insertable<ClassGroup> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ClassGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClassGroup(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ClassGroupsTable createAlias(String alias) {
    return $ClassGroupsTable(attachedDatabase, alias);
  }
}

class ClassGroup extends DataClass implements Insertable<ClassGroup> {
  final int id;
  final String name;
  final String? description;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ClassGroup(
      {required this.id,
      required this.name,
      this.description,
      required this.isActive,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ClassGroupsCompanion toCompanion(bool nullToAbsent) {
    return ClassGroupsCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ClassGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClassGroup(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ClassGroup copyWith(
          {int? id,
          String? name,
          Value<String?> description = const Value.absent(),
          bool? isActive,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      ClassGroup(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  ClassGroup copyWithCompanion(ClassGroupsCompanion data) {
    return ClassGroup(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClassGroup(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, description, isActive, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClassGroup &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ClassGroupsCompanion extends UpdateCompanion<ClassGroup> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ClassGroupsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ClassGroupsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<ClassGroup> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ClassGroupsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<bool>? isActive,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return ClassGroupsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClassGroupsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $BatchesTable extends Batches with TableInfo<$BatchesTable, Batche> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BatchesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _classIdMeta =
      const VerificationMeta('classId');
  @override
  late final GeneratedColumn<int> classId = GeneratedColumn<int>(
      'class_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES class_groups (id)'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 500),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: DateTime.now);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: DateTime.now);
  @override
  List<GeneratedColumn> get $columns =>
      [id, classId, name, description, isActive, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'batches';
  @override
  VerificationContext validateIntegrity(Insertable<Batche> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('class_id')) {
      context.handle(_classIdMeta,
          classId.isAcceptableOrUnknown(data['class_id']!, _classIdMeta));
    } else if (isInserting) {
      context.missing(_classIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Batche map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Batche(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      classId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}class_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $BatchesTable createAlias(String alias) {
    return $BatchesTable(attachedDatabase, alias);
  }
}

class Batche extends DataClass implements Insertable<Batche> {
  final int id;
  final int classId;
  final String name;
  final String? description;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Batche(
      {required this.id,
      required this.classId,
      required this.name,
      this.description,
      required this.isActive,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['class_id'] = Variable<int>(classId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BatchesCompanion toCompanion(bool nullToAbsent) {
    return BatchesCompanion(
      id: Value(id),
      classId: Value(classId),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Batche.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Batche(
      id: serializer.fromJson<int>(json['id']),
      classId: serializer.fromJson<int>(json['classId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'classId': serializer.toJson<int>(classId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Batche copyWith(
          {int? id,
          int? classId,
          String? name,
          Value<String?> description = const Value.absent(),
          bool? isActive,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Batche(
        id: id ?? this.id,
        classId: classId ?? this.classId,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Batche copyWithCompanion(BatchesCompanion data) {
    return Batche(
      id: data.id.present ? data.id.value : this.id,
      classId: data.classId.present ? data.classId.value : this.classId,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Batche(')
          ..write('id: $id, ')
          ..write('classId: $classId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, classId, name, description, isActive, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Batche &&
          other.id == this.id &&
          other.classId == this.classId &&
          other.name == this.name &&
          other.description == this.description &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BatchesCompanion extends UpdateCompanion<Batche> {
  final Value<int> id;
  final Value<int> classId;
  final Value<String> name;
  final Value<String?> description;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const BatchesCompanion({
    this.id = const Value.absent(),
    this.classId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  BatchesCompanion.insert({
    this.id = const Value.absent(),
    required int classId,
    required String name,
    this.description = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : classId = Value(classId),
        name = Value(name);
  static Insertable<Batche> custom({
    Expression<int>? id,
    Expression<int>? classId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (classId != null) 'class_id': classId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  BatchesCompanion copyWith(
      {Value<int>? id,
      Value<int>? classId,
      Value<String>? name,
      Value<String?>? description,
      Value<bool>? isActive,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return BatchesCompanion(
      id: id ?? this.id,
      classId: classId ?? this.classId,
      name: name ?? this.name,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (classId.present) {
      map['class_id'] = Variable<int>(classId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BatchesCompanion(')
          ..write('id: $id, ')
          ..write('classId: $classId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $StudentAssignmentsTable extends StudentAssignments
    with TableInfo<$StudentAssignmentsTable, StudentAssignment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentAssignmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _studentIdMeta =
      const VerificationMeta('studentId');
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
      'student_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES students (id) ON DELETE RESTRICT'));
  static const VerificationMeta _classIdMeta =
      const VerificationMeta('classId');
  @override
  late final GeneratedColumn<int> classId = GeneratedColumn<int>(
      'class_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES class_groups (id) ON DELETE RESTRICT'));
  static const VerificationMeta _batchIdMeta =
      const VerificationMeta('batchId');
  @override
  late final GeneratedColumn<int> batchId = GeneratedColumn<int>(
      'batch_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES batches (id) ON DELETE RESTRICT'));
  static const VerificationMeta _assignmentScopeKeyMeta =
      const VerificationMeta('assignmentScopeKey');
  @override
  late final GeneratedColumn<String> assignmentScopeKey =
      GeneratedColumn<String>('assignment_scope_key', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
              minTextLength: 1, maxTextLength: 80),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  static const VerificationMeta _effectiveFromMeta =
      const VerificationMeta('effectiveFrom');
  @override
  late final GeneratedColumn<DateTime> effectiveFrom =
      GeneratedColumn<DateTime>('effective_from', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _effectiveToMeta =
      const VerificationMeta('effectiveTo');
  @override
  late final GeneratedColumn<DateTime> effectiveTo = GeneratedColumn<DateTime>(
      'effective_to', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _changeReasonMeta =
      const VerificationMeta('changeReason');
  @override
  late final GeneratedColumn<String> changeReason = GeneratedColumn<String>(
      'change_reason', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 500),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: DateTime.now);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        studentId,
        classId,
        batchId,
        assignmentScopeKey,
        effectiveFrom,
        effectiveTo,
        changeReason,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'student_assignments';
  @override
  VerificationContext validateIntegrity(Insertable<StudentAssignment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('student_id')) {
      context.handle(_studentIdMeta,
          studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta));
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('class_id')) {
      context.handle(_classIdMeta,
          classId.isAcceptableOrUnknown(data['class_id']!, _classIdMeta));
    } else if (isInserting) {
      context.missing(_classIdMeta);
    }
    if (data.containsKey('batch_id')) {
      context.handle(_batchIdMeta,
          batchId.isAcceptableOrUnknown(data['batch_id']!, _batchIdMeta));
    }
    if (data.containsKey('assignment_scope_key')) {
      context.handle(
          _assignmentScopeKeyMeta,
          assignmentScopeKey.isAcceptableOrUnknown(
              data['assignment_scope_key']!, _assignmentScopeKeyMeta));
    } else if (isInserting) {
      context.missing(_assignmentScopeKeyMeta);
    }
    if (data.containsKey('effective_from')) {
      context.handle(
          _effectiveFromMeta,
          effectiveFrom.isAcceptableOrUnknown(
              data['effective_from']!, _effectiveFromMeta));
    } else if (isInserting) {
      context.missing(_effectiveFromMeta);
    }
    if (data.containsKey('effective_to')) {
      context.handle(
          _effectiveToMeta,
          effectiveTo.isAcceptableOrUnknown(
              data['effective_to']!, _effectiveToMeta));
    }
    if (data.containsKey('change_reason')) {
      context.handle(
          _changeReasonMeta,
          changeReason.isAcceptableOrUnknown(
              data['change_reason']!, _changeReasonMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudentAssignment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudentAssignment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      studentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}student_id'])!,
      classId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}class_id'])!,
      batchId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}batch_id']),
      assignmentScopeKey: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}assignment_scope_key'])!,
      effectiveFrom: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}effective_from'])!,
      effectiveTo: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}effective_to']),
      changeReason: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}change_reason']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $StudentAssignmentsTable createAlias(String alias) {
    return $StudentAssignmentsTable(attachedDatabase, alias);
  }
}

class StudentAssignment extends DataClass
    implements Insertable<StudentAssignment> {
  final int id;
  final int studentId;
  final int classId;
  final int? batchId;
  final String assignmentScopeKey;
  final DateTime effectiveFrom;
  final DateTime? effectiveTo;
  final String? changeReason;
  final DateTime createdAt;
  const StudentAssignment(
      {required this.id,
      required this.studentId,
      required this.classId,
      this.batchId,
      required this.assignmentScopeKey,
      required this.effectiveFrom,
      this.effectiveTo,
      this.changeReason,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['student_id'] = Variable<int>(studentId);
    map['class_id'] = Variable<int>(classId);
    if (!nullToAbsent || batchId != null) {
      map['batch_id'] = Variable<int>(batchId);
    }
    map['assignment_scope_key'] = Variable<String>(assignmentScopeKey);
    map['effective_from'] = Variable<DateTime>(effectiveFrom);
    if (!nullToAbsent || effectiveTo != null) {
      map['effective_to'] = Variable<DateTime>(effectiveTo);
    }
    if (!nullToAbsent || changeReason != null) {
      map['change_reason'] = Variable<String>(changeReason);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  StudentAssignmentsCompanion toCompanion(bool nullToAbsent) {
    return StudentAssignmentsCompanion(
      id: Value(id),
      studentId: Value(studentId),
      classId: Value(classId),
      batchId: batchId == null && nullToAbsent
          ? const Value.absent()
          : Value(batchId),
      assignmentScopeKey: Value(assignmentScopeKey),
      effectiveFrom: Value(effectiveFrom),
      effectiveTo: effectiveTo == null && nullToAbsent
          ? const Value.absent()
          : Value(effectiveTo),
      changeReason: changeReason == null && nullToAbsent
          ? const Value.absent()
          : Value(changeReason),
      createdAt: Value(createdAt),
    );
  }

  factory StudentAssignment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudentAssignment(
      id: serializer.fromJson<int>(json['id']),
      studentId: serializer.fromJson<int>(json['studentId']),
      classId: serializer.fromJson<int>(json['classId']),
      batchId: serializer.fromJson<int?>(json['batchId']),
      assignmentScopeKey:
          serializer.fromJson<String>(json['assignmentScopeKey']),
      effectiveFrom: serializer.fromJson<DateTime>(json['effectiveFrom']),
      effectiveTo: serializer.fromJson<DateTime?>(json['effectiveTo']),
      changeReason: serializer.fromJson<String?>(json['changeReason']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'studentId': serializer.toJson<int>(studentId),
      'classId': serializer.toJson<int>(classId),
      'batchId': serializer.toJson<int?>(batchId),
      'assignmentScopeKey': serializer.toJson<String>(assignmentScopeKey),
      'effectiveFrom': serializer.toJson<DateTime>(effectiveFrom),
      'effectiveTo': serializer.toJson<DateTime?>(effectiveTo),
      'changeReason': serializer.toJson<String?>(changeReason),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  StudentAssignment copyWith(
          {int? id,
          int? studentId,
          int? classId,
          Value<int?> batchId = const Value.absent(),
          String? assignmentScopeKey,
          DateTime? effectiveFrom,
          Value<DateTime?> effectiveTo = const Value.absent(),
          Value<String?> changeReason = const Value.absent(),
          DateTime? createdAt}) =>
      StudentAssignment(
        id: id ?? this.id,
        studentId: studentId ?? this.studentId,
        classId: classId ?? this.classId,
        batchId: batchId.present ? batchId.value : this.batchId,
        assignmentScopeKey: assignmentScopeKey ?? this.assignmentScopeKey,
        effectiveFrom: effectiveFrom ?? this.effectiveFrom,
        effectiveTo: effectiveTo.present ? effectiveTo.value : this.effectiveTo,
        changeReason:
            changeReason.present ? changeReason.value : this.changeReason,
        createdAt: createdAt ?? this.createdAt,
      );
  StudentAssignment copyWithCompanion(StudentAssignmentsCompanion data) {
    return StudentAssignment(
      id: data.id.present ? data.id.value : this.id,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      classId: data.classId.present ? data.classId.value : this.classId,
      batchId: data.batchId.present ? data.batchId.value : this.batchId,
      assignmentScopeKey: data.assignmentScopeKey.present
          ? data.assignmentScopeKey.value
          : this.assignmentScopeKey,
      effectiveFrom: data.effectiveFrom.present
          ? data.effectiveFrom.value
          : this.effectiveFrom,
      effectiveTo:
          data.effectiveTo.present ? data.effectiveTo.value : this.effectiveTo,
      changeReason: data.changeReason.present
          ? data.changeReason.value
          : this.changeReason,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudentAssignment(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('classId: $classId, ')
          ..write('batchId: $batchId, ')
          ..write('assignmentScopeKey: $assignmentScopeKey, ')
          ..write('effectiveFrom: $effectiveFrom, ')
          ..write('effectiveTo: $effectiveTo, ')
          ..write('changeReason: $changeReason, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, studentId, classId, batchId,
      assignmentScopeKey, effectiveFrom, effectiveTo, changeReason, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudentAssignment &&
          other.id == this.id &&
          other.studentId == this.studentId &&
          other.classId == this.classId &&
          other.batchId == this.batchId &&
          other.assignmentScopeKey == this.assignmentScopeKey &&
          other.effectiveFrom == this.effectiveFrom &&
          other.effectiveTo == this.effectiveTo &&
          other.changeReason == this.changeReason &&
          other.createdAt == this.createdAt);
}

class StudentAssignmentsCompanion extends UpdateCompanion<StudentAssignment> {
  final Value<int> id;
  final Value<int> studentId;
  final Value<int> classId;
  final Value<int?> batchId;
  final Value<String> assignmentScopeKey;
  final Value<DateTime> effectiveFrom;
  final Value<DateTime?> effectiveTo;
  final Value<String?> changeReason;
  final Value<DateTime> createdAt;
  const StudentAssignmentsCompanion({
    this.id = const Value.absent(),
    this.studentId = const Value.absent(),
    this.classId = const Value.absent(),
    this.batchId = const Value.absent(),
    this.assignmentScopeKey = const Value.absent(),
    this.effectiveFrom = const Value.absent(),
    this.effectiveTo = const Value.absent(),
    this.changeReason = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  StudentAssignmentsCompanion.insert({
    this.id = const Value.absent(),
    required int studentId,
    required int classId,
    this.batchId = const Value.absent(),
    required String assignmentScopeKey,
    required DateTime effectiveFrom,
    this.effectiveTo = const Value.absent(),
    this.changeReason = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : studentId = Value(studentId),
        classId = Value(classId),
        assignmentScopeKey = Value(assignmentScopeKey),
        effectiveFrom = Value(effectiveFrom);
  static Insertable<StudentAssignment> custom({
    Expression<int>? id,
    Expression<int>? studentId,
    Expression<int>? classId,
    Expression<int>? batchId,
    Expression<String>? assignmentScopeKey,
    Expression<DateTime>? effectiveFrom,
    Expression<DateTime>? effectiveTo,
    Expression<String>? changeReason,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studentId != null) 'student_id': studentId,
      if (classId != null) 'class_id': classId,
      if (batchId != null) 'batch_id': batchId,
      if (assignmentScopeKey != null)
        'assignment_scope_key': assignmentScopeKey,
      if (effectiveFrom != null) 'effective_from': effectiveFrom,
      if (effectiveTo != null) 'effective_to': effectiveTo,
      if (changeReason != null) 'change_reason': changeReason,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  StudentAssignmentsCompanion copyWith(
      {Value<int>? id,
      Value<int>? studentId,
      Value<int>? classId,
      Value<int?>? batchId,
      Value<String>? assignmentScopeKey,
      Value<DateTime>? effectiveFrom,
      Value<DateTime?>? effectiveTo,
      Value<String?>? changeReason,
      Value<DateTime>? createdAt}) {
    return StudentAssignmentsCompanion(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      classId: classId ?? this.classId,
      batchId: batchId ?? this.batchId,
      assignmentScopeKey: assignmentScopeKey ?? this.assignmentScopeKey,
      effectiveFrom: effectiveFrom ?? this.effectiveFrom,
      effectiveTo: effectiveTo ?? this.effectiveTo,
      changeReason: changeReason ?? this.changeReason,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (classId.present) {
      map['class_id'] = Variable<int>(classId.value);
    }
    if (batchId.present) {
      map['batch_id'] = Variable<int>(batchId.value);
    }
    if (assignmentScopeKey.present) {
      map['assignment_scope_key'] = Variable<String>(assignmentScopeKey.value);
    }
    if (effectiveFrom.present) {
      map['effective_from'] = Variable<DateTime>(effectiveFrom.value);
    }
    if (effectiveTo.present) {
      map['effective_to'] = Variable<DateTime>(effectiveTo.value);
    }
    if (changeReason.present) {
      map['change_reason'] = Variable<String>(changeReason.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentAssignmentsCompanion(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('classId: $classId, ')
          ..write('batchId: $batchId, ')
          ..write('assignmentScopeKey: $assignmentScopeKey, ')
          ..write('effectiveFrom: $effectiveFrom, ')
          ..write('effectiveTo: $effectiveTo, ')
          ..write('changeReason: $changeReason, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $InstituteSettingsTable instituteSettings =
      $InstituteSettingsTable(this);
  late final $StudentsTable students = $StudentsTable(this);
  late final $ClassGroupsTable classGroups = $ClassGroupsTable(this);
  late final $BatchesTable batches = $BatchesTable(this);
  late final $StudentAssignmentsTable studentAssignments =
      $StudentAssignmentsTable(this);
  late final Index studentsNameIdx = Index('students_name_idx',
      'CREATE INDEX students_name_idx ON students (full_name)');
  late final Index studentsPhoneIdx = Index('students_phone_idx',
      'CREATE INDEX students_phone_idx ON students (phone)');
  late final Index classGroupsNameUnique = Index('class_groups_name_unique',
      'CREATE UNIQUE INDEX class_groups_name_unique ON class_groups (name)');
  late final Index batchesClassNameUnique = Index('batches_class_name_unique',
      'CREATE UNIQUE INDEX batches_class_name_unique ON batches (class_id, name)');
  late final Index studentAssignmentsStudentStartIdx = Index(
      'student_assignments_student_start_idx',
      'CREATE INDEX student_assignments_student_start_idx ON student_assignments (student_id, effective_from)');
  late final Index studentAssignmentsScopeStartIdx = Index(
      'student_assignments_scope_start_idx',
      'CREATE INDEX student_assignments_scope_start_idx ON student_assignments (assignment_scope_key, effective_from)');
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        instituteSettings,
        students,
        classGroups,
        batches,
        studentAssignments,
        studentsNameIdx,
        studentsPhoneIdx,
        classGroupsNameUnique,
        batchesClassNameUnique,
        studentAssignmentsStudentStartIdx,
        studentAssignmentsScopeStartIdx
      ];
}

typedef $$InstituteSettingsTableCreateCompanionBuilder
    = InstituteSettingsCompanion Function({
  Value<int> id,
  required String instituteName,
  Value<String?> ownerName,
  Value<String?> phone,
  Value<String?> address,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$InstituteSettingsTableUpdateCompanionBuilder
    = InstituteSettingsCompanion Function({
  Value<int> id,
  Value<String> instituteName,
  Value<String?> ownerName,
  Value<String?> phone,
  Value<String?> address,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$InstituteSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $InstituteSettingsTable> {
  $$InstituteSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get instituteName => $composableBuilder(
      column: $table.instituteName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ownerName => $composableBuilder(
      column: $table.ownerName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$InstituteSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $InstituteSettingsTable> {
  $$InstituteSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get instituteName => $composableBuilder(
      column: $table.instituteName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ownerName => $composableBuilder(
      column: $table.ownerName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$InstituteSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InstituteSettingsTable> {
  $$InstituteSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get instituteName => $composableBuilder(
      column: $table.instituteName, builder: (column) => column);

  GeneratedColumn<String> get ownerName =>
      $composableBuilder(column: $table.ownerName, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$InstituteSettingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $InstituteSettingsTable,
    InstituteSetting,
    $$InstituteSettingsTableFilterComposer,
    $$InstituteSettingsTableOrderingComposer,
    $$InstituteSettingsTableAnnotationComposer,
    $$InstituteSettingsTableCreateCompanionBuilder,
    $$InstituteSettingsTableUpdateCompanionBuilder,
    (
      InstituteSetting,
      BaseReferences<_$AppDatabase, $InstituteSettingsTable, InstituteSetting>
    ),
    InstituteSetting,
    PrefetchHooks Function()> {
  $$InstituteSettingsTableTableManager(
      _$AppDatabase db, $InstituteSettingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InstituteSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InstituteSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InstituteSettingsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> instituteName = const Value.absent(),
            Value<String?> ownerName = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              InstituteSettingsCompanion(
            id: id,
            instituteName: instituteName,
            ownerName: ownerName,
            phone: phone,
            address: address,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String instituteName,
            Value<String?> ownerName = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              InstituteSettingsCompanion.insert(
            id: id,
            instituteName: instituteName,
            ownerName: ownerName,
            phone: phone,
            address: address,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$InstituteSettingsTable, InstituteSetting>(
                        table),
                    BaseReferences<_$AppDatabase, $InstituteSettingsTable,
                        InstituteSetting>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$InstituteSettingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $InstituteSettingsTable,
    InstituteSetting,
    $$InstituteSettingsTableFilterComposer,
    $$InstituteSettingsTableOrderingComposer,
    $$InstituteSettingsTableAnnotationComposer,
    $$InstituteSettingsTableCreateCompanionBuilder,
    $$InstituteSettingsTableUpdateCompanionBuilder,
    (
      InstituteSetting,
      BaseReferences<_$AppDatabase, $InstituteSettingsTable, InstituteSetting>
    ),
    InstituteSetting,
    PrefetchHooks Function()>;
typedef $$StudentsTableCreateCompanionBuilder = StudentsCompanion Function({
  Value<int> id,
  required String fullName,
  Value<String?> phone,
  Value<String?> guardianName,
  Value<String?> guardianPhone,
  Value<String?> address,
  Value<DateTime?> dateOfBirth,
  required DateTime joinedAt,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$StudentsTableUpdateCompanionBuilder = StudentsCompanion Function({
  Value<int> id,
  Value<String> fullName,
  Value<String?> phone,
  Value<String?> guardianName,
  Value<String?> guardianPhone,
  Value<String?> address,
  Value<DateTime?> dateOfBirth,
  Value<DateTime> joinedAt,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$StudentsTableReferences
    extends BaseReferences<_$AppDatabase, $StudentsTable, Student> {
  $$StudentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$StudentAssignmentsTable, List<StudentAssignment>>
      _studentAssignmentsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.studentAssignments,
              aliasName: 'students__id__student_assignments__student_id');

  $$StudentAssignmentsTableProcessedTableManager get studentAssignmentsRefs {
    final manager =
        $$StudentAssignmentsTableTableManager($_db, $_db.studentAssignments)
            .filter((f) => f.studentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_studentAssignmentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$StudentsTableFilterComposer
    extends Composer<_$AppDatabase, $StudentsTable> {
  $$StudentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get guardianName => $composableBuilder(
      column: $table.guardianName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get guardianPhone => $composableBuilder(
      column: $table.guardianPhone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get joinedAt => $composableBuilder(
      column: $table.joinedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> studentAssignmentsRefs(
      Expression<bool> Function($$StudentAssignmentsTableFilterComposer f) f) {
    final $$StudentAssignmentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.studentAssignments,
        getReferencedColumn: (t) => t.studentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentAssignmentsTableFilterComposer(
              $db: $db,
              $table: $db.studentAssignments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$StudentsTableOrderingComposer
    extends Composer<_$AppDatabase, $StudentsTable> {
  $$StudentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get guardianName => $composableBuilder(
      column: $table.guardianName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get guardianPhone => $composableBuilder(
      column: $table.guardianPhone,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get joinedAt => $composableBuilder(
      column: $table.joinedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$StudentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudentsTable> {
  $$StudentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get guardianName => $composableBuilder(
      column: $table.guardianName, builder: (column) => column);

  GeneratedColumn<String> get guardianPhone => $composableBuilder(
      column: $table.guardianPhone, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<DateTime> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => column);

  GeneratedColumn<DateTime> get joinedAt =>
      $composableBuilder(column: $table.joinedAt, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> studentAssignmentsRefs<T extends Object>(
      Expression<T> Function($$StudentAssignmentsTableAnnotationComposer a) f) {
    final $$StudentAssignmentsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.studentAssignments,
            getReferencedColumn: (t) => t.studentId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$StudentAssignmentsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.studentAssignments,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$StudentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StudentsTable,
    Student,
    $$StudentsTableFilterComposer,
    $$StudentsTableOrderingComposer,
    $$StudentsTableAnnotationComposer,
    $$StudentsTableCreateCompanionBuilder,
    $$StudentsTableUpdateCompanionBuilder,
    (Student, $$StudentsTableReferences),
    Student,
    PrefetchHooks Function({bool studentAssignmentsRefs})> {
  $$StudentsTableTableManager(_$AppDatabase db, $StudentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> fullName = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> guardianName = const Value.absent(),
            Value<String?> guardianPhone = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<DateTime?> dateOfBirth = const Value.absent(),
            Value<DateTime> joinedAt = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              StudentsCompanion(
            id: id,
            fullName: fullName,
            phone: phone,
            guardianName: guardianName,
            guardianPhone: guardianPhone,
            address: address,
            dateOfBirth: dateOfBirth,
            joinedAt: joinedAt,
            isActive: isActive,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String fullName,
            Value<String?> phone = const Value.absent(),
            Value<String?> guardianName = const Value.absent(),
            Value<String?> guardianPhone = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<DateTime?> dateOfBirth = const Value.absent(),
            required DateTime joinedAt,
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              StudentsCompanion.insert(
            id: id,
            fullName: fullName,
            phone: phone,
            guardianName: guardianName,
            guardianPhone: guardianPhone,
            address: address,
            dateOfBirth: dateOfBirth,
            joinedAt: joinedAt,
            isActive: isActive,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$StudentsTable, Student>(table),
                    $$StudentsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({studentAssignmentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (studentAssignmentsRefs) db.studentAssignments
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (studentAssignmentsRefs)
                    await $_getPrefetchedData<Student, $StudentsTable,
                            StudentAssignment>(
                        currentTable: table,
                        referencedTable: $$StudentsTableReferences
                            ._studentAssignmentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$StudentsTableReferences(db, table, p0)
                                .studentAssignmentsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.studentId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$StudentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $StudentsTable,
    Student,
    $$StudentsTableFilterComposer,
    $$StudentsTableOrderingComposer,
    $$StudentsTableAnnotationComposer,
    $$StudentsTableCreateCompanionBuilder,
    $$StudentsTableUpdateCompanionBuilder,
    (Student, $$StudentsTableReferences),
    Student,
    PrefetchHooks Function({bool studentAssignmentsRefs})>;
typedef $$ClassGroupsTableCreateCompanionBuilder = ClassGroupsCompanion
    Function({
  Value<int> id,
  required String name,
  Value<String?> description,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$ClassGroupsTableUpdateCompanionBuilder = ClassGroupsCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<String?> description,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$ClassGroupsTableReferences
    extends BaseReferences<_$AppDatabase, $ClassGroupsTable, ClassGroup> {
  $$ClassGroupsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BatchesTable, List<Batche>> _batchesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.batches,
          aliasName: 'class_groups__id__batches__class_id');

  $$BatchesTableProcessedTableManager get batchesRefs {
    final manager = $$BatchesTableTableManager($_db, $_db.batches)
        .filter((f) => f.classId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_batchesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$StudentAssignmentsTable, List<StudentAssignment>>
      _studentAssignmentsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.studentAssignments,
              aliasName: 'class_groups__id__student_assignments__class_id');

  $$StudentAssignmentsTableProcessedTableManager get studentAssignmentsRefs {
    final manager =
        $$StudentAssignmentsTableTableManager($_db, $_db.studentAssignments)
            .filter((f) => f.classId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_studentAssignmentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ClassGroupsTableFilterComposer
    extends Composer<_$AppDatabase, $ClassGroupsTable> {
  $$ClassGroupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> batchesRefs(
      Expression<bool> Function($$BatchesTableFilterComposer f) f) {
    final $$BatchesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.batches,
        getReferencedColumn: (t) => t.classId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BatchesTableFilterComposer(
              $db: $db,
              $table: $db.batches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> studentAssignmentsRefs(
      Expression<bool> Function($$StudentAssignmentsTableFilterComposer f) f) {
    final $$StudentAssignmentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.studentAssignments,
        getReferencedColumn: (t) => t.classId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentAssignmentsTableFilterComposer(
              $db: $db,
              $table: $db.studentAssignments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ClassGroupsTableOrderingComposer
    extends Composer<_$AppDatabase, $ClassGroupsTable> {
  $$ClassGroupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$ClassGroupsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClassGroupsTable> {
  $$ClassGroupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> batchesRefs<T extends Object>(
      Expression<T> Function($$BatchesTableAnnotationComposer a) f) {
    final $$BatchesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.batches,
        getReferencedColumn: (t) => t.classId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BatchesTableAnnotationComposer(
              $db: $db,
              $table: $db.batches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> studentAssignmentsRefs<T extends Object>(
      Expression<T> Function($$StudentAssignmentsTableAnnotationComposer a) f) {
    final $$StudentAssignmentsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.studentAssignments,
            getReferencedColumn: (t) => t.classId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$StudentAssignmentsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.studentAssignments,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$ClassGroupsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ClassGroupsTable,
    ClassGroup,
    $$ClassGroupsTableFilterComposer,
    $$ClassGroupsTableOrderingComposer,
    $$ClassGroupsTableAnnotationComposer,
    $$ClassGroupsTableCreateCompanionBuilder,
    $$ClassGroupsTableUpdateCompanionBuilder,
    (ClassGroup, $$ClassGroupsTableReferences),
    ClassGroup,
    PrefetchHooks Function({bool batchesRefs, bool studentAssignmentsRefs})> {
  $$ClassGroupsTableTableManager(_$AppDatabase db, $ClassGroupsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClassGroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClassGroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClassGroupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              ClassGroupsCompanion(
            id: id,
            name: name,
            description: description,
            isActive: isActive,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> description = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              ClassGroupsCompanion.insert(
            id: id,
            name: name,
            description: description,
            isActive: isActive,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$ClassGroupsTable, ClassGroup>(table),
                    $$ClassGroupsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {batchesRefs = false, studentAssignmentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (batchesRefs) db.batches,
                if (studentAssignmentsRefs) db.studentAssignments
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (batchesRefs)
                    await $_getPrefetchedData<ClassGroup, $ClassGroupsTable,
                            Batche>(
                        currentTable: table,
                        referencedTable:
                            $$ClassGroupsTableReferences._batchesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ClassGroupsTableReferences(db, table, p0)
                                .batchesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.classId == item.id),
                        typedResults: items),
                  if (studentAssignmentsRefs)
                    await $_getPrefetchedData<ClassGroup, $ClassGroupsTable,
                            StudentAssignment>(
                        currentTable: table,
                        referencedTable: $$ClassGroupsTableReferences
                            ._studentAssignmentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ClassGroupsTableReferences(db, table, p0)
                                .studentAssignmentsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.classId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ClassGroupsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ClassGroupsTable,
    ClassGroup,
    $$ClassGroupsTableFilterComposer,
    $$ClassGroupsTableOrderingComposer,
    $$ClassGroupsTableAnnotationComposer,
    $$ClassGroupsTableCreateCompanionBuilder,
    $$ClassGroupsTableUpdateCompanionBuilder,
    (ClassGroup, $$ClassGroupsTableReferences),
    ClassGroup,
    PrefetchHooks Function({bool batchesRefs, bool studentAssignmentsRefs})>;
typedef $$BatchesTableCreateCompanionBuilder = BatchesCompanion Function({
  Value<int> id,
  required int classId,
  required String name,
  Value<String?> description,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$BatchesTableUpdateCompanionBuilder = BatchesCompanion Function({
  Value<int> id,
  Value<int> classId,
  Value<String> name,
  Value<String?> description,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$BatchesTableReferences
    extends BaseReferences<_$AppDatabase, $BatchesTable, Batche> {
  $$BatchesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClassGroupsTable _classIdTable(_$AppDatabase db) =>
      db.classGroups.createAlias('batches__class_id__class_groups__id');

  $$ClassGroupsTableProcessedTableManager get classId {
    final $_column = $_itemColumn<int>('class_id')!;

    final manager = $$ClassGroupsTableTableManager($_db, $_db.classGroups)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_classIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$StudentAssignmentsTable, List<StudentAssignment>>
      _studentAssignmentsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.studentAssignments,
              aliasName: 'batches__id__student_assignments__batch_id');

  $$StudentAssignmentsTableProcessedTableManager get studentAssignmentsRefs {
    final manager =
        $$StudentAssignmentsTableTableManager($_db, $_db.studentAssignments)
            .filter((f) => f.batchId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_studentAssignmentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$BatchesTableFilterComposer
    extends Composer<_$AppDatabase, $BatchesTable> {
  $$BatchesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$ClassGroupsTableFilterComposer get classId {
    final $$ClassGroupsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classId,
        referencedTable: $db.classGroups,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassGroupsTableFilterComposer(
              $db: $db,
              $table: $db.classGroups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> studentAssignmentsRefs(
      Expression<bool> Function($$StudentAssignmentsTableFilterComposer f) f) {
    final $$StudentAssignmentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.studentAssignments,
        getReferencedColumn: (t) => t.batchId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentAssignmentsTableFilterComposer(
              $db: $db,
              $table: $db.studentAssignments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BatchesTableOrderingComposer
    extends Composer<_$AppDatabase, $BatchesTable> {
  $$BatchesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$ClassGroupsTableOrderingComposer get classId {
    final $$ClassGroupsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classId,
        referencedTable: $db.classGroups,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassGroupsTableOrderingComposer(
              $db: $db,
              $table: $db.classGroups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BatchesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BatchesTable> {
  $$BatchesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ClassGroupsTableAnnotationComposer get classId {
    final $$ClassGroupsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classId,
        referencedTable: $db.classGroups,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassGroupsTableAnnotationComposer(
              $db: $db,
              $table: $db.classGroups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> studentAssignmentsRefs<T extends Object>(
      Expression<T> Function($$StudentAssignmentsTableAnnotationComposer a) f) {
    final $$StudentAssignmentsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.studentAssignments,
            getReferencedColumn: (t) => t.batchId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$StudentAssignmentsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.studentAssignments,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$BatchesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BatchesTable,
    Batche,
    $$BatchesTableFilterComposer,
    $$BatchesTableOrderingComposer,
    $$BatchesTableAnnotationComposer,
    $$BatchesTableCreateCompanionBuilder,
    $$BatchesTableUpdateCompanionBuilder,
    (Batche, $$BatchesTableReferences),
    Batche,
    PrefetchHooks Function({bool classId, bool studentAssignmentsRefs})> {
  $$BatchesTableTableManager(_$AppDatabase db, $BatchesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BatchesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BatchesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BatchesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> classId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              BatchesCompanion(
            id: id,
            classId: classId,
            name: name,
            description: description,
            isActive: isActive,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int classId,
            required String name,
            Value<String?> description = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              BatchesCompanion.insert(
            id: id,
            classId: classId,
            name: name,
            description: description,
            isActive: isActive,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$BatchesTable, Batche>(table),
                    $$BatchesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {classId = false, studentAssignmentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (studentAssignmentsRefs) db.studentAssignments
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (classId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.classId,
                    referencedTable: $$BatchesTableReferences._classIdTable(db),
                    referencedColumn:
                        $$BatchesTableReferences._classIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (studentAssignmentsRefs)
                    await $_getPrefetchedData<Batche, $BatchesTable,
                            StudentAssignment>(
                        currentTable: table,
                        referencedTable: $$BatchesTableReferences
                            ._studentAssignmentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BatchesTableReferences(db, table, p0)
                                .studentAssignmentsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.batchId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$BatchesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BatchesTable,
    Batche,
    $$BatchesTableFilterComposer,
    $$BatchesTableOrderingComposer,
    $$BatchesTableAnnotationComposer,
    $$BatchesTableCreateCompanionBuilder,
    $$BatchesTableUpdateCompanionBuilder,
    (Batche, $$BatchesTableReferences),
    Batche,
    PrefetchHooks Function({bool classId, bool studentAssignmentsRefs})>;
typedef $$StudentAssignmentsTableCreateCompanionBuilder
    = StudentAssignmentsCompanion Function({
  Value<int> id,
  required int studentId,
  required int classId,
  Value<int?> batchId,
  required String assignmentScopeKey,
  required DateTime effectiveFrom,
  Value<DateTime?> effectiveTo,
  Value<String?> changeReason,
  Value<DateTime> createdAt,
});
typedef $$StudentAssignmentsTableUpdateCompanionBuilder
    = StudentAssignmentsCompanion Function({
  Value<int> id,
  Value<int> studentId,
  Value<int> classId,
  Value<int?> batchId,
  Value<String> assignmentScopeKey,
  Value<DateTime> effectiveFrom,
  Value<DateTime?> effectiveTo,
  Value<String?> changeReason,
  Value<DateTime> createdAt,
});

final class $$StudentAssignmentsTableReferences extends BaseReferences<
    _$AppDatabase, $StudentAssignmentsTable, StudentAssignment> {
  $$StudentAssignmentsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $StudentsTable _studentIdTable(_$AppDatabase db) =>
      db.students.createAlias('student_assignments__student_id__students__id');

  $$StudentsTableProcessedTableManager get studentId {
    final $_column = $_itemColumn<int>('student_id')!;

    final manager = $$StudentsTableTableManager($_db, $_db.students)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ClassGroupsTable _classIdTable(_$AppDatabase db) => db.classGroups
      .createAlias('student_assignments__class_id__class_groups__id');

  $$ClassGroupsTableProcessedTableManager get classId {
    final $_column = $_itemColumn<int>('class_id')!;

    final manager = $$ClassGroupsTableTableManager($_db, $_db.classGroups)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_classIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $BatchesTable _batchIdTable(_$AppDatabase db) =>
      db.batches.createAlias('student_assignments__batch_id__batches__id');

  $$BatchesTableProcessedTableManager? get batchId {
    final $_column = $_itemColumn<int>('batch_id');
    if ($_column == null) return null;
    final manager = $$BatchesTableTableManager($_db, $_db.batches)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_batchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$StudentAssignmentsTableFilterComposer
    extends Composer<_$AppDatabase, $StudentAssignmentsTable> {
  $$StudentAssignmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get assignmentScopeKey => $composableBuilder(
      column: $table.assignmentScopeKey,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get effectiveFrom => $composableBuilder(
      column: $table.effectiveFrom, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get effectiveTo => $composableBuilder(
      column: $table.effectiveTo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get changeReason => $composableBuilder(
      column: $table.changeReason, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$StudentsTableFilterComposer get studentId {
    final $$StudentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.studentId,
        referencedTable: $db.students,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentsTableFilterComposer(
              $db: $db,
              $table: $db.students,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ClassGroupsTableFilterComposer get classId {
    final $$ClassGroupsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classId,
        referencedTable: $db.classGroups,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassGroupsTableFilterComposer(
              $db: $db,
              $table: $db.classGroups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BatchesTableFilterComposer get batchId {
    final $$BatchesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.batchId,
        referencedTable: $db.batches,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BatchesTableFilterComposer(
              $db: $db,
              $table: $db.batches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StudentAssignmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $StudentAssignmentsTable> {
  $$StudentAssignmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get assignmentScopeKey => $composableBuilder(
      column: $table.assignmentScopeKey,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get effectiveFrom => $composableBuilder(
      column: $table.effectiveFrom,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get effectiveTo => $composableBuilder(
      column: $table.effectiveTo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get changeReason => $composableBuilder(
      column: $table.changeReason,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$StudentsTableOrderingComposer get studentId {
    final $$StudentsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.studentId,
        referencedTable: $db.students,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentsTableOrderingComposer(
              $db: $db,
              $table: $db.students,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ClassGroupsTableOrderingComposer get classId {
    final $$ClassGroupsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classId,
        referencedTable: $db.classGroups,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassGroupsTableOrderingComposer(
              $db: $db,
              $table: $db.classGroups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BatchesTableOrderingComposer get batchId {
    final $$BatchesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.batchId,
        referencedTable: $db.batches,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BatchesTableOrderingComposer(
              $db: $db,
              $table: $db.batches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StudentAssignmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudentAssignmentsTable> {
  $$StudentAssignmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get assignmentScopeKey => $composableBuilder(
      column: $table.assignmentScopeKey, builder: (column) => column);

  GeneratedColumn<DateTime> get effectiveFrom => $composableBuilder(
      column: $table.effectiveFrom, builder: (column) => column);

  GeneratedColumn<DateTime> get effectiveTo => $composableBuilder(
      column: $table.effectiveTo, builder: (column) => column);

  GeneratedColumn<String> get changeReason => $composableBuilder(
      column: $table.changeReason, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$StudentsTableAnnotationComposer get studentId {
    final $$StudentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.studentId,
        referencedTable: $db.students,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentsTableAnnotationComposer(
              $db: $db,
              $table: $db.students,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ClassGroupsTableAnnotationComposer get classId {
    final $$ClassGroupsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classId,
        referencedTable: $db.classGroups,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassGroupsTableAnnotationComposer(
              $db: $db,
              $table: $db.classGroups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BatchesTableAnnotationComposer get batchId {
    final $$BatchesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.batchId,
        referencedTable: $db.batches,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BatchesTableAnnotationComposer(
              $db: $db,
              $table: $db.batches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StudentAssignmentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StudentAssignmentsTable,
    StudentAssignment,
    $$StudentAssignmentsTableFilterComposer,
    $$StudentAssignmentsTableOrderingComposer,
    $$StudentAssignmentsTableAnnotationComposer,
    $$StudentAssignmentsTableCreateCompanionBuilder,
    $$StudentAssignmentsTableUpdateCompanionBuilder,
    (StudentAssignment, $$StudentAssignmentsTableReferences),
    StudentAssignment,
    PrefetchHooks Function({bool studentId, bool classId, bool batchId})> {
  $$StudentAssignmentsTableTableManager(
      _$AppDatabase db, $StudentAssignmentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudentAssignmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudentAssignmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudentAssignmentsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> studentId = const Value.absent(),
            Value<int> classId = const Value.absent(),
            Value<int?> batchId = const Value.absent(),
            Value<String> assignmentScopeKey = const Value.absent(),
            Value<DateTime> effectiveFrom = const Value.absent(),
            Value<DateTime?> effectiveTo = const Value.absent(),
            Value<String?> changeReason = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              StudentAssignmentsCompanion(
            id: id,
            studentId: studentId,
            classId: classId,
            batchId: batchId,
            assignmentScopeKey: assignmentScopeKey,
            effectiveFrom: effectiveFrom,
            effectiveTo: effectiveTo,
            changeReason: changeReason,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int studentId,
            required int classId,
            Value<int?> batchId = const Value.absent(),
            required String assignmentScopeKey,
            required DateTime effectiveFrom,
            Value<DateTime?> effectiveTo = const Value.absent(),
            Value<String?> changeReason = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              StudentAssignmentsCompanion.insert(
            id: id,
            studentId: studentId,
            classId: classId,
            batchId: batchId,
            assignmentScopeKey: assignmentScopeKey,
            effectiveFrom: effectiveFrom,
            effectiveTo: effectiveTo,
            changeReason: changeReason,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$StudentAssignmentsTable, StudentAssignment>(
                        table),
                    $$StudentAssignmentsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {studentId = false, classId = false, batchId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (studentId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.studentId,
                    referencedTable:
                        $$StudentAssignmentsTableReferences._studentIdTable(db),
                    referencedColumn: $$StudentAssignmentsTableReferences
                        ._studentIdTable(db)
                        .id,
                  ) as T;
                }
                if (classId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.classId,
                    referencedTable:
                        $$StudentAssignmentsTableReferences._classIdTable(db),
                    referencedColumn: $$StudentAssignmentsTableReferences
                        ._classIdTable(db)
                        .id,
                  ) as T;
                }
                if (batchId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.batchId,
                    referencedTable:
                        $$StudentAssignmentsTableReferences._batchIdTable(db),
                    referencedColumn: $$StudentAssignmentsTableReferences
                        ._batchIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$StudentAssignmentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $StudentAssignmentsTable,
    StudentAssignment,
    $$StudentAssignmentsTableFilterComposer,
    $$StudentAssignmentsTableOrderingComposer,
    $$StudentAssignmentsTableAnnotationComposer,
    $$StudentAssignmentsTableCreateCompanionBuilder,
    $$StudentAssignmentsTableUpdateCompanionBuilder,
    (StudentAssignment, $$StudentAssignmentsTableReferences),
    StudentAssignment,
    PrefetchHooks Function({bool studentId, bool classId, bool batchId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$InstituteSettingsTableTableManager get instituteSettings =>
      $$InstituteSettingsTableTableManager(_db, _db.instituteSettings);
  $$StudentsTableTableManager get students =>
      $$StudentsTableTableManager(_db, _db.students);
  $$ClassGroupsTableTableManager get classGroups =>
      $$ClassGroupsTableTableManager(_db, _db.classGroups);
  $$BatchesTableTableManager get batches =>
      $$BatchesTableTableManager(_db, _db.batches);
  $$StudentAssignmentsTableTableManager get studentAssignments =>
      $$StudentAssignmentsTableTableManager(_db, _db.studentAssignments);
}
