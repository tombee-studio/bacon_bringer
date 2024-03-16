import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/user_data.dart';
import 'package:bacon_bringer/database/app_database.dart';
import 'package:bacon_bringer/repository/account_screen_repository.dart';
import 'package:drift/drift.dart';

class AccountScreenAppRepository extends AccountScreenRepository {
  @override
  Future<AccountData> addAccount(
      UserData user, String name, String purpose) async {
    final db = AppDatabase();
    final accountId = await db.into(db.dBAccountDataClass).insert(
        DBAccountDataClassCompanion(
            user: Value(user.userName),
            name: Value(name),
            purpose: Value(purpose)));
    final row = await (db.select(db.dBAccountDataClass)
          ..where((tbl) => tbl.id.equals(accountId)))
        .join([
      innerJoin(db.dBUserDataClass,
          db.dBUserDataClass.userName.equalsExp(db.dBAccountDataClass.user))
    ]).getSingle();

    final dbUser = row.readTable(db.dBUserDataClass);
    final dbAccount = row.readTable(db.dBAccountDataClass);
    return AccountData(
        user: UserData(
            id: dbUser.id,
            userName: dbUser.userName,
            password: dbUser.password),
        name: dbAccount.name,
        purpose: dbAccount.purpose);
  }
}
