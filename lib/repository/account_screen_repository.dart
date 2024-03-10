import 'package:bacon_bringer/bases/repository.dart';
import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/user_data.dart';

abstract class AccountScreenRepository implements Repository {
  Future<AccountData> addAccount(UserData user, String name, String purpose);
}
