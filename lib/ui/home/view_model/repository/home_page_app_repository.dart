import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/category_budget.dart';
import 'package:bacon_bringer/data/category_data.dart';
import 'package:bacon_bringer/data/overview_data.dart';
import 'package:bacon_bringer/data/transaction_data.dart';
import 'package:bacon_bringer/data/transaction_overview_data.dart';
import 'package:bacon_bringer/data/user_data.dart';
import 'package:bacon_bringer/database/app_database.dart';
import 'package:bacon_bringer/enum/major_state.dart';
import 'package:bacon_bringer/enum/minor_state.dart';
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
    final dbUserData = await db.select(db.dBUserDataClass).get();
    return UserData(
        id: dbUserData.first.id,
        userName: dbUserData.first.userName,
        password: dbUserData.first.password);
  }

  @override
  Future connectDatabase() async {
    await Future.delayed(const Duration(milliseconds: 1000));
  }

  @override
  Future<OverviewData> fetchMonthlyOverview(AccountData account) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return OverviewData(
        sumOfMoney: 10000,
        balanceAgainstBudget: 2000,
        budget: 18000,
        totalExpencesOnMonth: 2000,
        totalIncomesOnMonth: 10000);
  }

  @override
  Future<List<CategoryBudget>> fetchCategoryBudgetList(
      AccountData account) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final data = <CategoryBudget>[];
    data.add(CategoryBudget(
        account: account,
        category: CategoryData(
            account: account,
            major: MajorState.expense,
            minor: MinorState.fixedCosts,
            name: "住宅費"),
        leftBudgetPerMonth: 55000,
        budgetPerDay: 0.0));
    data.add(CategoryBudget(
        account: account,
        category: CategoryData(
            account: account,
            major: MajorState.expense,
            minor: MinorState.fixedCosts,
            name: "水道光熱費"),
        leftBudgetPerMonth: 7298,
        budgetPerDay: 100.1));
    data.add(CategoryBudget(
        account: account,
        category: CategoryData(
            account: account,
            major: MajorState.expense,
            minor: MinorState.variableCosts,
            name: "食費"),
        leftBudgetPerMonth: 8258,
        budgetPerDay: 805.3));
    data.add(CategoryBudget(
        account: account,
        category: CategoryData(
            account: account,
            major: MajorState.expense,
            minor: MinorState.variableCosts,
            name: "食費"),
        leftBudgetPerMonth: 8258,
        budgetPerDay: 805.3));
    data.add(CategoryBudget(
        account: account,
        category: CategoryData(
            account: account,
            major: MajorState.expense,
            minor: MinorState.variableCosts,
            name: "食費"),
        leftBudgetPerMonth: 8258,
        budgetPerDay: 805.3));
    return data;
  }

  @override
  Future<List<AccountData>> fetchAccounts(UserData user) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final accounts = <AccountData>[];
    accounts.add(AccountData(
        user: user, name: "test account 01", purpose: "for test 1"));
    accounts.add(AccountData(
        user: user, name: "test account 02", purpose: "for test 1"));
    return accounts;
  }

  @override
  Future<List<TransactionData>> fetchTransactions(AccountData account,
      {required DateTime from, required DateTime to}) async {
    final transactions = <TransactionData>[];
    transactions.add(TransactionData(
        purpose: "test purpose 1",
        money: 1000.0,
        category: CategoryData(
            account: account,
            major: MajorState.expense,
            minor: MinorState.fixedCosts,
            name: "test name 1"),
        createdAt: DateTime(3000)));
    transactions.add(TransactionData(
        purpose: "test purpose 2",
        money: 2000.0,
        category: CategoryData(
            account: account,
            major: MajorState.expense,
            minor: MinorState.variableCosts,
            name: "test name 2"),
        createdAt: DateTime(3100)));
    transactions.add(TransactionData(
        purpose: "test purpose 3",
        money: 2000.0,
        category: CategoryData(
            account: account,
            major: MajorState.income,
            minor: MinorState.fixedIncome,
            name: "test name 3"),
        createdAt: DateTime(3200)));
    transactions.add(TransactionData(
        purpose: "test purpose 4",
        money: 3300.0,
        category: CategoryData(
            account: account,
            major: MajorState.income,
            minor: MinorState.variableIncome,
            name: "test name 4"),
        createdAt: DateTime(3200)));
    return transactions;
  }

  @override
  Future<TransactionOverviewData> fetchTransactionOverview(AccountData account,
      {required DateTime from, required DateTime to}) async {
    return TransactionOverviewData(1000.0, 2000.0, from, to);
  }
}
