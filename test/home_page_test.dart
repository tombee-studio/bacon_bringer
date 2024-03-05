// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bacon_bringer/data/overview_data.dart';
import 'package:bacon_bringer/model/home/home_page_model.dart';
import 'package:bacon_bringer/repository/home_page_repository.dart';
import 'package:bacon_bringer/ui/home/view_model/home_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bacon_bringer/main.dart';

import 'util.dart';

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
        balanceAgainstBudget: 20000,
        budget: 30000,
        totalExpencesOnMonth: 40000,
        totalIncomesOnMonth: 50000);
  }
}

class TestSkeletonWidget extends StatelessWidget {
  final Function builder;
  const TestSkeletonWidget({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return builder(context);
  }
}

void main() {
  test("収支概要が初期化されていること", () async {
    const title = "TestTitle";
    homePageRepositoryProvider.overrideRepository(HomePageTestRepository());

    final model =
        HomePageModel(TestNotifier(), homePageRepositoryProvider, title);
    await model.launch();
    expect(model.overviewData.sumOfMoney, 10000);
    expect(model.overviewData.balanceAgainstBudget, 20000);
    expect(model.overviewData.budget, 30000);
    expect(model.overviewData.totalExpencesOnMonth, 40000);
    expect(model.overviewData.totalIncomesOnMonth, 50000);
  });

  testWidgets("HomePageViewModelがタイトルを返していること", (tester) async {
    const testTitle = "TestTitle";
    homePageRepositoryProvider.overrideRepository(HomePageTestRepository());

    final viewModel = HomePageViewModel(TestNotifier(), testTitle);
    await tester.pumpWidget(MaterialApp(home: viewModel.title));
    expect(0, viewModel.currentIndex);
    expect(find.text(testTitle), findsOneWidget);
  });

  test("HomePageViewModelのタブが反映されること", () {
    const testTitle = "TestTitle";
    homePageRepositoryProvider.overrideRepository(HomePageTestRepository());

    final viewModel = HomePageViewModel(TestNotifier(), testTitle);
    expect(0, viewModel.currentIndex);
    viewModel.currentIndex = 1;
    expect(1, viewModel.currentIndex);
    viewModel.currentIndex = 2;
    expect(2, viewModel.currentIndex);
  });

  testWidgets("HomePageViewModelが収支概要情報をWidgetで返却すること", (tester) async {
    const testTitle = "TestTitle";
    homePageRepositoryProvider.overrideRepository(HomePageTestRepository());

    final viewModel = HomePageViewModel(TestNotifier(), testTitle);
    await viewModel.launch();
    await tester.pumpWidget(
        MaterialApp(home: TestSkeletonWidget(builder: viewModel.body)));
    expect(find.text("¥10000"), findsOneWidget);
    expect(find.text("¥20000"), findsOneWidget);
    expect(find.text("¥30000"), findsOneWidget);
    expect(find.text("¥40000"), findsOneWidget);
    expect(find.text("¥50000"), findsOneWidget);
  });

  testWidgets('ホーム画面でタイトルが表示されていること', (WidgetTester tester) async {
    const testTitle = "Bacon Bringer";
    homePageRepositoryProvider.overrideRepository(HomePageTestRepository());

    await tester.runAsync(() async {
      await tester.pumpWidget(const BaconBringerApp());
      expect(find.text(testTitle), findsOneWidget);
    });
  });

  testWidgets('ホーム画面でローディングアニメーションが表示されていること', (WidgetTester tester) async {
    homePageRepositoryProvider.overrideRepository(HomePageTestRepository());

    await tester.pumpWidget(const BaconBringerApp());
    expect(
        find.byWidgetPredicate(
            (Widget widget) => widget is CircularProgressIndicator),
        findsOneWidget);
  });
}
