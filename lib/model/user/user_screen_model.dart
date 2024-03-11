import 'package:bacon_bringer/bases/model.dart';
import 'package:bacon_bringer/bases/property.dart';
import 'package:bacon_bringer/data/user_data.dart';
import 'package:bacon_bringer/repository/user_screen_repository.dart';

class UserScreenModel extends Model<UserScreenRepository> {
  late Property<String> _name;
  late Property<String> _password;
  late Property<String> _password2;

  set name(String name) => _name.value = name;
  set password(String password) => _password.value = password;
  set password2(String password2) => _password2.value = password2;

  String get name => _name.value;
  String get password => _password.value;
  String get password2 => _password2.value;

  UserScreenModel(super.notifier, super.provider) {
    _name = propertyOf("");
    _password = propertyOf("");
    _password2 = propertyOf("");
  }

  Future<UserData> authenticate() {
    return repository.signup(name, password, password2);
  }
}
