import 'package:bacon_bringer/bases/notifier.dart';
import 'package:bacon_bringer/bases/view_model.dart';
import 'package:bacon_bringer/common/providers.dart';
import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/category_data.dart';
import 'package:bacon_bringer/enum/home_screen_state.dart';
import 'package:bacon_bringer/model/home/home_screen_model.dart';
import 'package:bacon_bringer/ui/account/view/screen/account_screen.dart';
import 'package:bacon_bringer/ui/common/loading_component.dart';
import 'package:bacon_bringer/ui/home/view/components/account_list_drawer.dart';
import 'package:bacon_bringer/ui/home/view/page/monthly_budget_balance_list_page.dart';
import 'package:bacon_bringer/ui/home/view/page/overview_page.dart';
import 'package:bacon_bringer/ui/home/view/page/settings_page.dart';
import 'package:flutter/material.dart';

class HomeScreenViewModel extends ViewModel<HomeScreenModel> {
  HomeScreenViewModel(super.notifier);

  @override
  HomeScreenModel createModel(Notifier notifier) =>
      HomeScreenModel(notifier, homeScreenRepositoryProvider, "Bacon Bringer");

  Future launch() async {
    final userId = await model.loadLocalData();
    await model.authenticate(userId);
    await model.loadData();
  }

  Widget get title => Text(model.title);

  Widget? drawer(BuildContext context) {
    final accounts = model.accounts;
    if (accounts.isEmpty) {
      return null;
    }
    return AccountListDrawer(
        accounts: accounts,
        currentAccountIndex: model.currentAccountIndex,
        addAccountCallback: () async {
          Navigator.of(context).pop();
          await Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => AccountScreen(user: model.user)));
          model.loadData().then(
              (_) => Navigator.of(context).popUntil((route) => route.isFirst));
        },
        changeAccountCallback: (index) {
          model.currentAccountIndex = index;
          Navigator.of(context).pop();
        });
  }

  Widget content() {
    switch (model.currentState) {
      case HomeScreenState.overview:
        return OverviewPage(
            parentViewModel: this,
            overviewData: model.overviewData,
            categoryBudgetList: model.categoryBudgetList);
      case HomeScreenState.list:
        return MonthlyBudgetBalanceListPage(
            parentViewModel: this, transactions: model.transactions);
      case HomeScreenState.settings:
        return SettingsPage(parentViewModel: this);
    }
  }

  Widget body(BuildContext context) {
    final loadingData = model.isLoading;
    if (loadingData.isLoading) {
      return LoadingComponent(loadingData: loadingData);
    } else {
      final size = MediaQuery.of(context).size;
      if (size.width > 640) {
        return SizedBox(width: 640, child: content());
      } else {
        return content();
      }
    }
  }

  HomeScreenState get currentState => model.currentState;
  set currentState(HomeScreenState value) => model.currentState = value;

  List<CategoryData> get categories => model.categories;
  AccountData get currentAccount => model.currentAccount;
}
