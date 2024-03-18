import 'package:bacon_bringer/bases/model.dart';
import 'package:bacon_bringer/bases/property.dart';
import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/minor_category_data.dart';
import 'package:bacon_bringer/enum/major_state.dart';
import 'package:bacon_bringer/repository/minor_category_screen_repository.dart';

class MinorCategoryScreenModel extends Model<MinorCategoryScreenRepository> {
  late Property<AccountData> _account;
  late Property<String> _name;
  late Property<MajorState> _major;

  set name(String name) => _name.value = name;
  set major(MajorState major) => _major.value = major;

  String get name => _name.value;
  MajorState get major => _major.value;

  MinorCategoryScreenModel(
      super.notifier, super.provider, AccountData account) {
    _name = propertyOf("");
    _major = propertyOf(MajorState.expense);
    _account = propertyOf(account);
  }

  Future<MinorCategoryData> create() {
    return repository.create(_account.value, _name.value, _major.value);
  }
}
