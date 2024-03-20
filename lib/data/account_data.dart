import 'package:bacon_bringer/data/user_data.dart';
import 'package:bacon_bringer/database/app_database.dart';
import 'package:drift/drift.dart';

class AccountData {
  final int id;
  final UserData user;
  final String name;
  final String purpose;

  AccountData(
      {required this.id,
      required this.user,
      required this.name,
      required this.purpose});

  static Future<List<AccountData>> fetchList(
      AppDatabase db, UserData user) async {
    final dbAccounts = await db.select(db.dBAccountDataClass).join([
      innerJoin(db.dBUserDataClass,
          db.dBUserDataClass.userName.equalsExp(db.dBAccountDataClass.user))
    ]).get();
    final accounts = dbAccounts.map((row) {
      final dbUser = row.readTable(db.dBUserDataClass);
      final dbAccount = row.readTable(db.dBAccountDataClass);
      return AccountData(
          id: dbAccount.id,
          user: UserData(
              id: dbUser.id,
              userName: dbUser.userName,
              password: dbUser.password),
          name: dbAccount.name,
          purpose: dbAccount.purpose);
    }).toList();
    return accounts;
  }
}
