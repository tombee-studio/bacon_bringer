import 'package:bacon_bringer/bases/view_model_state.dart';
import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/ui/minor_category/view_model/minor_category_screen_view_model.dart';
import 'package:flutter/material.dart';

class MinorCategoryScreen extends StatefulWidget {
  final AccountData account;
  const MinorCategoryScreen({super.key, required this.account});

  @override
  State<StatefulWidget> createState() => _MinorCategoryScreenState();
}

class _MinorCategoryScreenState
    extends ViewModelState<MinorCategoryScreen, MinorCategoryScreenViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("小カテゴリーを登録"),
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
  MinorCategoryScreenViewModel createViewModel() =>
      MinorCategoryScreenViewModel(this, widget.account);
}
