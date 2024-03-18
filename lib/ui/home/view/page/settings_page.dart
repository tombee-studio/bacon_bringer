import 'package:bacon_bringer/bases/view_model_widget.dart';
import 'package:bacon_bringer/ui/home/view/components/category_list_component.dart';
import 'package:bacon_bringer/ui/home/view/components/minor_category_list_component.dart';
import 'package:bacon_bringer/ui/home/view_model/home_screen_view_model.dart';
import 'package:flutter/material.dart';

class SettingsPage extends ViewModelWidget<HomeScreenViewModel> {
  const SettingsPage({super.key, required super.parentViewModel});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      MinorCategoryListComponent(
          minorCategories: parentViewModel.minorCategories,
          account: parentViewModel.currentAccount,
          callback: () => parentViewModel.launch()),
      CategoryListComponent(
          categories: parentViewModel.categories,
          account: parentViewModel.currentAccount,
          callback: () => parentViewModel.launch())
    ]);
  }
}
