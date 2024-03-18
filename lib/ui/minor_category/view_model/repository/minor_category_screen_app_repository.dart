import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/minor_category_data.dart';
import 'package:bacon_bringer/data/user_data.dart';
import 'package:bacon_bringer/database/app_database.dart';
import 'package:bacon_bringer/enum/major_state.dart';
import 'package:bacon_bringer/repository/minor_category_screen_repository.dart';
import 'package:drift/drift.dart';

class MinorCategoryScreenAppRepository extends MinorCategoryScreenRepository {
  @override
  Future<MinorCategoryData> create(
      AccountData account, String name, MajorState major) async {
    final db = AppDatabase();
    final minorCategoryId = await db.into(db.dBMinorCategoryDataClass).insert(
        DBMinorCategoryDataClassCompanion.insert(
            account: account.id, name: name, major: major.index));
    final row = await (db.select(db.dBMinorCategoryDataClass)
          ..where((tbl) => tbl.id.equals(minorCategoryId)))
        .join([
      innerJoin(db.dBUserDataClass,
          db.dBUserDataClass.userName.equalsExp(db.dBAccountDataClass.user)),
      innerJoin(
          db.dBAccountDataClass,
          db.dBAccountDataClass.id
              .equalsExp(db.dBMinorCategoryDataClass.account)),
    ]).getSingle();
    final dbMinorCategoryData = row.readTable(db.dBMinorCategoryDataClass);
    final dbUser = row.readTable(db.dBUserDataClass);
    final dbAccount = row.readTable(db.dBAccountDataClass);
    return MinorCategoryData(
        id: dbMinorCategoryData.id,
        account: AccountData(
            id: dbAccount.id,
            user: UserData(
                id: dbUser.id,
                userName: dbUser.userName,
                password: dbUser.password),
            name: dbAccount.name,
            purpose: dbAccount.purpose),
        majorCategory: MajorState.values[dbMinorCategoryData.major],
        name: dbMinorCategoryData.name);
  }
}
