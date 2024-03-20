import 'package:bacon_bringer/bases/view_model_state.dart';
import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/minor_category_data.dart';
import 'package:bacon_bringer/ui/category/view_model/category_screen_view_model.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  final AccountData account;
  final List<MinorCategoryData> minorCategories;
  const CategoryScreen(
      {super.key, required this.account, required this.minorCategories});

  @override
  State<StatefulWidget> createState() => _CategoryScreenState();
}

class _CategoryScreenState
    extends ViewModelState<CategoryScreen, CategoryScreenViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("カテゴリーを登録"),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            foregroundColor: Theme.of(context).colorScheme.primary),
        body: viewModel.body(context),
        floatingActionButton: FloatingActionButton(
            onPressed: () => viewModel.model.create().then((value) {
                  Navigator.of(context).pop();
                }),
            child: const Icon(Icons.add)));
  }

  @override
  CategoryScreenViewModel createViewModel() =>
      CategoryScreenViewModel(this, widget.account, widget.minorCategories);
}
