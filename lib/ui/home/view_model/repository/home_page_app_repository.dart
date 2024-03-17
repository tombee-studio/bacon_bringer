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
import 'package:bacon_bringer/exceptions/not_created_account_error.dart';
import 'package:bacon_bringer/exceptions/unauthenticated_user_error.dart';
import 'package:bacon_bringer/repository/home_screen_repository.dart';
import 'package:drift/drift.dart';
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
    final db = AppDatabase();
    final dbAccounts = await db.select(db.dBAccountDataClass).join([
      innerJoin(db.dBUserDataClass,
          db.dBUserDataClass.userName.equalsExp(db.dBAccountDataClass.user))
    ]).get();
    final accounts = dbAccounts.map((row) {
      final dbUser = row.readTable(db.dBUserDataClass);
      final dbAccount = row.readTable(db.dBAccountDataClass);
      return AccountData(
          id: dbAccount.id,
          user: UserData(
              id: dbUser.id,
              userName: dbUser.userName,
              password: dbUser.password),
          name: dbAccount.name,
          purpose: dbAccount.purpose);
    }).toList();
    if (accounts.isEmpty) {
      throw NotCreatedAccountError();
    }
    return accounts;
  }

  @override
  Future<List<TransactionData>> fetchTransactions(AccountData account,
      {required DateTime from, required DateTime to}) async {
    final transactions = <TransactionData>[];
    transactions.add(TransactionData(
        account: account,
        purpose: "test purpose 1",
        money: 1000.0,
        category: CategoryData(
            account: account,
            major: MajorState.expense,
            minor: MinorState.fixedCosts,
            name: "test name 1"),
        transactionDate: DateTime(3000)));
    transactions.add(TransactionData(
        account: account,
        purpose: "test purpose 2",
        money: 2000.0,
        category: CategoryData(
            account: account,
            major: MajorState.expense,
            minor: MinorState.variableCosts,
            name: "test name 2"),
        transactionDate: DateTime(3100)));
    transactions.add(TransactionData(
        account: account,
        purpose: "test purpose 3",
        money: 2000.0,
        category: CategoryData(
            account: account,
            major: MajorState.income,
            minor: MinorState.fixedIncome,
            name: "test name 3"),
        transactionDate: DateTime(3200)));
    transactions.add(TransactionData(
        account: account,
        purpose: "test purpose 4",
        money: 3300.0,
        category: CategoryData(
            account: account,
            major: MajorState.income,
            minor: MinorState.variableIncome,
            name: "test name 4"),
        transactionDate: DateTime(3200)));
    return transactions;
  }

  @override
  Future<TransactionOverviewData> fetchTransactionOverview(AccountData account,
      {required DateTime from, required DateTime to}) async {
    return TransactionOverviewData(1000.0, 2000.0, from, to);
  }

  @override
  Future<List<CategoryData>> fetchCategoryList(AccountData account) async {
    final db = AppDatabase();
    final rows = await (db.select(db.dBCategoryDataClass)
          ..where((tbl) => tbl.account.equals(account.id)))
        .join([
      innerJoin(db.dBAccountDataClass,
          db.dBAccountDataClass.id.equalsExp(db.dBCategoryDataClass.account)),
      innerJoin(db.dBUserDataClass,
          db.dBUserDataClass.userName.equalsExp(db.dBAccountDataClass.user))
    ]).get();
    return rows.map((row) {
      final dbUser = row.readTable(db.dBUserDataClass);
      final dbAccount = row.readTable(db.dBAccountDataClass);
      final dbCategoryData = row.readTable(db.dBCategoryDataClass);
      return CategoryData(
          account: AccountData(
              id: dbAccount.id,
              user: UserData(
                  id: dbUser.id,
                  userName: dbUser.userName,
                  password: dbUser.password),
              name: dbAccount.name,
              purpose: dbAccount.purpose),
          major: MajorState.values[dbCategoryData.major],
          minor: MinorState.values[dbCategoryData.minor],
          name: dbCategoryData.name);
    }).toList();
  }
}
