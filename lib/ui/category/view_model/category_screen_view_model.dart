import 'package:bacon_bringer/bases/notifier.dart';
import 'package:bacon_bringer/bases/view_model.dart';
import 'package:bacon_bringer/common/providers.dart';
import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/model/category/category_screen_model.dart';
import 'package:flutter/material.dart';

class CategoryScreenViewModel extends ViewModel<CategoryScreenModel> {
  final AccountData account;
  CategoryScreenViewModel(super.notifier, this.account);

  @override
  CategoryScreenModel createModel(Notifier notifier) =>
      CategoryScreenModel(notifier, categoryScreenRepositoryProvider, account);

  Widget content(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [const Icon(Icons.person), name(context)]));
  }

  Widget name(BuildContext context) {
    return TextField(
        decoration: const InputDecoration(label: Text("アカウント名")),
        onChanged: (value) => model.name = value);
  }

  Widget body(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width >= 641) {
      return SizedBox(width: 640, child: content(context));
    } else {
      return content(context);
    }
  }
}
