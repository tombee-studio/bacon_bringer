import 'package:bacon_bringer/bases/model.dart';
import 'package:bacon_bringer/bases/property.dart';
import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/category_data.dart';
import 'package:bacon_bringer/data/minor_category_data.dart';
import 'package:bacon_bringer/enum/major_state.dart';
import 'package:bacon_bringer/repository/category_screen_repository.dart';

class CategoryScreenModel extends Model<CategoryScreenRepository> {
  late Property<AccountData> _account;
  late Property<String> _name;
  late Property<MajorState> _major;
  late Property<MinorCategoryData> _minor;

  set name(String name) => _name.value = name;
  set major(MajorState major) => _major.value = major;
  set minor(MinorCategoryData minor) => _minor.value = minor;

  String get name => _name.value;
  MajorState get major => _major.value;
  MinorCategoryData get minor => _minor.value;

  CategoryScreenModel(super.notifier, super.provider, AccountData account) {
    _name = propertyOf("");
    _major = propertyOf(MajorState.expense);
    _minor = propertyOf(MinorCategoryData(
        id: 0, account: account, majorCategory: MajorState.expense, name: ''));
    _account = propertyOf(account);
  }

  Future<CategoryData> create() {
    return repository.create(
        _account.value, _name.value, _major.value, _minor.value);
  }
}
