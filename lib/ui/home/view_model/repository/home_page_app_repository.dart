import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/category_budget.dart';
import 'package:bacon_bringer/data/category_data.dart';
import 'package:bacon_bringer/data/minor_category_data.dart';
import 'package:bacon_bringer/data/overview_data.dart';
import 'package:bacon_bringer/data/transaction_data.dart';
import 'package:bacon_bringer/data/transaction_overview_data.dart';
import 'package:bacon_bringer/data/user_data.dart';
import 'package:bacon_bringer/database/app_database.dart';
import 'package:bacon_bringer/enum/major_state.dart';
import 'package:bacon_bringer/exceptions/not_created_account_error.dart';
import 'package:bacon_bringer/exceptions/unauthenticated_user_error.dart';
import 'package:bacon_bringer/repository/home_screen_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenAppRepository extends HomeScreenRepository {
  @override
  Future<int> loadLocalData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt("userId");
    if (id == null) {
      throw UnauthenticatedUserError();
    }
    return id;
  }

  @override
  Future<UserData> authenticate(int userId) async {
    final db = AppDatabase();
    final dbUserData = await (db.select(db.dBUserDataClass)
          ..where((user) => user.id.equals(userId)))
        .getSingle();
    return UserData(
        id: dbUserData.id,
        userName: dbUserData.userName,
        password: dbUserData.password);
  }

  @override
  Future connectDatabase() async {
    await Future.delayed(const Duration(milliseconds: 1000));
  }

  @override
  Future<OverviewData> fetchMonthlyOverview(AccountData account) async {
    final db = AppDatabase();
    final transactions = await TransactionData.fetchList(db, account);
    final categories = await CategoryData.fetchList(db, account);
    final expenseTransactionList = transactions
        .where(
            (transaction) => transaction.category.major == MajorState.expense)
        .map((transaction) => transaction.money);
    final incomeTransactionList = transactions
        .where((transaction) => transaction.category.major == MajorState.income)
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

  @override
  Future<List<CategoryBudget>> fetchCategoryBudgetList(
      AccountData account) async {
    final db = AppDatabase();
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

  @override
  Future<List<AccountData>> fetchAccounts(UserData user) async {
    final db = AppDatabase();
    final accounts = await AccountData.fetchList(db, user);
    if (accounts.isEmpty) {
      throw NotCreatedAccountError();
    }
    return accounts;
  }

  @override
  Future<List<TransactionData>> fetchTransactions(AccountData account,
      {required DateTime from, required DateTime to}) async {
    final db = AppDatabase();
    return await TransactionData.fetchList(db, account);
  }

  @override
  Future<TransactionOverviewData> fetchTransactionOverview(AccountData account,
      {required DateTime from, required DateTime to}) async {
    final db = AppDatabase();
    final transactions = await TransactionData.fetchList(db, account);
    final expenseTransactionList = transactions
        .where(
            (transaction) => transaction.category.major == MajorState.expense)
        .map((transaction) => transaction.money);
    final incomeTransactionList = transactions
        .where((transaction) => transaction.category.major == MajorState.income)
        .map((transaction) => transaction.money);
    final monthlyTotalExpense = expenseTransactionList.isEmpty
        ? 0.0
        : expenseTransactionList.reduce((a, b) => a + b);
    final monthlyTotalIncome = incomeTransactionList.isEmpty
        ? 0.0
        : incomeTransactionList.reduce((a, b) => a + b);
    return TransactionOverviewData(
        monthlyTotalExpense, monthlyTotalIncome, from, to);
  }

  @override
  Future<List<CategoryData>> fetchCategoryList(AccountData account) async {
    final db = AppDatabase();
    return await CategoryData.fetchList(db, account);
  }

  @override
  Future<List<MinorCategoryData>> fetchMinorCategoryList(
      AccountData account) async {
    final db = AppDatabase();
    return await MinorCategoryData.fetchList(db, account);
  }
}
