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
    await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Future authenticate() async {
    await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Future connectDatabase() async {
    await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Future<OverviewData> fetchMonthlyOverview() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    return OverviewData(
        sumOfMoney: 10000,
        balanceAgainstBudget: 2000,
        budget: 18000,
        totalExpencesOnMonth: 2000,
        totalIncomesOnMonth: 10000);
  }

  @override
  Future<List<CategoryBudget>> fetchCategoryBudgetList() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    final user = UserData(
        id: '01HR7FA4EXR3S8YCJ53A1FXTEF',
        userName: 'testuser',
        password: '01HR7FA4EXR3S8YCJ53A1FXTEF');
    final account =
        AccountData(user: user, name: "テスト用アカウント", purpose: "テスト用に作成しました");
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
}
