import 'package:bacon_bringer/bases/notifier.dart';
import 'package:bacon_bringer/bases/repository_provider.dart';
import 'package:bacon_bringer/bases/view_model.dart';
import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/user_data.dart';
import 'package:bacon_bringer/model/account/account_screen_model.dart';
import 'package:bacon_bringer/repository/account_screen_repository.dart';
import 'package:bacon_bringer/ui/account/view_model/repository/account_screen_app_repository.dart';
import 'package:flutter/material.dart';

final accountScreenRepositoryProvider =
    RepositoryProvider<AccountScreenRepository>(
        () => AccountScreenAppRepository());

class AccountScreenViewModel extends ViewModel<AccountScreenModel> {
  final UserData user;

  AccountScreenViewModel(super.notifier, this.user);

  @override
  AccountScreenModel createModel(Notifier notifier) =>
      AccountScreenModel(notifier, user, accountScreenRepositoryProvider);

  Widget content(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const Icon(Icons.person),
          name(context),
          purpose(context)
        ]));
  }

  Widget name(BuildContext context) {
    return TextField(
        decoration: const InputDecoration(label: Text("アカウント名")),
        onChanged: (value) => model.name = value);
  }

  Widget purpose(BuildContext context) {
    return TextField(
        decoration: const InputDecoration(label: Text("目的・説明")),
        onChanged: (value) => model.purpose = value);
  }

  Widget body(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width >= 641) {
      return SizedBox(width: 640, child: content(context));
    } else {
      return content(context);
    }
  }

  Future<AccountData> addAccount() async {
    return await model.addAccount();
  }
}
