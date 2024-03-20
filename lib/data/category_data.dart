import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/minor_category_data.dart';
import 'package:bacon_bringer/enum/major_state.dart';

class CategoryData {
  final int id;
  final AccountData account;
  final MajorState major;
  final MinorCategoryData minor;
  final String name;
  final double budget;

  CategoryData(
      {required this.id,
      required this.account,
      required this.major,
      required this.minor,
      required this.name,
      required this.budget});
}
