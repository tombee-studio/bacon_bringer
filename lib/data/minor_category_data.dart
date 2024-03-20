import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/user_data.dart';
import 'package:bacon_bringer/database/app_database.dart';
import 'package:bacon_bringer/enum/major_state.dart';
import 'package:drift/drift.dart';

class MinorCategoryData {
  final int id;
  final AccountData account;
  final MajorState majorCategory;
  final String name;

  MinorCategoryData(
      {required this.id,
      required this.account,
      required this.majorCategory,
      required this.name});

  static Future<List<MinorCategoryData>> fetchList(
      AppDatabase db, AccountData account) async {
    final rows = await (db.select(db.dBMinorCategoryDataClass)
          ..where((tbl) => tbl.account.equals(account.id)))
        .join([
      innerJoin(
          db.dBAccountDataClass,
          db.dBAccountDataClass.id
              .equalsExp(db.dBMinorCategoryDataClass.account)),
      innerJoin(db.dBUserDataClass,
          db.dBUserDataClass.userName.equalsExp(db.dBAccountDataClass.user))
    ]).get();
    return rows.map((row) {
      final dbUser = row.readTable(db.dBUserDataClass);
      final dbAccount = row.readTable(db.dBAccountDataClass);
      final dbMinorCategoryData = row.readTable(db.dBMinorCategoryDataClass);

      final retAccount = AccountData(
          id: dbAccount.id,
          user: UserData(
              id: dbUser.id,
              userName: dbUser.userName,
              password: dbUser.password),
          name: dbAccount.name,
          purpose: dbAccount.purpose);
      return MinorCategoryData(
          id: dbMinorCategoryData.id,
          account: retAccount,
          majorCategory: MajorState.values[dbMinorCategoryData.major],
          name: dbMinorCategoryData.name);
    }).toList();
  }
}
