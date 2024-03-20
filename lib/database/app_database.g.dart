// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DBUserDataClassTable extends DBUserDataClass
    with TableInfo<$DBUserDataClassTable, DBUserData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DBUserDataClassTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userNameMeta =
      const VerificationMeta('userName');
  @override
  late final GeneratedColumn<String> userName = GeneratedColumn<String>(
      'user_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 6, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _passwordMeta =
      const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, userName, password];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'd_b_user_data_class';
  @override
  VerificationContext validateIntegrity(Insertable<DBUserData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_name')) {
      context.handle(_userNameMeta,
          userName.isAcceptableOrUnknown(data['user_name']!, _userNameMeta));
    } else if (isInserting) {
      context.missing(_userNameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DBUserData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DBUserData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_name'])!,
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password'])!,
    );
  }

  @override
  $DBUserDataClassTable createAlias(String alias) {
    return $DBUserDataClassTable(attachedDatabase, alias);
  }
}

class DBUserData extends DataClass implements Insertable<DBUserData> {
  final int id;
  final String userName;
  final String password;
  const DBUserData(
      {required this.id, required this.userName, required this.password});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_name'] = Variable<String>(userName);
    map['password'] = Variable<String>(password);
    return map;
  }

  DBUserDataClassCompanion toCompanion(bool nullToAbsent) {
    return DBUserDataClassCompanion(
      id: Value(id),
      userName: Value(userName),
      password: Value(password),
    );
  }

  factory DBUserData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DBUserData(
      id: serializer.fromJson<int>(json['id']),
      userName: serializer.fromJson<String>(json['userName']),
      password: serializer.fromJson<String>(json['password']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userName': serializer.toJson<String>(userName),
      'password': serializer.toJson<String>(password),
    };
  }

  DBUserData copyWith({int? id, String? userName, String? password}) =>
      DBUserData(
        id: id ?? this.id,
        userName: userName ?? this.userName,
        password: password ?? this.password,
      );
  @override
  String toString() {
    return (StringBuffer('DBUserData(')
          ..write('id: $id, ')
          ..write('userName: $userName, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userName, password);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DBUserData &&
          other.id == this.id &&
          other.userName == this.userName &&
          other.password == this.password);
}

class DBUserDataClassCompanion extends UpdateCompanion<DBUserData> {
  final Value<int> id;
  final Value<String> userName;
  final Value<String> password;
  const DBUserDataClassCompanion({
    this.id = const Value.absent(),
    this.userName = const Value.absent(),
    this.password = const Value.absent(),
  });
  DBUserDataClassCompanion.insert({
    this.id = const Value.absent(),
    required String userName,
    required String password,
  })  : userName = Value(userName),
        password = Value(password);
  static Insertable<DBUserData> custom({
    Expression<int>? id,
    Expression<String>? userName,
    Expression<String>? password,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userName != null) 'user_name': userName,
      if (password != null) 'password': password,
    });
  }

  DBUserDataClassCompanion copyWith(
      {Value<int>? id, Value<String>? userName, Value<String>? password}) {
    return DBUserDataClassCompanion(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      password: password ?? this.password,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userName.present) {
      map['user_name'] = Variable<String>(userName.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DBUserDataClassCompanion(')
          ..write('id: $id, ')
          ..write('userName: $userName, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }
}

class $DBAccountDataClassTable extends DBAccountDataClass
    with TableInfo<$DBAccountDataClassTable, DBAccountData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DBAccountDataClassTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userMeta = const VerificationMeta('user');
  @override
  late final GeneratedColumn<String> user = GeneratedColumn<String>(
      'user', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 6, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _purposeMeta =
      const VerificationMeta('purpose');
  @override
  late final GeneratedColumn<String> purpose = GeneratedColumn<String>(
      'purpose', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, user, name, purpose];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'd_b_account_data_class';
  @override
  VerificationContext validateIntegrity(Insertable<DBAccountData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user')) {
      context.handle(
          _userMeta, user.isAcceptableOrUnknown(data['user']!, _userMeta));
    } else if (isInserting) {
      context.missing(_userMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('purpose')) {
      context.handle(_purposeMeta,
          purpose.isAcceptableOrUnknown(data['purpose']!, _purposeMeta));
    } else if (isInserting) {
      context.missing(_purposeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DBAccountData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DBAccountData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      user: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      purpose: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}purpose'])!,
    );
  }

  @override
  $DBAccountDataClassTable createAlias(String alias) {
    return $DBAccountDataClassTable(attachedDatabase, alias);
  }
}

class DBAccountData extends DataClass implements Insertable<DBAccountData> {
  final int id;
  final String user;
  final String name;
  final String purpose;
  const DBAccountData(
      {required this.id,
      required this.user,
      required this.name,
      required this.purpose});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user'] = Variable<String>(user);
    map['name'] = Variable<String>(name);
    map['purpose'] = Variable<String>(purpose);
    return map;
  }

  DBAccountDataClassCompanion toCompanion(bool nullToAbsent) {
    return DBAccountDataClassCompanion(
      id: Value(id),
      user: Value(user),
      name: Value(name),
      purpose: Value(purpose),
    );
  }

  factory DBAccountData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DBAccountData(
      id: serializer.fromJson<int>(json['id']),
      user: serializer.fromJson<String>(json['user']),
      name: serializer.fromJson<String>(json['name']),
      purpose: serializer.fromJson<String>(json['purpose']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'user': serializer.toJson<String>(user),
      'name': serializer.toJson<String>(name),
      'purpose': serializer.toJson<String>(purpose),
    };
  }

  DBAccountData copyWith(
          {int? id, String? user, String? name, String? purpose}) =>
      DBAccountData(
        id: id ?? this.id,
        user: user ?? this.user,
        name: name ?? this.name,
        purpose: purpose ?? this.purpose,
      );
  @override
  String toString() {
    return (StringBuffer('DBAccountData(')
          ..write('id: $id, ')
          ..write('user: $user, ')
          ..write('name: $name, ')
          ..write('purpose: $purpose')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, user, name, purpose);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DBAccountData &&
          other.id == this.id &&
          other.user == this.user &&
          other.name == this.name &&
          other.purpose == this.purpose);
}

class DBAccountDataClassCompanion extends UpdateCompanion<DBAccountData> {
  final Value<int> id;
  final Value<String> user;
  final Value<String> name;
  final Value<String> purpose;
  const DBAccountDataClassCompanion({
    this.id = const Value.absent(),
    this.user = const Value.absent(),
    this.name = const Value.absent(),
    this.purpose = const Value.absent(),
  });
  DBAccountDataClassCompanion.insert({
    this.id = const Value.absent(),
    required String user,
    required String name,
    required String purpose,
  })  : user = Value(user),
        name = Value(name),
        purpose = Value(purpose);
  static Insertable<DBAccountData> custom({
    Expression<int>? id,
    Expression<String>? user,
    Expression<String>? name,
    Expression<String>? purpose,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (user != null) 'user': user,
      if (name != null) 'name': name,
      if (purpose != null) 'purpose': purpose,
    });
  }

  DBAccountDataClassCompanion copyWith(
      {Value<int>? id,
      Value<String>? user,
      Value<String>? name,
      Value<String>? purpose}) {
    return DBAccountDataClassCompanion(
      id: id ?? this.id,
      user: user ?? this.user,
      name: name ?? this.name,
      purpose: purpose ?? this.purpose,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (user.present) {
      map['user'] = Variable<String>(user.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (purpose.present) {
      map['purpose'] = Variable<String>(purpose.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DBAccountDataClassCompanion(')
          ..write('id: $id, ')
          ..write('user: $user, ')
          ..write('name: $name, ')
          ..write('purpose: $purpose')
          ..write(')'))
        .toString();
  }
}

class $DBCategoryDataClassTable extends DBCategoryDataClass
    with TableInfo<$DBCategoryDataClassTable, DBCategoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DBCategoryDataClassTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _accountMeta =
      const VerificationMeta('account');
  @override
  late final GeneratedColumn<int> account = GeneratedColumn<int>(
      'account', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _majorMeta = const VerificationMeta('major');
  @override
  late final GeneratedColumn<int> major = GeneratedColumn<int>(
      'major', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _minorMeta = const VerificationMeta('minor');
  @override
  late final GeneratedColumn<int> minor = GeneratedColumn<int>(
      'minor', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _budgetMeta = const VerificationMeta('budget');
  @override
  late final GeneratedColumn<double> budget = GeneratedColumn<double>(
      'budget', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, account, name, major, minor, budget];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'd_b_category_data_class';
  @override
  VerificationContext validateIntegrity(Insertable<DBCategoryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('account')) {
      context.handle(_accountMeta,
          account.isAcceptableOrUnknown(data['account']!, _accountMeta));
    } else if (isInserting) {
      context.missing(_accountMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('major')) {
      context.handle(
          _majorMeta, major.isAcceptableOrUnknown(data['major']!, _majorMeta));
    } else if (isInserting) {
      context.missing(_majorMeta);
    }
    if (data.containsKey('minor')) {
      context.handle(
          _minorMeta, minor.isAcceptableOrUnknown(data['minor']!, _minorMeta));
    } else if (isInserting) {
      context.missing(_minorMeta);
    }
    if (data.containsKey('budget')) {
      context.handle(_budgetMeta,
          budget.isAcceptableOrUnknown(data['budget']!, _budgetMeta));
    } else if (isInserting) {
      context.missing(_budgetMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DBCategoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DBCategoryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      account: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}account'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      major: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}major'])!,
      minor: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}minor'])!,
      budget: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}budget'])!,
    );
  }

  @override
  $DBCategoryDataClassTable createAlias(String alias) {
    return $DBCategoryDataClassTable(attachedDatabase, alias);
  }
}

class DBCategoryData extends DataClass implements Insertable<DBCategoryData> {
  final int id;
  final int account;
  final String name;
  final int major;
  final int minor;
  final double budget;
  const DBCategoryData(
      {required this.id,
      required this.account,
      required this.name,
      required this.major,
      required this.minor,
      required this.budget});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['account'] = Variable<int>(account);
    map['name'] = Variable<String>(name);
    map['major'] = Variable<int>(major);
    map['minor'] = Variable<int>(minor);
    map['budget'] = Variable<double>(budget);
    return map;
  }

  DBCategoryDataClassCompanion toCompanion(bool nullToAbsent) {
    return DBCategoryDataClassCompanion(
      id: Value(id),
      account: Value(account),
      name: Value(name),
      major: Value(major),
      minor: Value(minor),
      budget: Value(budget),
    );
  }

  factory DBCategoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DBCategoryData(
      id: serializer.fromJson<int>(json['id']),
      account: serializer.fromJson<int>(json['account']),
      name: serializer.fromJson<String>(json['name']),
      major: serializer.fromJson<int>(json['major']),
      minor: serializer.fromJson<int>(json['minor']),
      budget: serializer.fromJson<double>(json['budget']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'account': serializer.toJson<int>(account),
      'name': serializer.toJson<String>(name),
      'major': serializer.toJson<int>(major),
      'minor': serializer.toJson<int>(minor),
      'budget': serializer.toJson<double>(budget),
    };
  }

  DBCategoryData copyWith(
          {int? id,
          int? account,
          String? name,
          int? major,
          int? minor,
          double? budget}) =>
      DBCategoryData(
        id: id ?? this.id,
        account: account ?? this.account,
        name: name ?? this.name,
        major: major ?? this.major,
        minor: minor ?? this.minor,
        budget: budget ?? this.budget,
      );
  @override
  String toString() {
    return (StringBuffer('DBCategoryData(')
          ..write('id: $id, ')
          ..write('account: $account, ')
          ..write('name: $name, ')
          ..write('major: $major, ')
          ..write('minor: $minor, ')
          ..write('budget: $budget')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, account, name, major, minor, budget);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DBCategoryData &&
          other.id == this.id &&
          other.account == this.account &&
          other.name == this.name &&
          other.major == this.major &&
          other.minor == this.minor &&
          other.budget == this.budget);
}

class DBCategoryDataClassCompanion extends UpdateCompanion<DBCategoryData> {
  final Value<int> id;
  final Value<int> account;
  final Value<String> name;
  final Value<int> major;
  final Value<int> minor;
  final Value<double> budget;
  const DBCategoryDataClassCompanion({
    this.id = const Value.absent(),
    this.account = const Value.absent(),
    this.name = const Value.absent(),
    this.major = const Value.absent(),
    this.minor = const Value.absent(),
    this.budget = const Value.absent(),
  });
  DBCategoryDataClassCompanion.insert({
    this.id = const Value.absent(),
    required int account,
    required String name,
    required int major,
    required int minor,
    required double budget,
  })  : account = Value(account),
        name = Value(name),
        major = Value(major),
        minor = Value(minor),
        budget = Value(budget);
  static Insertable<DBCategoryData> custom({
    Expression<int>? id,
    Expression<int>? account,
    Expression<String>? name,
    Expression<int>? major,
    Expression<int>? minor,
    Expression<double>? budget,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (account != null) 'account': account,
      if (name != null) 'name': name,
      if (major != null) 'major': major,
      if (minor != null) 'minor': minor,
      if (budget != null) 'budget': budget,
    });
  }

  DBCategoryDataClassCompanion copyWith(
      {Value<int>? id,
      Value<int>? account,
      Value<String>? name,
      Value<int>? major,
      Value<int>? minor,
      Value<double>? budget}) {
    return DBCategoryDataClassCompanion(
      id: id ?? this.id,
      account: account ?? this.account,
      name: name ?? this.name,
      major: major ?? this.major,
      minor: minor ?? this.minor,
      budget: budget ?? this.budget,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (account.present) {
      map['account'] = Variable<int>(account.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (major.present) {
      map['major'] = Variable<int>(major.value);
    }
    if (minor.present) {
      map['minor'] = Variable<int>(minor.value);
    }
    if (budget.present) {
      map['budget'] = Variable<double>(budget.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DBCategoryDataClassCompanion(')
          ..write('id: $id, ')
          ..write('account: $account, ')
          ..write('name: $name, ')
          ..write('major: $major, ')
          ..write('minor: $minor, ')
          ..write('budget: $budget')
          ..write(')'))
        .toString();
  }
}

class $DBTransactionDataClassTable extends DBTransactionDataClass
    with TableInfo<$DBTransactionDataClassTable, DBTransactionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DBTransactionDataClassTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _accountMeta =
      const VerificationMeta('account');
  @override
  late final GeneratedColumn<int> account = GeneratedColumn<int>(
      'account', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<int> category = GeneratedColumn<int>(
      'category', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _purposeMeta =
      const VerificationMeta('purpose');
  @override
  late final GeneratedColumn<String> purpose = GeneratedColumn<String>(
      'purpose', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _moneyMeta = const VerificationMeta('money');
  @override
  late final GeneratedColumn<double> money = GeneratedColumn<double>(
      'money', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _transactionDateMeta =
      const VerificationMeta('transactionDate');
  @override
  late final GeneratedColumn<DateTime> transactionDate =
      GeneratedColumn<DateTime>('transaction_date', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, account, category, purpose, money, transactionDate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'd_b_transaction_data_class';
  @override
  VerificationContext validateIntegrity(Insertable<DBTransactionData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('account')) {
      context.handle(_accountMeta,
          account.isAcceptableOrUnknown(data['account']!, _accountMeta));
    } else if (isInserting) {
      context.missing(_accountMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('purpose')) {
      context.handle(_purposeMeta,
          purpose.isAcceptableOrUnknown(data['purpose']!, _purposeMeta));
    } else if (isInserting) {
      context.missing(_purposeMeta);
    }
    if (data.containsKey('money')) {
      context.handle(
          _moneyMeta, money.isAcceptableOrUnknown(data['money']!, _moneyMeta));
    } else if (isInserting) {
      context.missing(_moneyMeta);
    }
    if (data.containsKey('transaction_date')) {
      context.handle(
          _transactionDateMeta,
          transactionDate.isAcceptableOrUnknown(
              data['transaction_date']!, _transactionDateMeta));
    } else if (isInserting) {
      context.missing(_transactionDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DBTransactionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DBTransactionData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      account: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}account'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category'])!,
      purpose: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}purpose'])!,
      money: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}money'])!,
      transactionDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}transaction_date'])!,
    );
  }

  @override
  $DBTransactionDataClassTable createAlias(String alias) {
    return $DBTransactionDataClassTable(attachedDatabase, alias);
  }
}

class DBTransactionData extends DataClass
    implements Insertable<DBTransactionData> {
  final int id;
  final int account;
  final int category;
  final String purpose;
  final double money;
  final DateTime transactionDate;
  const DBTransactionData(
      {required this.id,
      required this.account,
      required this.category,
      required this.purpose,
      required this.money,
      required this.transactionDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['account'] = Variable<int>(account);
    map['category'] = Variable<int>(category);
    map['purpose'] = Variable<String>(purpose);
    map['money'] = Variable<double>(money);
    map['transaction_date'] = Variable<DateTime>(transactionDate);
    return map;
  }

  DBTransactionDataClassCompanion toCompanion(bool nullToAbsent) {
    return DBTransactionDataClassCompanion(
      id: Value(id),
      account: Value(account),
      category: Value(category),
      purpose: Value(purpose),
      money: Value(money),
      transactionDate: Value(transactionDate),
    );
  }

  factory DBTransactionData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DBTransactionData(
      id: serializer.fromJson<int>(json['id']),
      account: serializer.fromJson<int>(json['account']),
      category: serializer.fromJson<int>(json['category']),
      purpose: serializer.fromJson<String>(json['purpose']),
      money: serializer.fromJson<double>(json['money']),
      transactionDate: serializer.fromJson<DateTime>(json['transactionDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'account': serializer.toJson<int>(account),
      'category': serializer.toJson<int>(category),
      'purpose': serializer.toJson<String>(purpose),
      'money': serializer.toJson<double>(money),
      'transactionDate': serializer.toJson<DateTime>(transactionDate),
    };
  }

  DBTransactionData copyWith(
          {int? id,
          int? account,
          int? category,
          String? purpose,
          double? money,
          DateTime? transactionDate}) =>
      DBTransactionData(
        id: id ?? this.id,
        account: account ?? this.account,
        category: category ?? this.category,
        purpose: purpose ?? this.purpose,
        money: money ?? this.money,
        transactionDate: transactionDate ?? this.transactionDate,
      );
  @override
  String toString() {
    return (StringBuffer('DBTransactionData(')
          ..write('id: $id, ')
          ..write('account: $account, ')
          ..write('category: $category, ')
          ..write('purpose: $purpose, ')
          ..write('money: $money, ')
          ..write('transactionDate: $transactionDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, account, category, purpose, money, transactionDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DBTransactionData &&
          other.id == this.id &&
          other.account == this.account &&
          other.category == this.category &&
          other.purpose == this.purpose &&
          other.money == this.money &&
          other.transactionDate == this.transactionDate);
}

class DBTransactionDataClassCompanion
    extends UpdateCompanion<DBTransactionData> {
  final Value<int> id;
  final Value<int> account;
  final Value<int> category;
  final Value<String> purpose;
  final Value<double> money;
  final Value<DateTime> transactionDate;
  const DBTransactionDataClassCompanion({
    this.id = const Value.absent(),
    this.account = const Value.absent(),
    this.category = const Value.absent(),
    this.purpose = const Value.absent(),
    this.money = const Value.absent(),
    this.transactionDate = const Value.absent(),
  });
  DBTransactionDataClassCompanion.insert({
    this.id = const Value.absent(),
    required int account,
    required int category,
    required String purpose,
    required double money,
    required DateTime transactionDate,
  })  : account = Value(account),
        category = Value(category),
        purpose = Value(purpose),
        money = Value(money),
        transactionDate = Value(transactionDate);
  static Insertable<DBTransactionData> custom({
    Expression<int>? id,
    Expression<int>? account,
    Expression<int>? category,
    Expression<String>? purpose,
    Expression<double>? money,
    Expression<DateTime>? transactionDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (account != null) 'account': account,
      if (category != null) 'category': category,
      if (purpose != null) 'purpose': purpose,
      if (money != null) 'money': money,
      if (transactionDate != null) 'transaction_date': transactionDate,
    });
  }

  DBTransactionDataClassCompanion copyWith(
      {Value<int>? id,
      Value<int>? account,
      Value<int>? category,
      Value<String>? purpose,
      Value<double>? money,
      Value<DateTime>? transactionDate}) {
    return DBTransactionDataClassCompanion(
      id: id ?? this.id,
      account: account ?? this.account,
      category: category ?? this.category,
      purpose: purpose ?? this.purpose,
      money: money ?? this.money,
      transactionDate: transactionDate ?? this.transactionDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (account.present) {
      map['account'] = Variable<int>(account.value);
    }
    if (category.present) {
      map['category'] = Variable<int>(category.value);
    }
    if (purpose.present) {
      map['purpose'] = Variable<String>(purpose.value);
    }
    if (money.present) {
      map['money'] = Variable<double>(money.value);
    }
    if (transactionDate.present) {
      map['transaction_date'] = Variable<DateTime>(transactionDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DBTransactionDataClassCompanion(')
          ..write('id: $id, ')
          ..write('account: $account, ')
          ..write('category: $category, ')
          ..write('purpose: $purpose, ')
          ..write('money: $money, ')
          ..write('transactionDate: $transactionDate')
          ..write(')'))
        .toString();
  }
}

class $DBMinorCategoryDataClassTable extends DBMinorCategoryDataClass
    with TableInfo<$DBMinorCategoryDataClassTable, DBMinorCategoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DBMinorCategoryDataClassTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _accountMeta =
      const VerificationMeta('account');
  @override
  late final GeneratedColumn<int> account = GeneratedColumn<int>(
      'account', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _majorMeta = const VerificationMeta('major');
  @override
  late final GeneratedColumn<int> major = GeneratedColumn<int>(
      'major', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  @override
  List<GeneratedColumn> get $columns => [id, account, major, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'd_b_minor_category_data_class';
  @override
  VerificationContext validateIntegrity(
      Insertable<DBMinorCategoryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('account')) {
      context.handle(_accountMeta,
          account.isAcceptableOrUnknown(data['account']!, _accountMeta));
    } else if (isInserting) {
      context.missing(_accountMeta);
    }
    if (data.containsKey('major')) {
      context.handle(
          _majorMeta, major.isAcceptableOrUnknown(data['major']!, _majorMeta));
    } else if (isInserting) {
      context.missing(_majorMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DBMinorCategoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DBMinorCategoryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      account: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}account'])!,
      major: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}major'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $DBMinorCategoryDataClassTable createAlias(String alias) {
    return $DBMinorCategoryDataClassTable(attachedDatabase, alias);
  }
}

class DBMinorCategoryData extends DataClass
    implements Insertable<DBMinorCategoryData> {
  final int id;
  final int account;
  final int major;
  final String name;
  const DBMinorCategoryData(
      {required this.id,
      required this.account,
      required this.major,
      required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['account'] = Variable<int>(account);
    map['major'] = Variable<int>(major);
    map['name'] = Variable<String>(name);
    return map;
  }

  DBMinorCategoryDataClassCompanion toCompanion(bool nullToAbsent) {
    return DBMinorCategoryDataClassCompanion(
      id: Value(id),
      account: Value(account),
      major: Value(major),
      name: Value(name),
    );
  }

  factory DBMinorCategoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DBMinorCategoryData(
      id: serializer.fromJson<int>(json['id']),
      account: serializer.fromJson<int>(json['account']),
      major: serializer.fromJson<int>(json['major']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'account': serializer.toJson<int>(account),
      'major': serializer.toJson<int>(major),
      'name': serializer.toJson<String>(name),
    };
  }

  DBMinorCategoryData copyWith(
          {int? id, int? account, int? major, String? name}) =>
      DBMinorCategoryData(
        id: id ?? this.id,
        account: account ?? this.account,
        major: major ?? this.major,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('DBMinorCategoryData(')
          ..write('id: $id, ')
          ..write('account: $account, ')
          ..write('major: $major, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, account, major, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DBMinorCategoryData &&
          other.id == this.id &&
          other.account == this.account &&
          other.major == this.major &&
          other.name == this.name);
}

class DBMinorCategoryDataClassCompanion
    extends UpdateCompanion<DBMinorCategoryData> {
  final Value<int> id;
  final Value<int> account;
  final Value<int> major;
  final Value<String> name;
  const DBMinorCategoryDataClassCompanion({
    this.id = const Value.absent(),
    this.account = const Value.absent(),
    this.major = const Value.absent(),
    this.name = const Value.absent(),
  });
  DBMinorCategoryDataClassCompanion.insert({
    this.id = const Value.absent(),
    required int account,
    required int major,
    required String name,
  })  : account = Value(account),
        major = Value(major),
        name = Value(name);
  static Insertable<DBMinorCategoryData> custom({
    Expression<int>? id,
    Expression<int>? account,
    Expression<int>? major,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (account != null) 'account': account,
      if (major != null) 'major': major,
      if (name != null) 'name': name,
    });
  }

  DBMinorCategoryDataClassCompanion copyWith(
      {Value<int>? id,
      Value<int>? account,
      Value<int>? major,
      Value<String>? name}) {
    return DBMinorCategoryDataClassCompanion(
      id: id ?? this.id,
      account: account ?? this.account,
      major: major ?? this.major,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (account.present) {
      map['account'] = Variable<int>(account.value);
    }
    if (major.present) {
      map['major'] = Variable<int>(major.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DBMinorCategoryDataClassCompanion(')
          ..write('id: $id, ')
          ..write('account: $account, ')
          ..write('major: $major, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $DBUserDataClassTable dBUserDataClass =
      $DBUserDataClassTable(this);
  late final $DBAccountDataClassTable dBAccountDataClass =
      $DBAccountDataClassTable(this);
  late final $DBCategoryDataClassTable dBCategoryDataClass =
      $DBCategoryDataClassTable(this);
  late final $DBTransactionDataClassTable dBTransactionDataClass =
      $DBTransactionDataClassTable(this);
  late final $DBMinorCategoryDataClassTable dBMinorCategoryDataClass =
      $DBMinorCategoryDataClassTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        dBUserDataClass,
        dBAccountDataClass,
        dBCategoryDataClass,
        dBTransactionDataClass,
        dBMinorCategoryDataClass
      ];
}
