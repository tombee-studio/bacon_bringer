import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/user_data.dart';
import 'package:bacon_bringer/model/account/account_screen_model.dart';
import 'package:bacon_bringer/repository/account_screen_repository.dart';
import 'package:bacon_bringer/ui/account/view/screen/account_screen.dart';
import 'package:bacon_bringer/ui/account/view_model/account_screen_view_model.dart';
import 'package:bacon_bringer/ui/account/view_model/repository/account_screen_app_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'util.dart';

class AccountScreenTestRepository extends AccountScreenRepository {
  @override
  Future<AccountData> addAccount(
      UserData user, String name, String purpose) async {
    return AccountData(user: user, name: name, purpose: purpose);
  }
}

void main() {
  group("AccountScreenAppRepository", () {
    test("AccountScreenAppRepositoryのaddAccountがAccountDataを作成すること", () async {
      final user = UserData(
          id: "test", userName: "testUserName", password: "testPassword");
      const testAccountName = "test_account_name_created";
      const testAccountPurpose = "test_account_purpose_created";
      final repository = AccountScreenAppRepository();
      final account = await repository.addAccount(
          user, testAccountName, testAccountPurpose);
      expect(account.user.id, user.id);
      expect(account.user.userName, user.userName);
      expect(account.user.password, user.password);
      expect(account.name, testAccountName);
      expect(account.purpose, testAccountPurpose);
    });
  });

  group("AccountScreenModel", () {
    test("AccountScreenModelが正しく初期化されていること", () async {
      final user = UserData(
          id: "test", userName: "testUserName", password: "testPassword");
      accountScreenRepositoryProvider
          .overrideRepository(AccountScreenTestRepository());

      final model = AccountScreenModel(
          TestNotifier(), user, accountScreenRepositoryProvider);
      expect(model.user.id, user.id);
      expect(model.user.userName, user.userName);
      expect(model.user.password, user.password);
      expect(model.name, "");
      expect(model.purpose, "");
    });

    test("AccountScreenModelのプロパティを更新できていること", () async {
      final user = UserData(
          id: "test", userName: "testUserName", password: "testPassword");
      const testAccountName = "test_account_name_created";
      const testAccountPurpose = "test_account_purpose_created";
      accountScreenRepositoryProvider
          .overrideRepository(AccountScreenTestRepository());

      final model = AccountScreenModel(
          TestNotifier(), user, accountScreenRepositoryProvider);
      model.name = testAccountName;
      model.purpose = testAccountPurpose;

      expect(model.name, testAccountName);
      expect(model.purpose, testAccountPurpose);
    });

    test("AccountScreenModelからAccountDataを作成できていること", () async {
      final user = UserData(
          id: "test", userName: "testUserName", password: "testPassword");
      const testAccountName = "test_account_name_created";
      const testAccountPurpose = "test_account_purpose_created";
      accountScreenRepositoryProvider
          .overrideRepository(AccountScreenTestRepository());

      final model = AccountScreenModel(
          TestNotifier(), user, accountScreenRepositoryProvider);
      model.name = testAccountName;
      model.purpose = testAccountPurpose;

      final account = await model.addAccount();
      expect(account.name, testAccountName);
      expect(account.purpose, testAccountPurpose);
    });
  });

  group("AccountScreenViewModel", () {
    test("AccountScreenViewModelが正しく初期化されていること", () {
      final user = UserData(
          id: "test", userName: "testUserName", password: "testPassword");
      accountScreenRepositoryProvider
          .overrideRepository(AccountScreenTestRepository());
      final viewModel = AccountScreenViewModel(TestNotifier(), user);
      expect(viewModel.user.id, user.id);
      expect(viewModel.user.userName, user.userName);
      expect(viewModel.user.password, user.password);
    });

    testWidgets("AccountScreenViewModelのnameが初期化されていること", (tester) async {
      final user = UserData(
          id: "test", userName: "testUserName", password: "testPassword");
      accountScreenRepositoryProvider
          .overrideRepository(AccountScreenTestRepository());
      final viewModel = AccountScreenViewModel(TestNotifier(), user);
      final widget =
          TestSkeletonWidget(builder: (context) => viewModel.name(context));
      await tester.pumpWidget(widget);
      expect(find.text(""), findsOneWidget);
    });

    testWidgets("AccountScreenViewModelのpurposeが初期化されていること", (tester) async {
      final user = UserData(
          id: "test", userName: "testUserName", password: "testPassword");
      accountScreenRepositoryProvider
          .overrideRepository(AccountScreenTestRepository());
      final viewModel = AccountScreenViewModel(TestNotifier(), user);
      final widget =
          TestSkeletonWidget(builder: (context) => viewModel.purpose(context));
      await tester.pumpWidget(widget);
      expect(find.text(""), findsOneWidget);
    });

    testWidgets("AccountScreenViewModelのcontentが初期化されていること", (tester) async {
      final user = UserData(
          id: "test", userName: "testUserName", password: "testPassword");
      accountScreenRepositoryProvider
          .overrideRepository(AccountScreenTestRepository());
      final viewModel = AccountScreenViewModel(TestNotifier(), user);
      final widget =
          TestSkeletonWidget(builder: (context) => viewModel.content(context));
      await tester.pumpWidget(widget);
      expect(find.text(""), findsNWidgets(2));
    });

    testWidgets("AccountScreenViewModelのbodyが初期化されていること（タブレット）",
        (tester) async {
      tester.view.physicalSize = const Size(641, 480);
      tester.view.devicePixelRatio = 1.0;
      final user = UserData(
          id: "test", userName: "testUserName", password: "testPassword");
      accountScreenRepositoryProvider
          .overrideRepository(AccountScreenTestRepository());
      final viewModel = AccountScreenViewModel(TestNotifier(), user);
      final widget =
          TestSkeletonWidget(builder: (context) => viewModel.body(context));
      await tester.pumpWidget(widget);
      expect(find.text(""), findsNWidgets(2));
    });

    testWidgets("AccountScreenViewModelのbodyが初期化されていること（スマホ）", (tester) async {
      tester.view.physicalSize = const Size(640, 480);
      tester.view.devicePixelRatio = 1.0;
      final user = UserData(
          id: "test", userName: "testUserName", password: "testPassword");
      accountScreenRepositoryProvider
          .overrideRepository(AccountScreenTestRepository());
      final viewModel = AccountScreenViewModel(TestNotifier(), user);
      final widget =
          TestSkeletonWidget(builder: (context) => viewModel.body(context));
      await tester.pumpWidget(widget);
      expect(find.text(""), findsNWidgets(2));
    });

    testWidgets("AccountScreenViewModelのnameの文字列を編集できること", (tester) async {
      const testAccountName = "test_account_name_created";
      final user = UserData(
          id: "test", userName: "testUserName", password: "testPassword");
      accountScreenRepositoryProvider
          .overrideRepository(AccountScreenTestRepository());
      final viewModel = AccountScreenViewModel(TestNotifier(), user);
      final widget =
          TestSkeletonWidget(builder: (context) => viewModel.name(context));
      await tester.pumpWidget(widget);
      await tester.enterText(find.byType(TextField), testAccountName);
      expect(find.text(testAccountName), findsOneWidget);
    });

    testWidgets("AccountScreenViewModelのpurposeの文字列を編集できること", (tester) async {
      const testAccountPurpose = "test_account_purpose_created";
      final user = UserData(
          id: "test", userName: "testUserName", password: "testPassword");
      accountScreenRepositoryProvider
          .overrideRepository(AccountScreenTestRepository());
      final viewModel = AccountScreenViewModel(TestNotifier(), user);
      final widget =
          TestSkeletonWidget(builder: (context) => viewModel.purpose(context));
      await tester.pumpWidget(widget);
      await tester.enterText(find.byType(TextField), testAccountPurpose);
      expect(find.text(testAccountPurpose), findsOneWidget);
    });

    testWidgets("AccountScreenViewModelのaddAccountが実行できること", (tester) async {
      const testAccountName = "test_account_name_created";
      const testAccountPurpose = "test_account_purpose_created";
      final user = UserData(
          id: "test", userName: "testUserName", password: "testPassword");
      accountScreenRepositoryProvider
          .overrideRepository(AccountScreenTestRepository());

      final viewModel = AccountScreenViewModel(TestNotifier(), user);
      await tester.pumpWidget(
          TestSkeletonWidget(builder: (context) => viewModel.body(context)));
      await tester.enterText(find.byType(TextField).at(0), testAccountName);
      await tester.enterText(find.byType(TextField).at(1), testAccountPurpose);

      final account = await viewModel.addAccount();
      expect(account.user.id, user.id);
      expect(account.user.userName, user.userName);
      expect(account.user.password, user.password);
      expect(account.name, testAccountName);
      expect(account.purpose, testAccountPurpose);
    });
  });

  group("AccountScreen", () {
    testWidgets("AccountScreen", (tester) async {
      const testAccountName = "test_account_name_created";
      const testAccountPurpose = "test_account_purpose_created";
      final user = UserData(
          id: "test", userName: "testUserName", password: "testPassword");

      await tester.pumpWidget(MaterialApp(home: AccountScreen(user: user)));
      await tester.enterText(find.byType(TextField).at(0), testAccountName);
      await tester.enterText(find.byType(TextField).at(1), testAccountPurpose);
      await tester.tap(find.byType(FloatingActionButton));
    });
  });
}
