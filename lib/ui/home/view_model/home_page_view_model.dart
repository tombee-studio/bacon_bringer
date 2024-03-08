import 'package:bacon_bringer/bases/notifier.dart';
import 'package:bacon_bringer/bases/repository_provider.dart';
import 'package:bacon_bringer/bases/view_model.dart';
import 'package:bacon_bringer/model/home/home_page_model.dart';
import 'package:bacon_bringer/model/home/repository/home_page_app_repository.dart';
import 'package:bacon_bringer/repository/home_page_repository.dart';
import 'package:bacon_bringer/ui/common/loading_component.dart';
import 'package:bacon_bringer/ui/home/view/account_list_drawer.dart';
import 'package:bacon_bringer/ui/home/view/category_budget_list_component.dart';
import 'package:bacon_bringer/ui/home/view/overview_component.dart';
import 'package:flutter/material.dart';

final homePageRepositoryProvider =
    RepositoryProvider<HomePageRepository>(HomePageAppRepository());

class HomePageViewModel extends ViewModel<HomePageModel> {
  final String _title;

  HomePageViewModel(super.notifier, this._title);

  @override
  HomePageModel createModel(Notifier notifier) =>
      HomePageModel(notifier, homePageRepositoryProvider, _title);

  Future launch() async {
    await model.launch();
  }

  Widget get title => Text(model.title);
  Widget get overview {
    final overviewData = model.overviewData;
    return OverviewComponent(overviewData: overviewData);
  }

  Widget get categoryBudgetList {
    final data = model.categoryBudgetList;
    return CategoryBudgetListComponent(data: data);
  }

  Widget? drawer(BuildContext context) {
    final accounts = model.accounts;
    if (accounts.isEmpty) {
      return null;
    }
    return AccountListDrawer(accounts: accounts);
  }

  Widget body(BuildContext context) {
    final loadingData = model.isLoading;
    if (loadingData.isLoading) {
      return LoadingComponent(loadingData: loadingData);
    } else {
      final size = MediaQuery.of(context).size;
      if (size.width > 600) {
        return SizedBox(
            width: 600,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [overview, categoryBudgetList])));
      } else {
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [overview, categoryBudgetList])));
      }
    }
  }

  int get currentIndex => model.currentIndex;
  set currentIndex(int value) => model.currentIndex = value;
}
