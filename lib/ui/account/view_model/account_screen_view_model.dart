import 'package:bacon_bringer/bases/notifier.dart';
import 'package:bacon_bringer/bases/repository_provider.dart';
import 'package:bacon_bringer/bases/view_model.dart';
import 'package:bacon_bringer/data/user_data.dart';
import 'package:bacon_bringer/model/account/account_screen_model.dart';
import 'package:bacon_bringer/repository/account_screen_repository.dart';
import 'package:bacon_bringer/ui/account/view_model/repository/account_screen_app_repository.dart';
import 'package:flutter/material.dart';

final accountScreenRepositoryProvider =
    RepositoryProvider<AccountScreenRepository>(AccountScreenAppRepository());

class AccountScreenViewModel extends ViewModel<AccountScreenModel> {
  final UserData user;

  AccountScreenViewModel(super.notifier, this.user);

  Widget content(BuildContext context) {
    return Text(model.user.userName);
  }

  @override
  AccountScreenModel createModel(Notifier notifier) =>
      AccountScreenModel(notifier, user, accountScreenRepositoryProvider);

  Widget body(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width > 640) {
      return SizedBox(width: 640, child: content(context));
    } else {
      return content(context);
    }
  }
}
