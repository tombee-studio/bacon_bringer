import 'package:bacon_bringer/bases/model.dart';
import 'package:bacon_bringer/bases/property.dart';
import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/user_data.dart';
import 'package:bacon_bringer/repository/account_screen_repository.dart';

class AccountScreenModel extends Model<AccountScreenRepository> {
  late Property<UserData> _user;
  late Property<String> _name;
  late Property<String> _purpose;

  UserData get user => _user.value;

  set name(String value) => _name.value = value;
  String get name => _name.value;

  set purpose(String value) => _purpose.value = value;
  String get purpose => _purpose.value;

  AccountScreenModel(super.notifier, UserData user, super.provider) {
    _user = propertyOf<UserData>(user);
    _name = propertyOf("");
    _purpose = propertyOf("");
  }

  Future<AccountData> addAccount() async {
    return await repository.addAccount(user, _name.value, _purpose.value);
  }
}
