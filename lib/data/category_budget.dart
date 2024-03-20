import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/category_data.dart';
import 'package:bacon_bringer/data/transaction_data.dart';
import 'package:bacon_bringer/database/app_database.dart';

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

  static Future<List<CategoryBudget>> createList(
      AppDatabase db, AccountData account) async {
    final transactions = await TransactionData.fetchList(db, account);
    final categories = await CategoryData.fetchList(db, account);

    return categories.map((category) {
      final transactionsByCategory = transactions
          .where((transaction) => transaction.category.id == category.id)
          .map((transaction) => transaction.money)
          .toList();
      final expenses = transactionsByCategory.isEmpty
          ? 0.0
          : transactionsByCategory.reduce((a, b) => a + b);

      final leftBudgetPerMonth = category.budget - expenses;
      final budgetPerDay = category.budget / 31;

      return CategoryBudget(
          account: category.account,
          category: category,
          leftBudgetPerMonth: leftBudgetPerMonth.toInt(),
          budgetPerDay: budgetPerDay);
    }).toList();
  }
}
