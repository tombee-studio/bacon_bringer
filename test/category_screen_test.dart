import 'package:bacon_bringer/common/providers.dart';
import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/category_data.dart';
import 'package:bacon_bringer/data/user_data.dart';
import 'package:bacon_bringer/enum/major_state.dart';
import 'package:bacon_bringer/enum/minor_state.dart';
import 'package:bacon_bringer/model/category/category_screen_model.dart';
import 'package:bacon_bringer/repository/category_screen_repository.dart';
import 'package:bacon_bringer/ui/category/view/screen/category_screen.dart';
import 'package:bacon_bringer/ui/category/view_model/category_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'util.dart';

class CategorySreenTestRepository extends CategoryScreenRepository {
  @override
  Future<CategoryData> create(AccountData account, String name,
      MajorState major, MinorState minor) async {
    return CategoryData(
        account: account, major: major, minor: minor, name: name);
  }
}

main() {
  group("CategoryScreenModel", () {
    test("CategoryScreenModelが正しく初期化されていること", () async {
      final user =
          UserData(id: 0, userName: "test_user", password: "test_password");
      final account = AccountData(
          id: 0, user: user, name: "test_account", purpose: "test_purpose");
      categoryScreenRepositoryProvider
          .overrideRepository(() => CategorySreenTestRepository());

      final model = CategoryScreenModel(
          TestNotifier(), categoryScreenRepositoryProvider, account);
      expect(model.name, "");
      expect(model.major, MajorState.expense);
      expect(model.minor, MinorState.fixedCosts);
    });

    test("CategoryScreenModelのプロパティを更新できていること", () async {
      const String testCategoryName = "test_category_name_after";
      const MajorState testMajorState = MajorState.income;
      const MinorState testMinorState = MinorState.extraIncome;
      final user =
          UserData(id: 0, userName: "test_user", password: "test_password");
      final account = AccountData(
          id: 0, user: user, name: "test_account", purpose: "test_purpose");
      categoryScreenRepositoryProvider
          .overrideRepository(() => CategorySreenTestRepository());

      final model = CategoryScreenModel(
          TestNotifier(), categoryScreenRepositoryProvider, account);
      model.name = testCategoryName;
      model.major = testMajorState;
      model.minor = testMinorState;

      expect(model.name, testCategoryName);
      expect(model.major, testMajorState);
      expect(model.minor, testMinorState);
    });

    test("CategoryScreenModelからCategoryDataを作成できていること", () async {
      const String testCategoryName = "test_category_name_after";
      const MajorState testMajorState = MajorState.income;
      const MinorState testMinorState = MinorState.extraIncome;
      final user =
          UserData(id: 0, userName: "test_user", password: "test_password");
      final account = AccountData(
          id: 0, user: user, name: "test_account", purpose: "test_purpose");
      categoryScreenRepositoryProvider
          .overrideRepository(() => CategorySreenTestRepository());

      final model = CategoryScreenModel(
          TestNotifier(), categoryScreenRepositoryProvider, account);
      model.name = testCategoryName;
      model.major = testMajorState;
      model.minor = testMinorState;

      final categoryData = await model.create();
      expect(categoryData.name, testCategoryName);
      expect(categoryData.major, testMajorState);
      expect(categoryData.minor, testMinorState);
    });
  });

  group("CategoryScreenViewModel", () {
    test("CategoryScreenViewModelが正しく初期化されていること", () {
      final user =
          UserData(id: 0, userName: "test_user", password: "test_password");
      final account = AccountData(
          id: 0, user: user, name: "test_account", purpose: "test_purpose");
      categoryScreenRepositoryProvider
          .overrideRepository(() => CategorySreenTestRepository());

      final viewModel = CategoryScreenViewModel(TestNotifier(), account);
      expect(viewModel.account.name, "test_account");
      expect(viewModel.account.purpose, "test_purpose");
    });

    testWidgets("AccountScreenViewModelのnameが初期化されていること", (tester) async {
      final user =
          UserData(id: 0, userName: "test_user", password: "test_password");
      final account = AccountData(
          id: 0, user: user, name: "test_account", purpose: "test_purpose");
      categoryScreenRepositoryProvider
          .overrideRepository(() => CategorySreenTestRepository());

      final viewModel = CategoryScreenViewModel(TestNotifier(), account);
      final widget =
          TestSkeletonWidget(builder: (context) => viewModel.name(context));
      await tester.pumpWidget(widget);
      expect(find.text(""), findsOneWidget);
    });

    testWidgets("AccountScreenViewModelのbodyが初期化されていること（タブレット）",
        (tester) async {
      tester.view.physicalSize = const Size(641, 480);
      tester.view.devicePixelRatio = 1.0;
      final user =
          UserData(id: 0, userName: "test_user", password: "test_password");
      final account = AccountData(
          id: 0, user: user, name: "test_account", purpose: "test_purpose");
      categoryScreenRepositoryProvider
          .overrideRepository(() => CategorySreenTestRepository());
      final viewModel = CategoryScreenViewModel(TestNotifier(), account);
      final widget =
          TestSkeletonWidget(builder: (context) => viewModel.body(context));
      await tester.pumpWidget(widget);
      expect(find.text(""), findsNWidgets(1));
    });

    testWidgets("AccountScreenViewModelのbodyが初期化されていること（スマホ）", (tester) async {
      tester.view.physicalSize = const Size(640, 480);
      tester.view.devicePixelRatio = 1.0;
      final user =
          UserData(id: 0, userName: "test_user", password: "test_password");
      final account = AccountData(
          id: 0, user: user, name: "test_account", purpose: "test_purpose");
      categoryScreenRepositoryProvider
          .overrideRepository(() => CategorySreenTestRepository());
      final viewModel = CategoryScreenViewModel(TestNotifier(), account);
      final widget =
          TestSkeletonWidget(builder: (context) => viewModel.body(context));
      await tester.pumpWidget(widget);
      expect(find.text(""), findsNWidgets(1));
    });
  });

  group("CategoryScreen", () {
    testWidgets("CategoryScreenが初期化できること", (tester) async {
      const testCategoryName = "test_category_name";
      final user =
          UserData(id: 0, userName: "test_user", password: "test_password");
      final account = AccountData(
          id: 0, user: user, name: "test_account", purpose: "test_purpose");
      categoryScreenRepositoryProvider
          .overrideRepository(() => CategorySreenTestRepository());

      await tester
          .pumpWidget(MaterialApp(home: CategoryScreen(account: account)));
      await tester.enterText(find.byType(TextField).at(0), testCategoryName);
    });
  });
}
