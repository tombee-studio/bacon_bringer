import 'package:bacon_bringer/bases/notifier.dart';
import 'package:bacon_bringer/bases/view_model.dart';
import 'package:bacon_bringer/common/providers.dart';
import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/minor_category_data.dart';
import 'package:bacon_bringer/model/category/category_screen_model.dart';
import 'package:flutter/material.dart';

class CategoryScreenViewModel extends ViewModel<CategoryScreenModel> {
  final AccountData account;
  final List<MinorCategoryData> minorCategories;

  CategoryScreenViewModel(super.notifier, this.account, this.minorCategories);

  @override
  CategoryScreenModel createModel(Notifier notifier) =>
      CategoryScreenModel(notifier, categoryScreenRepositoryProvider, account);

  Widget content(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const Icon(Icons.person),
          name(context),
          minorCategory(context)
        ]));
  }

  Widget name(BuildContext context) {
    return TextField(
        decoration: const InputDecoration(label: Text("カテゴリー名")),
        onChanged: (value) => model.name = value);
  }

  Widget minorCategory(BuildContext context) {
    return DropdownButtonFormField<MinorCategoryData>(
        items: minorCategories
            .map((item) => DropdownMenuItem<MinorCategoryData>(
                value: item, child: Text(item.name)))
            .toList(),
        decoration: const InputDecoration(label: Text("小カテゴリー名")),
        onChanged: (value) {
          if (value != null) {
            model.minor = value;
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
