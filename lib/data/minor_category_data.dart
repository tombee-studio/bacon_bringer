import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/enum/major_state.dart';

class MinorCategoryData {
  final int id;
  final AccountData account;
  final MajorState majorCategory;
  final String name;

  MinorCategoryData(
      {required this.id,
      required this.account,
      required this.majorCategory,
      required this.name});
}
