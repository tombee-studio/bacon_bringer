import 'package:bacon_bringer/bases/view_model_state.dart';
import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/category_data.dart';
import 'package:bacon_bringer/ui/transaction/view_model/transaction_screen_view_model.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  final AccountData account;
  final List<CategoryData> categories;
  const TransactionScreen(
      {super.key, required this.account, required this.categories});

  @override
  State<StatefulWidget> createState() => _TransactionScreenState();
}

class _TransactionScreenState
    extends ViewModelState<TransactionScreen, TransactionScreenViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("取引を登録"),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            foregroundColor: Theme.of(context).colorScheme.primary),
        body: viewModel.body(context),
        floatingActionButton: FloatingActionButton(
            onPressed: () =>
                viewModel.create().then((value) => Navigator.of(context).pop()),
            child: const Icon(Icons.add)));
  }

  @override
  TransactionScreenViewModel createViewModel() =>
      TransactionScreenViewModel(this, widget.account, widget.categories);
}
