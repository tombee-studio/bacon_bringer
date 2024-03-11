import 'package:bacon_bringer/data/user_data.dart';
import 'package:bacon_bringer/repository/user_screen_repository.dart';

class UserScreenAppRepository extends UserScreenRepository {
  @override
  Future<UserData> signup(
      String userName, String password1, String password2) async {
    return UserData(id: "test", userName: userName, password: password1);
  }
}
