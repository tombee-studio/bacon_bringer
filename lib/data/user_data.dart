import 'package:bacon_bringer/data/account_data.dart';

class UserData {
  final String id;
  final String userName;
  final String password;
  final List<AccountData> accounts;

  UserData(
      {required this.id,
      required this.userName,
      required this.password,
      required this.accounts});
}
