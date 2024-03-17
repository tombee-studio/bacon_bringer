import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/category_data.dart';
import 'package:bacon_bringer/data/transaction_data.dart';
import 'package:bacon_bringer/data/user_data.dart';
import 'package:bacon_bringer/database/app_database.dart';
import 'package:bacon_bringer/enum/major_state.dart';
import 'package:bacon_bringer/enum/minor_state.dart';
import 'package:bacon_bringer/repository/transaction_screen_repository.dart';
import 'package:drift/drift.dart';

class TransactionScreenAppRepository extends TransactionScreenRepository {
  @override
  Future<TransactionData> create(AccountData account, String purpose,
      double money, CategoryData category, DateTime transactionDate) async {
    final db = AppDatabase();
    final transactionId = await db.into(db.dBTransactionDataClass).insert(
        DBTransactionDataClassCompanion.insert(
            account: account.id,
            category: category.id,
            purpose: purpose,
            money: money,
            transactionDate: transactionDate));

    final row = await (db.select(db.dBTransactionDataClass)
          ..where((tbl) => tbl.id.equals(transactionId)))
        .join([
      innerJoin(
          db.dBCategoryDataClass,
          db.dBCategoryDataClass.id
              .equalsExp(db.dBTransactionDataClass.category)),
      innerJoin(
          db.dBAccountDataClass,
          db.dBAccountDataClass.id
              .equalsExp(db.dBTransactionDataClass.account)),
      innerJoin(db.dBUserDataClass,
          db.dBUserDataClass.userName.equalsExp(db.dBAccountDataClass.user))
    ]).getSingle();

    final dbUser = row.readTable(db.dBUserDataClass);
    final dbAccount = row.readTable(db.dBAccountDataClass);
    final dbCategoryData = row.readTable(db.dBCategoryDataClass);
    final dbTransactionData = row.readTable(db.dBTransactionDataClass);

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
            minor: MinorState.values[dbCategoryData.minor],
            name: dbCategoryData.name),
        transactionDate: dbTransactionData.transactionDate);
  }
}
