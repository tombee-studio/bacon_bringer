import 'package:drift/drift.dart';

@DataClassName('DBUserData')
class DBUserDataClass extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userName => text().unique().withLength(min: 6, max: 32)();
  TextColumn get password => text()();
}
