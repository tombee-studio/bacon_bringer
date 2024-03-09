import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/user_data.dart';
import 'package:bacon_bringer/repository/account_screen_repository.dart';

class AccountScreenAppRepository extends AccountScreenRepository {
  @override
  Future<AccountData> addAccount(
      UserData user, String name, String purpose) async {
    await Future.delayed(const Duration(microseconds: 500));
    return AccountData(user: user, name: name, purpose: purpose);
  }
}
