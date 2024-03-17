import 'package:drift/drift.dart';

@DataClassName('DBTransactionData')
class DBTransactionDataClass extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get account => integer()();
  IntColumn get category => integer()();
  TextColumn get purpose => text()();
  RealColumn get money => real()();
  DateTimeColumn get transactionDate => dateTime()();
}
