import 'package:bacon_bringer/bases/repository.dart';
import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/category_data.dart';
import 'package:bacon_bringer/data/minor_category_data.dart';
import 'package:bacon_bringer/enum/major_state.dart';

abstract class CategoryScreenRepository extends Repository {
  Future<CategoryData> create(AccountData account, String name,
      MajorState major, MinorCategoryData minor);
}
