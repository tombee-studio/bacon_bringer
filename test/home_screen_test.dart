// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/category_budget.dart';
import 'package:bacon_bringer/data/category_data.dart';
import 'package:bacon_bringer/data/overview_data.dart';
import 'package:bacon_bringer/data/transaction_data.dart';
import 'package:bacon_bringer/data/user_data.dart';
import 'package:bacon_bringer/enum/home_page_state.dart';
import 'package:bacon_bringer/enum/major_state.dart';
import 'package:bacon_bringer/enum/minor_state.dart';
import 'package:bacon_bringer/model/home/home_screen_model.dart';
import 'package:bacon_bringer/repository/home_page_repository.dart';
import 'package:bacon_bringer/ui/home/view/page/monthly_budget_balance_list_page.dart';
import 'package:bacon_bringer/ui/home/view_model/home_page_view_model.dart';
import 'package:bacon_bringer/ui/home/view_model/repository/home_page_app_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bacon_bringer/main.dart';

import 'util.dart';

class HomePageTestRepository extends HomePageRepository {
  @override
  Future<UserData> authenticate() async {
    return UserData(
        id: "testuser", userName: "testname", password: "testpassword");
  }

  @override
  Future connectDatabase() async {}

  @override
  Future loadLocalData() async {}

  @override
  Future<OverviewData> fetchMonthlyOverview(AccountData account) async {
    return OverviewData(
        sumOfMoney: 100000,
        balanceAgainstBudget: 200000,
        budget: 300000,
        totalExpencesOnMonth: 400000,
        totalIncomesOnMonth: 500000);
  }

  @override
  Future<List<CategoryBudget>> fetchCategoryBudgetList(
      AccountData account) async {
    if (account.name == "account1") {
      final categoryBudgets = <CategoryBudget>[];
      categoryBudgets.add(CategoryBudget(
          account: account,
          category: CategoryData(
              account: account,
              major: MajorState.expense,
              minor: MinorState.fixedCosts,
              name: "account1_cost1"),
          leftBudgetPerMonth: 10000,
          budgetPerDay: 11000));
      categoryBudgets.add(CategoryBudget(
          account: account,
          category: CategoryData(
              account: account,
              major: MajorState.expense,
              minor: MinorState.variableCosts,
              name: "account1_cost2"),
          leftBudgetPerMonth: 20000,
          budgetPerDay: 21000));
      categoryBudgets.add(CategoryBudget(
          account: account,
          category: CategoryData(
              account: account,
              major: MajorState.income,
              minor: MinorState.fixedIncome,
              name: "account1_income1"),
          leftBudgetPerMonth: 30000,
          budgetPerDay: 31000));
      categoryBudgets.add(CategoryBudget(
          account: account,
          category: CategoryData(
              account: account,
              major: MajorState.income,
              minor: MinorState.variableIncome,
              name: "account1_income2"),
          leftBudgetPerMonth: 40000,
          budgetPerDay: 41000));
      categoryBudgets.add(CategoryBudget(
          account: account,
          category: CategoryData(
              account: account,
              major: MajorState.income,
              minor: MinorState.extraIncome,
              name: "account1_income3"),
          leftBudgetPerMonth: 50000,
          budgetPerDay: 51000));
      return categoryBudgets;
    } else {
      final categoryBudgets = <CategoryBudget>[];
      categoryBudgets.add(CategoryBudget(
          account: account,
          category: CategoryData(
              account: account,
              major: MajorState.expense,
              minor: MinorState.fixedCosts,
              name: "account2_cost1"),
          leftBudgetPerMonth: 10000,
          budgetPerDay: 11000));
      categoryBudgets.add(CategoryBudget(
          account: account,
          category: CategoryData(
              account: account,
              major: MajorState.expense,
              minor: MinorState.variableCosts,
              name: "account2_cost2"),
          leftBudgetPerMonth: 20000,
          budgetPerDay: 21000));
      categoryBudgets.add(CategoryBudget(
          account: account,
          category: CategoryData(
              account: account,
              major: MajorState.income,
              minor: MinorState.fixedIncome,
              name: "account2_income1"),
          leftBudgetPerMonth: 30000,
          budgetPerDay: 31000));
      categoryBudgets.add(CategoryBudget(
          account: account,
          category: CategoryData(
              account: account,
              major: MajorState.income,
              minor: MinorState.variableIncome,
              name: "account2_income2"),
          leftBudgetPerMonth: 40000,
          budgetPerDay: 41000));
      categoryBudgets.add(CategoryBudget(
          account: account,
          category: CategoryData(
              account: account,
              major: MajorState.income,
              minor: MinorState.extraIncome,
              name: "account2_income3"),
          leftBudgetPerMonth: 50000,
          budgetPerDay: 51000));
      return categoryBudgets;
    }
  }

  @override
  Future<List<AccountData>> fetchAccounts(UserData user) async {
    final accounts = <AccountData>[];
    accounts
        .add(AccountData(user: user, name: "account1", purpose: "purpose1"));
    accounts
        .add(AccountData(user: user, name: "account2", purpose: "purpose2"));
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
        money: 3000.0,
        category: CategoryData(
            account: account,
            major: MajorState.income,
            minor: MinorState.fixedIncome,
            name: "test name 3"),
        createdAt: DateTime(3200)));
    transactions.add(TransactionData(
        purpose: "test purpose 4",
        money: 4000.0,
        category: CategoryData(
            account: account,
            major: MajorState.income,
            minor: MinorState.variableIncome,
            name: "test name 4"),
        createdAt: DateTime(3200)));
    transactions.add(TransactionData(
        purpose: "test purpose 5",
        money: 5000.0,
        category: CategoryData(
            account: account,
            major: MajorState.others,
            minor: MinorState.variableCosts,
            name: "test name 5"),
        createdAt: DateTime(3200)));
    return transactions;
  }
}

void main() {
  group("HomeScreenAppRepository", () {
    test("connectDatabaseが正しく動作すること", () async {
      final repository = HomePageAppRepository();
      await repository.connectDatabase();
    });

    test("loadLocalDataが正しく動作すること", () async {
      final repository = HomePageAppRepository();
      await repository.loadLocalData();
    });

    test("authenticateが正しく動作すること", () async {
      final repository = HomePageAppRepository();
      final user = await repository.authenticate();
      expect(user.id, "01HR7FA4EXR3S8YCJ53A1FXTEF");
      expect(user.userName, "testuser");
      expect(user.password, "01HR7FA4EXR3S8YCJ53A1FXTEF");
    });

    test("fetchMonthlyOverviewが正しく動作すること", () async {
      final repository = HomePageAppRepository();
      final user = UserData(
          id: "test", userName: "testUserName", password: "testPassword");
      const testAccountName = "test_account_name_created";
      const testAccountPurpose = "test_account_purpose_created";
      final data = await repository.fetchMonthlyOverview(AccountData(
          user: user, name: testAccountName, purpose: testAccountPurpose));
      expect(data.sumOfMoney, 10000);
      expect(data.balanceAgainstBudget, 2000);
      expect(data.totalExpencesOnMonth, 2000);
      expect(data.totalIncomesOnMonth, 10000);
    });

    test("fetchCategoryBudgetListが正しく動作すること", () async {
      final repository = HomePageAppRepository();
      final user = UserData(
          id: "test", userName: "testUserName", password: "testPassword");
      const testAccountName = "test_account_name_created";
      const testAccountPurpose = "test_account_purpose_created";
      final items = await repository.fetchCategoryBudgetList(AccountData(
          user: user, name: testAccountName, purpose: testAccountPurpose));
      expect(items.length, 5);
    });

    test("fetchAccountsが正しく動作すること", () async {
      final repository = HomePageAppRepository();
      final user = UserData(
          id: "test", userName: "testUserName", password: "testPassword");
      final items = await repository.fetchAccounts(user);
      expect(items.length, 2);
    });

    test("fetchTransactionsが正しく動作すること", () async {
      final repository = HomePageAppRepository();
      final user = UserData(
          id: "test", userName: "testUserName", password: "testPassword");
      const testAccountName = "test_account_name_created";
      const testAccountPurpose = "test_account_purpose_created";
      final items = await repository.fetchTransactions(
          AccountData(
              user: user, name: testAccountName, purpose: testAccountPurpose),
          from: DateTime(2024, 3, 1),
          to: DateTime(2024, 4, 1));
      expect(items.length, 4);
    });
  });
  group("HomeScreenModel", () {
    test("HomeScreenModelが初期化されていること", () async {
      const title = "TestTitle";
      homePageRepositoryProvider.overrideRepository(HomePageTestRepository());

      final model =
          HomeScreenModel(TestNotifier(), homePageRepositoryProvider, title);
      expect(model.isLoading.isLoading, true);
      expect(model.currentAccountIndex, 0);
      expect(model.transactions.length, 0);

      await model.launch();

      expect(model.isLoading.isLoading, false);

      expect(model.currentAccountIndex, 0);
      expect(model.currentAccount.name, "account1");
      expect(model.currentAccount.purpose, "purpose1");

      expect(model.title, title);

      expect(model.user.id, "testuser");
      expect(model.user.userName, "testname");
      expect(model.user.password, "testpassword");

      expect(model.overviewData.sumOfMoney, 100000);
      expect(model.overviewData.balanceAgainstBudget, 200000);
      expect(model.overviewData.budget, 300000);
      expect(model.overviewData.totalExpencesOnMonth, 400000);
      expect(model.overviewData.totalIncomesOnMonth, 500000);

      expect(model.accounts[0].name, "account1");
      expect(model.accounts[0].purpose, "purpose1");
      expect(model.accounts[1].name, "account2");
      expect(model.accounts[1].purpose, "purpose2");

      expect(model.categoryBudgetList[0].category.name, "account1_cost1");
      expect(model.categoryBudgetList[0].category.major, MajorState.expense);
      expect(model.categoryBudgetList[0].category.minor, MinorState.fixedCosts);
      expect(model.categoryBudgetList[0].leftBudgetPerMonth, 10000);
      expect(model.categoryBudgetList[0].budgetPerDay, 11000);

      expect(model.categoryBudgetList[1].category.name, "account1_cost2");
      expect(model.categoryBudgetList[1].category.major, MajorState.expense);
      expect(
          model.categoryBudgetList[1].category.minor, MinorState.variableCosts);
      expect(model.categoryBudgetList[1].leftBudgetPerMonth, 20000);
      expect(model.categoryBudgetList[1].budgetPerDay, 21000);

      expect(model.categoryBudgetList[2].category.name, "account1_income1");
      expect(model.categoryBudgetList[2].category.major, MajorState.income);
      expect(
          model.categoryBudgetList[2].category.minor, MinorState.fixedIncome);
      expect(model.categoryBudgetList[2].leftBudgetPerMonth, 30000);
      expect(model.categoryBudgetList[2].budgetPerDay, 31000);

      expect(model.categoryBudgetList[3].category.name, "account1_income2");
      expect(model.categoryBudgetList[3].category.major, MajorState.income);
      expect(model.categoryBudgetList[3].category.minor,
          MinorState.variableIncome);
      expect(model.categoryBudgetList[3].leftBudgetPerMonth, 40000);
      expect(model.categoryBudgetList[3].budgetPerDay, 41000);

      expect(model.categoryBudgetList[4].category.name, "account1_income3");
      expect(model.categoryBudgetList[4].category.major, MajorState.income);
      expect(
          model.categoryBudgetList[4].category.minor, MinorState.extraIncome);
      expect(model.categoryBudgetList[4].leftBudgetPerMonth, 50000);
      expect(model.categoryBudgetList[4].budgetPerDay, 51000);

      model.currentAccountIndex = 1;
      expect(model.currentAccountIndex, 1);
    });
  });

  group("HomeScreenViewModel", () {
    testWidgets("HomePageViewModelがタイトルを返していること", (tester) async {
      const testTitle = "TestTitle";
      homePageRepositoryProvider.overrideRepository(HomePageTestRepository());

      final viewModel = HomeScreenViewModel(TestNotifier(), testTitle);
      await tester.pumpWidget(MaterialApp(home: viewModel.title));
      expect(HomePageState.overview, viewModel.currentState);
      expect(find.text(testTitle), findsOneWidget);
    });

    test("HomePageViewModelのタブが反映されること", () {
      const testTitle = "TestTitle";
      homePageRepositoryProvider.overrideRepository(HomePageTestRepository());

      final viewModel = HomeScreenViewModel(TestNotifier(), testTitle);
      expect(HomePageState.overview, viewModel.currentState);
      viewModel.currentState = HomePageState.list;
      expect(HomePageState.list, viewModel.currentState);
      viewModel.currentState = HomePageState.settings;
      expect(HomePageState.settings, viewModel.currentState);
    });

    testWidgets("HomePageViewModelが収支概要情報をWidgetで返却すること", (tester) async {
      const testTitle = "TestTitle";
      homePageRepositoryProvider.overrideRepository(HomePageTestRepository());

      final viewModel = HomeScreenViewModel(TestNotifier(), testTitle);
      await viewModel.launch();
      await tester.pumpWidget(
          MaterialApp(home: TestSkeletonWidget(builder: viewModel.body)));
      expect(find.text("¥100000"), findsOneWidget);
      expect(find.text("¥200000"), findsOneWidget);
      expect(find.text("¥300000"), findsOneWidget);
      expect(find.text("¥400000"), findsOneWidget);
      expect(find.text("¥500000"), findsOneWidget);
    });
  });

  group("HomeScreen", () {
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

    testWidgets('ホーム画面でローディング後にページが表示されていること', (WidgetTester tester) async {
      homePageRepositoryProvider.overrideRepository(HomePageTestRepository());

      await tester.pumpWidget(const BaconBringerApp());
      await tester.pumpAndSettle();
      expect(find.text("¥100000"), findsOneWidget);
    });

    testWidgets('ホーム画面で収支管理ボタンタップ後、収支管理ページが表示されていること',
        (WidgetTester tester) async {
      homePageRepositoryProvider.overrideRepository(HomePageTestRepository());

      await tester.pumpWidget(const BaconBringerApp());
      await tester.tap(find.byIcon(Icons.list));
      await tester.pump();
      expect(
          find.byWidgetPredicate(
              (Widget widget) => widget is MonthlyBudgetBalanceListPage),
          findsOneWidget);

      expect(find.text("test purpose 1"), findsOneWidget);
      expect(find.text("¥1000"), findsOneWidget);

      expect(find.text("test purpose 2"), findsOneWidget);
      expect(find.text("¥2000"), findsOneWidget);

      expect(find.byIcon(Icons.payment), findsNWidgets(2));

      expect(find.text("test purpose 3"), findsOneWidget);
      expect(find.text("¥3000"), findsOneWidget);

      expect(find.text("test purpose 4"), findsOneWidget);
      expect(find.text("¥4000"), findsOneWidget);

      expect(find.byIcon(Icons.money), findsNWidgets(2));

      expect(find.text("test purpose 5"), findsOneWidget);
      expect(find.text("¥5000"), findsOneWidget);
      expect(find.byIcon(Icons.question_mark), findsOneWidget);
    });
  });
}
