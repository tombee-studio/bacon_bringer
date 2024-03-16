import 'package:bacon_bringer/bases/repository.dart';
import 'package:bacon_bringer/data/user_data.dart';

abstract class UserScreenRepository extends Repository {
  Future<UserData> signup(String userName, String password, String password2);
}
