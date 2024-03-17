import 'package:bacon_bringer/bases/notifier.dart';
import 'package:bacon_bringer/bases/repository_provider.dart';
import 'package:bacon_bringer/bases/view_model.dart';
import 'package:bacon_bringer/data/user_data.dart';
import 'package:bacon_bringer/model/user/user_screen_model.dart';
import 'package:bacon_bringer/repository/user_screen_repository.dart';
import 'package:bacon_bringer/ui/user/view_model/repository/user_screen_app_repository.dart';
import 'package:flutter/material.dart';

final userScreenRepositoryProvider =
    RepositoryProvider<UserScreenRepository>(() => UserScreenAppRepository());

class UserScreenViewModel extends ViewModel<UserScreenModel> {
  UserScreenViewModel(super.notifier);

  @override
  UserScreenModel createModel(Notifier notifier) =>
      UserScreenModel(notifier, userScreenRepositoryProvider);

  Widget content(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const Icon(Icons.person),
          name(context),
          password(context),
          password2(context)
        ]));
  }

  Widget name(BuildContext context) {
    return TextField(
        decoration: const InputDecoration(label: Text("アカウント名")),
        onChanged: (value) => model.name = value);
  }

  Widget password(BuildContext context) {
    return TextField(
        decoration: const InputDecoration(label: Text("パスワード")),
        onChanged: (value) => model.password = value);
  }

  Widget password2(BuildContext context) {
    return TextField(
        decoration: const InputDecoration(label: Text("パスワード")),
        onChanged: (value) => model.password2 = value);
  }

  Widget body(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width >= 641) {
      return SizedBox(width: 640, child: content(context));
    } else {
      return content(context);
    }
  }

  Future<UserData> authenticate() async => await model.authenticate();
}
