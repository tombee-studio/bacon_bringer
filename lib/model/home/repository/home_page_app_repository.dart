import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/category_budget.dart';
import 'package:bacon_bringer/data/category_data.dart';
import 'package:bacon_bringer/data/overview_data.dart';
import 'package:bacon_bringer/data/user_data.dart';
import 'package:bacon_bringer/enum/major_state.dart';
import 'package:bacon_bringer/enum/minor_state.dart';
import 'package:bacon_bringer/repository/home_page_repository.dart';

class HomePageAppRepository extends HomePageRepository {
  @override
  Future loadLocalData() async {
    await Future.delayed(const Duration(milliseconds: 1000));
  }

  @override
  Future<UserData> authenticate() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return UserData(
        id: '01HR7FA4EXR3S8YCJ53A1FXTEF',
        userName: 'testuser',
        password: '01HR7FA4EXR3S8YCJ53A1FXTEF');
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
}
