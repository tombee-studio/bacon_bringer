import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/enum/major_state.dart';
import 'package:bacon_bringer/enum/minor_state.dart';

class CategoryData {
  final int id;
  final AccountData account;
  final MajorState major;
  final MinorState minor;
  final String name;

  CategoryData(
      {required this.id,
      required this.account,
      required this.major,
      required this.minor,
      required this.name});
}
