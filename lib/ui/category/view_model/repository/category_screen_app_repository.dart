import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/category_data.dart';
import 'package:bacon_bringer/enum/major_state.dart';
import 'package:bacon_bringer/enum/minor_state.dart';
import 'package:bacon_bringer/repository/category_screen_repository.dart';

class CategoryScreenAppRepository extends CategoryScreenRepository {
  @override
  Future<CategoryData> create(AccountData account, String name,
      MajorState major, MinorState minor) async {
    return CategoryData(
        account: account, major: major, minor: minor, name: name);
  }
}
