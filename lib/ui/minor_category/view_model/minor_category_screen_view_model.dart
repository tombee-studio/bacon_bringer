import 'package:bacon_bringer/bases/notifier.dart';
import 'package:bacon_bringer/bases/view_model.dart';
import 'package:bacon_bringer/common/providers.dart';
import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/enum/major_state.dart';
import 'package:bacon_bringer/model/minor_category/minor_category_screen_model.dart';
import 'package:flutter/material.dart';

class MinorCategoryScreenViewModel extends ViewModel<MinorCategoryScreenModel> {
  final AccountData account;
  MinorCategoryScreenViewModel(super.notifier, this.account);

  @override
  MinorCategoryScreenModel createModel(Notifier notifier) =>
      MinorCategoryScreenModel(
          notifier, minorCategoryScreenRepositoryProvider, account);

  Widget content(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const Icon(Icons.person),
          name(context),
          majorCategory(context)
        ]));
  }

  Widget name(BuildContext context) {
    return TextField(
        decoration: const InputDecoration(label: Text("カテゴリー名")),
        onChanged: (value) => model.name = value);
  }

  Widget majorCategory(BuildContext context) {
    return DropdownButtonFormField<MajorState>(
        items: MajorState.values
            .map((item) => DropdownMenuItem<MajorState>(
                value: item, child: Text(item.name)))
            .toList(),
        decoration: const InputDecoration(label: Text("小カテゴリー名")),
        onChanged: (value) {
          if (value != null) {
            model.major = value;
          }
        });
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
