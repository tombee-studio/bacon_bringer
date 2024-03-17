import 'package:bacon_bringer/data/user_data.dart';

class AccountData {
  final int id;
  final UserData user;
  final String name;
  final String purpose;

  AccountData(
      {required this.id,
      required this.user,
      required this.name,
      required this.purpose});
}
