import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/minor_category_data.dart';
import 'package:bacon_bringer/data/user_data.dart';
import 'package:bacon_bringer/database/app_database.dart';
import 'package:bacon_bringer/enum/major_state.dart';
import 'package:drift/drift.dart';

class CategoryData {
  final int id;
  final AccountData account;
  final MajorState major;
  final MinorCategoryData minor;
  final String name;
  final double budget;

  CategoryData(
      {required this.id,
      required this.account,
      required this.major,
      required this.minor,
      required this.name,
      required this.budget});

  static Future<List<CategoryData>> fetchList(
      AppDatabase db, AccountData account) async {
    final rows = await (db.select(db.dBCategoryDataClass)
          ..where((tbl) => tbl.account.equals(account.id)))
        .join([
      innerJoin(db.dBAccountDataClass,
          db.dBAccountDataClass.id.equalsExp(db.dBCategoryDataClass.account)),
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
      final dbMinorCategoryData = row.readTable(db.dBMinorCategoryDataClass);
      return CategoryData(
          id: dbCategoryData.id,
          account: AccountData(
              id: dbAccount.id,
              user: UserData(
                  id: dbUser.id,
                  userName: dbUser.userName,
                  password: dbUser.password),
              name: dbAccount.name,
              purpose: dbAccount.purpose),
          major: MajorState.values[dbCategoryData.major],
          minor: MinorCategoryData(
              id: dbMinorCategoryData.id,
              account: account,
              majorCategory: MajorState.values[dbMinorCategoryData.major],
              name: dbMinorCategoryData.name),
          name: dbCategoryData.name,
          budget: dbCategoryData.budget);
    }).toList();
  }
}
