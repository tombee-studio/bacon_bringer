import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/category_data.dart';
import 'package:bacon_bringer/data/user_data.dart';
import 'package:bacon_bringer/database/app_database.dart';
import 'package:bacon_bringer/enum/major_state.dart';
import 'package:bacon_bringer/enum/minor_state.dart';
import 'package:bacon_bringer/repository/category_screen_repository.dart';
import 'package:drift/drift.dart';

class CategoryScreenAppRepository extends CategoryScreenRepository {
  @override
  Future<CategoryData> create(AccountData account, String name,
      MajorState major, MinorState minor) async {
    final db = AppDatabase();
    final categoryId = await db.into(db.dBCategoryDataClass).insert(
        DBCategoryDataClassCompanion.insert(
            account: account.id,
            name: name,
            major: major.index,
            minor: minor.index));
    final row = await (db.select(db.dBCategoryDataClass)
          ..where((tbl) => tbl.id.equals(categoryId)))
        .join([
      innerJoin(db.dBAccountDataClass,
          db.dBAccountDataClass.id.equalsExp(db.dBCategoryDataClass.account)),
      innerJoin(db.dBUserDataClass,
          db.dBUserDataClass.userName.equalsExp(db.dBAccountDataClass.user))
    ]).getSingle();
    final dbUser = row.readTable(db.dBUserDataClass);
    final dbAccount = row.readTable(db.dBAccountDataClass);
    final dbCategoryData = row.readTable(db.dBCategoryDataClass);
    return CategoryData(
        account: AccountData(
            id: dbAccount.id,
            user: UserData(
                id: dbUser.id,
                userName: dbUser.userName,
                password: dbUser.password),
            name: dbAccount.name,
            purpose: dbAccount.purpose),
        major: MajorState.values[dbCategoryData.major],
        minor: MinorState.values[dbCategoryData.minor],
        name: dbCategoryData.name);
  }
}
