// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bacon_bringer/data/overview_data.dart';
import 'package:bacon_bringer/repository/home_page_repository.dart';
import 'package:bacon_bringer/ui/home/view_model/home_page_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bacon_bringer/main.dart';

class HomePageTestRepository extends HomePageRepository {
  @override
  Future authenticate() async {}

  @override
  Future connectDatabase() async {}

  @override
  Future loadLocalData() async {}

  @override
  Future<OverviewData> fetchMonthlyOverview() async {
    return OverviewData(
        sumOfMoney: 10000,
        balanceAgainstBudget: 2000,
        budget: 18000,
        totalExpencesOnMonth: 2000,
        totalIncomesOnMonth: 10000);
  }
}

void main() {
  testWidgets('ホーム画面でタイトルが表示されていること', (WidgetTester tester) async {
    const testTitle = "Bacon Bringer";
    await tester.pumpWidget(const BaconBringerApp());
    expect(find.text(testTitle), findsOneWidget);
  });

  testWidgets('ホーム画面で月間収支概要が表示されていること', (WidgetTester tester) async {
    homePageRepositoryProvider.overrideRepository(HomePageTestRepository());
    await tester.pumpWidget(const BaconBringerApp());
    expect(find.text("合計"), findsOneWidget);
    expect(find.text("0"), findsOneWidget);
  });
}
