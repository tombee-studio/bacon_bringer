import 'package:bacon_bringer/bases/view_model_state.dart';
import 'package:bacon_bringer/data/category_data.dart';
import 'package:bacon_bringer/data/user_data.dart';
import 'package:bacon_bringer/ui/transaction/view_model/transaction_screen_view_model.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  final UserData user;
  final List<CategoryData> categories;
  const TransactionScreen(
      {super.key, required this.user, required this.categories});

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
            onPressed: () {}, child: const Icon(Icons.add)));
  }

  @override
  TransactionScreenViewModel createViewModel() =>
      TransactionScreenViewModel(this, widget.categories);
}
