import 'package:bacon_bringer/data/user_data.dart';
import 'package:bacon_bringer/database/app_database.dart';
import 'package:bacon_bringer/repository/user_screen_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserScreenAppRepository extends UserScreenRepository {
  @override
  Future<UserData> signup(
      String userName, String password, String password2) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final db = AppDatabase();
    final dbUserData = await db.into(db.dBUserDataClass).insertReturning(
        DBUserDataClassCompanion.insert(
            userName: userName, password: password));
    await prefs.setInt("userId", dbUserData.id);
    return UserData(id: dbUserData.id, userName: userName, password: password);
  }
}
