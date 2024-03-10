import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/category_data.dart';

class CategoryBudget {
  final AccountData account;
  final CategoryData category;
  final int leftBudgetPerMonth;
  final double budgetPerDay;

  CategoryBudget(
      {required this.account,
      required this.category,
      required this.leftBudgetPerMonth,
      required this.budgetPerDay});
}
