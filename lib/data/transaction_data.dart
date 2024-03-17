import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/category_data.dart';

class TransactionData {
  final AccountData account;
  final String purpose;
  final double money;
  final CategoryData category;
  final DateTime transactionDate;

  TransactionData(
      {required this.account,
      required this.purpose,
      required this.money,
      required this.category,
      required this.transactionDate});
}
