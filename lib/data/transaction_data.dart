import 'package:bacon_bringer/data/category_data.dart';

class TransactionData {
  final String purpose;
  final double money;
  final CategoryData category;
  final DateTime createdAt;

  TransactionData(
      {required this.purpose,
      required this.money,
      required this.category,
      required this.createdAt});
}
