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
            id: 0,
            account: account,
            major: MajorState.expense,
            minor: MinorCategoryData(0, MajorState.expense, "固定費"),
            name: "住宅費"),
        leftBudgetPerMonth: 55000,
        budgetPerDay: 0.0));
    data.add(CategoryBudget(
        account: account,
        category: CategoryData(
            id: 1,
            account: account,
            major: MajorState.expense,
            minor: MinorCategoryData(0, MajorState.expense, "固定費"),
            name: "水道光熱費"),
        leftBudgetPerMonth: 7298,
        budgetPerDay: 100.1));
    data.add(CategoryBudget(
        account: account,
        category: CategoryData(
            id: 2,
            account: account,
            major: MajorState.expense,
            minor: MinorCategoryData(0, MajorState.expense, "固定費"),
            name: "食費"),
        leftBudgetPerMonth: 8258,
        budgetPerDay: 805.3));
    data.add(CategoryBudget(
        account: account,
        category: CategoryData(
            id: 3,
            account: account,
            major: MajorState.expense,
            minor: MinorCategoryData(0, MajorState.expense, "固定費"),
            name: "食費"),
        leftBudgetPerMonth: 8258,
        budgetPerDay: 805.3));
    data.add(CategoryBudget(
        account: account,
        category: CategoryData(
            id: 4,
            account: account,
            major: MajorState.expense,
            minor: MinorCategoryData(0, MajorState.expense, "固定費"),
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
    final db = AppDatabase();
    final rows = await (db.select(db.dBTransactionDataClass)
          ..where((tbl) => tbl.account.equals(account.id)))
        .join([
      innerJoin(
          db.dBCategoryDataClass,
          db.dBCategoryDataClass.id
              .equalsExp(db.dBTransactionDataClass.category)),
      innerJoin(
          db.dBAccountDataClass,
          db.dBAccountDataClass.id
              .equalsExp(db.dBTransactionDataClass.account)),
      innerJoin(
          db.dBMinorCategoryDataClass,
          db.dBMinorCategoryDataClass.id
              .equalsExp(db.dBCategoryDataClass.minor)),
      innerJoin(db.dBUserDataClass,
          db.dBUserDataClass.userName.equalsExp(db.dBAccountDataClass.user))
    ]).get();

    return rows.map((row) {
      final dbUser = row.readTable(db.dBUserDataClass);
      final dbAccount = row.readTable(db.dBAccountDataClass);
      final dbCategoryData = row.readTable(db.dBCategoryDataClass);
      final dbTransactionData = row.readTable(db.dBTransactionDataClass);
      final dbMinorCategoryData = row.readTable(db.dBMinorCategoryDataClass);
      final retAccount = AccountData(
          id: dbAccount.id,
          user: UserData(
              id: dbUser.id,
              userName: dbUser.userName,
              password: dbUser.password),
          name: dbAccount.name,
          purpose: dbAccount.purpose);
      return TransactionData(
          account: retAccount,
          purpose: dbTransactionData.purpose,
          money: dbTransactionData.money,
          category: CategoryData(
              id: dbCategoryData.id,
              account: retAccount,
              major: MajorState.values[dbCategoryData.major],
              minor: MinorCategoryData(
                  dbMinorCategoryData.id,
                  MajorState.values[dbMinorCategoryData.major],
                  dbMinorCategoryData.name),
              name: dbCategoryData.name),
          transactionDate: dbTransactionData.transactionDate);
    }).toList();
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
      innerJoin(
          db.dBMinorCategoryDataClass,
          db.dBMinorCategoryDataClass.id
              .equalsExp(db.dBCategoryDataClass.minor)),
      innerJoin(db.dBUserDataClass,
          db.dBUserDataClass.userName.equalsExp(db.dBAccountDataClass.user))
    ]).get();
    return rows.map((row) {
      final dbUser = row.readTable(db.dBUserDataClass);
      final dbAccount = row.readTable(db.dBAccountDataClass);
      final dbCategoryData = row.readTable(db.dBCategoryDataClass);
      final dbMinorCategoryData = row.readTable(db.dBMinorCategoryDataClass);
      return CategoryData(
          id: dbCategoryData.id,
          account: AccountData(
              id: dbAccount.id,
              user: UserData(
                  id: dbUser.id,
                  userName: dbUser.userName,
                  password: dbUser.password),
              name: dbAccount.name,
              purpose: dbAccount.purpose),
          major: MajorState.values[dbCategoryData.major],
          minor: MinorCategoryData(
              dbMinorCategoryData.id,
              MajorState.values[dbMinorCategoryData.major],
              dbMinorCategoryData.name),
          name: dbCategoryData.name);
    }).toList();
  }
}
