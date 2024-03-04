import 'package:bacon_bringer/data/overview_data.dart';
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
}
