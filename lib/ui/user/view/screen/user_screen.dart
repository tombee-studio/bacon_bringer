import 'package:bacon_bringer/bases/view_model_state.dart';
import 'package:bacon_bringer/ui/user/view_model/user_screen_view_model.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<StatefulWidget> createState() => _UserScreenState();
}

class _UserScreenState extends ViewModelState<UserScreen, UserScreenViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("ユーザ情報を登録"),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          foregroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: viewModel.body(context),
        floatingActionButton: FloatingActionButton(
            onPressed: () => viewModel
                .authenticate()
                .then((value) => Navigator.of(context).pop(value)),
            child: const Icon(Icons.add)));
  }

  @override
  UserScreenViewModel createViewModel() => UserScreenViewModel(this);
}
