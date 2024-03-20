import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/category_data.dart';
import 'package:bacon_bringer/data/transaction_data.dart';
import 'package:bacon_bringer/database/app_database.dart';
import 'package:bacon_bringer/enum/major_state.dart';

class OverviewData {
  final double sumOfMoney;
  final double balanceAgainstBudget;
  final double budget;
  final double totalExpencesOnMonth;
  final double totalIncomesOnMonth;

  OverviewData(
      {required this.sumOfMoney,
      required this.balanceAgainstBudget,
      required this.budget,
      required this.totalExpencesOnMonth,
      required this.totalIncomesOnMonth});

  static Future<OverviewData> create(
      AppDatabase db, AccountData account) async {
    final transactions = await TransactionData.fetchList(db, account);
    final categories = await CategoryData.fetchList(db, account);
    final expenseTransactionList = transactions
        .where((transaction) =>
            transaction.category.minor.majorCategory == MajorState.expense)
        .map((transaction) => transaction.money);
    final incomeTransactionList = transactions
        .where((transaction) =>
            transaction.category.minor.majorCategory == MajorState.income)
        .map((transaction) => transaction.money);
    final budget = categories.isEmpty
        ? 0.0
        : categories.map((category) => category.budget).reduce((a, b) => a + b);
    final monthlyTotalExpense = expenseTransactionList.isEmpty
        ? 0.0
        : expenseTransactionList.reduce((a, b) => a + b);
    final monthlyTotalIncome = incomeTransactionList.isEmpty
        ? 0.0
        : incomeTransactionList.reduce((a, b) => a + b);
    final balanceAgainstBudget = budget - monthlyTotalExpense;
    final sumOfMoney = monthlyTotalIncome - monthlyTotalExpense;
    return OverviewData(
        sumOfMoney: sumOfMoney,
        balanceAgainstBudget: balanceAgainstBudget,
        budget: budget,
        totalExpencesOnMonth: monthlyTotalExpense,
        totalIncomesOnMonth: monthlyTotalIncome);
  }
}
