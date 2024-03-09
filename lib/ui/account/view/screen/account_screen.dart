import 'package:bacon_bringer/bases/view_model_state.dart';
import 'package:bacon_bringer/data/user_data.dart';
import 'package:bacon_bringer/ui/account/view_model/account_screen_view_model.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  final UserData user;

  const AccountScreen({super.key, required this.user});

  @override
  State<StatefulWidget> createState() => AccountScreenState();
}

class AccountScreenState
    extends ViewModelState<AccountScreen, AccountScreenViewModel> {
  @override
  AccountScreenViewModel createViewModel() =>
      AccountScreenViewModel(this, widget.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("アカウントを追加"),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          foregroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: viewModel.body(context),
        floatingActionButton: FloatingActionButton(
            onPressed: () => viewModel
                .addAccount()
                .then((value) => Navigator.of(context).pop(value)),
            child: const Icon(Icons.add)));
  }
}
