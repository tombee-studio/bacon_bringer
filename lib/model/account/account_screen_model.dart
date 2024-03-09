import 'package:bacon_bringer/bases/model.dart';
import 'package:bacon_bringer/bases/property.dart';
import 'package:bacon_bringer/data/user_data.dart';

class AccountScreenModel extends Model {
  late Property<UserData> _user;

  UserData get user => _user.value;

  AccountScreenModel(super.notifier, UserData user, super.provider) {
    _user = propertyOf<UserData>(user);
  }
}
