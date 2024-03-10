import 'package:bacon_bringer/bases/notifier.dart';
import 'package:bacon_bringer/bases/repository_provider.dart';
import 'package:bacon_bringer/bases/view_model.dart';
import 'package:bacon_bringer/enum/home_screen_state.dart';
import 'package:bacon_bringer/model/home/home_screen_model.dart';
import 'package:bacon_bringer/ui/account/view/screen/account_screen.dart';
import 'package:bacon_bringer/ui/home/view_model/repository/home_page_app_repository.dart';
import 'package:bacon_bringer/repository/home_screen_repository.dart';
import 'package:bacon_bringer/ui/common/loading_component.dart';
import 'package:bacon_bringer/ui/home/view/components/account_list_drawer.dart';
import 'package:bacon_bringer/ui/home/view/page/monthly_budget_balance_list_page.dart';
import 'package:bacon_bringer/ui/home/view/page/overview_page.dart';
import 'package:bacon_bringer/ui/home/view/page/settings_page.dart';
import 'package:flutter/material.dart';

final homeScreenRepositoryProvider =
    RepositoryProvider<HomeScreenRepository>(HomeScreenAppRepository());

class HomeScreenViewModel extends ViewModel<HomeScreenModel> {
  final String _title;

  HomeScreenViewModel(super.notifier, this._title);

  @override
  HomeScreenModel createModel(Notifier notifier) =>
      HomeScreenModel(notifier, homeScreenRepositoryProvider, _title);

  Future launch() async {
    await model.launch();
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
        return const SettingsPage();
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
}
