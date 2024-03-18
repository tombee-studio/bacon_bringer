import 'package:drift/drift.dart';

@DataClassName('DBMinorCategoryData')
class DBMinorCategoryDataClass extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get account => integer()();
  IntColumn get major => integer()();
  TextColumn get name => text().unique().withLength(min: 6, max: 32)();
}
