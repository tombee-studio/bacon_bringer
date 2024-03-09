import 'package:bacon_bringer/bases/notifier.dart';
import 'package:bacon_bringer/bases/repository_provider.dart';
import 'package:bacon_bringer/bases/view_model.dart';
import 'package:bacon_bringer/enum/home_page_state.dart';
import 'package:bacon_bringer/model/home/home_screen_model.dart';
import 'package:bacon_bringer/model/home/repository/home_page_app_repository.dart';
import 'package:bacon_bringer/repository/home_page_repository.dart';
import 'package:bacon_bringer/ui/common/loading_component.dart';
import 'package:bacon_bringer/ui/home/view/components/account_list_drawer.dart';
import 'package:bacon_bringer/ui/home/view/page/monthly_budget_balance_list_page.dart';
import 'package:bacon_bringer/ui/home/view/page/overview_page.dart';
import 'package:bacon_bringer/ui/home/view/page/settings_page.dart';
import 'package:flutter/material.dart';

final homePageRepositoryProvider =
    RepositoryProvider<HomePageRepository>(HomePageAppRepository());

class HomeScreenViewModel extends ViewModel<HomeScreenModel> {
  final String _title;

  HomeScreenViewModel(super.notifier, this._title);

  @override
  HomeScreenModel createModel(Notifier notifier) =>
      HomeScreenModel(notifier, homePageRepositoryProvider, _title);

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
        changeAccountCallback: (index) {
          model.currentAccountIndex = index;
          Navigator.of(context).pop();
        });
  }

  Widget content() {
    switch (model.currentState) {
      case HomePageState.overview:
        return OverviewPage(
            overviewData: model.overviewData,
            categoryBudgetList: model.categoryBudgetList);
      case HomePageState.list:
        return const MonthlyBudgetBalanceListPage();
      case HomePageState.settings:
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

  HomePageState get currentState => model.currentState;
  set currentState(HomePageState value) => model.currentState = value;
}
