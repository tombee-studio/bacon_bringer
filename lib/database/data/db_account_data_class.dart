import 'package:drift/drift.dart';

@DataClassName('DBAccountData')
class DBAccountDataClass extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get user => text().withLength(min: 6, max: 32)();
  TextColumn get name => text()();
  TextColumn get purpose => text()();
}
