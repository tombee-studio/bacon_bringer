import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/category_data.dart';
import 'package:bacon_bringer/data/minor_category_data.dart';
import 'package:bacon_bringer/data/user_data.dart';
import 'package:bacon_bringer/database/app_database.dart';
import 'package:bacon_bringer/enum/major_state.dart';
import 'package:drift/drift.dart';

class TransactionData {
  final AccountData account;
  final String purpose;
  final double money;
  final CategoryData category;
  final DateTime transactionDate;

  TransactionData(
      {required this.account,
      required this.purpose,
      required this.money,
      required this.category,
      required this.transactionDate});

  static Future<List<TransactionData>> fetchList(
      AppDatabase db, AccountData account) async {
    final rows = await (db.select(db.dBTransactionDataClass)
          ..where((tbl) => tbl.account.equals(account.id)))
        .join([
      innerJoin(
          db.dBCategoryDataClass,
          db.dBCategoryDataClass.id
              .equalsExp(db.dBTransactionDataClass.category)),
      innerJoin(
          db.dBAccountDataClass,
          db.dBAccountDataClass.id
              .equalsExp(db.dBTransactionDataClass.account)),
      innerJoin(
          db.dBMinorCategoryDataClass,
          db.dBMinorCategoryDataClass.id
              .equalsExp(db.dBCategoryDataClass.minor)),
      innerJoin(db.dBUserDataClass,
          db.dBUserDataClass.userName.equalsExp(db.dBAccountDataClass.user))
    ]).get();

    return rows.map((row) {
      final dbUser = row.readTable(db.dBUserDataClass);
      final dbAccount = row.readTable(db.dBAccountDataClass);
      final dbCategoryData = row.readTable(db.dBCategoryDataClass);
      final dbTransactionData = row.readTable(db.dBTransactionDataClass);
      final dbMinorCategoryData = row.readTable(db.dBMinorCategoryDataClass);
      final retAccount = AccountData(
          id: dbAccount.id,
          user: UserData(
              id: dbUser.id,
              userName: dbUser.userName,
              password: dbUser.password),
          name: dbAccount.name,
          purpose: dbAccount.purpose);
      return TransactionData(
          account: retAccount,
          purpose: dbTransactionData.purpose,
          money: dbTransactionData.money,
          category: CategoryData(
              id: dbCategoryData.id,
              account: retAccount,
              major: MajorState.values[dbCategoryData.major],
              minor: MinorCategoryData(
                  id: dbMinorCategoryData.id,
                  account: account,
                  majorCategory: MajorState.values[dbMinorCategoryData.major],
                  name: dbMinorCategoryData.name),
              name: dbCategoryData.name,
              budget: dbCategoryData.budget),
          transactionDate: dbTransactionData.transactionDate);
    }).toList();
  }
}
