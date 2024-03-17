import 'package:bacon_bringer/bases/repository.dart';
import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/category_data.dart';
import 'package:bacon_bringer/enum/major_state.dart';
import 'package:bacon_bringer/enum/minor_state.dart';

abstract class CategoryScreenRepository extends Repository {
  Future<CategoryData> create(
      AccountData account, String name, MajorState major, MinorState minor);
}
