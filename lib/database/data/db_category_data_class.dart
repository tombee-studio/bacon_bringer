import 'package:drift/drift.dart';

@DataClassName('DBCategoryData')
class DBCategoryDataClass extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get account => integer()();
  TextColumn get name => text()();
  IntColumn get major => integer()();
  IntColumn get minor => integer()();
  RealColumn get budget => real()();
}
