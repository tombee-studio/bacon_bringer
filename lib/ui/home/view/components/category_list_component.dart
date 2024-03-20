import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/category_data.dart';
import 'package:bacon_bringer/data/minor_category_data.dart';
import 'package:bacon_bringer/enum/major_state.dart';
import 'package:bacon_bringer/ui/category/view/screen/category_screen.dart';
import 'package:flutter/material.dart';

class CategoryListComponent extends StatelessWidget {
  final AccountData account;
  final List<MinorCategoryData> minorCategories;
  final List<CategoryData> categories;
  final Function callback;

  const CategoryListComponent(
      {super.key,
      required this.categories,
      required this.minorCategories,
      required this.account,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: const EdgeInsets.all(12.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text("カテゴリー", style: TextStyle(fontSize: 18)),
            IconButton(
                onPressed: () async {
                  await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CategoryScreen(
                          account: account, minorCategories: minorCategories)));
                  callback();
                },
                icon: const Icon(Icons.add))
          ])),
      const Divider(),
      Column(
          children: categories.map(((category) {
        return ListTile(
            leading: Icon(icon(category)),
            title: Text(category.name),
            subtitle: Text(category.minor.name));
      })).toList())
    ]);
  }

  IconData icon(CategoryData category) {
    switch (category.minor.majorCategory) {
      case MajorState.expense:
        return Icons.payment;
      case MajorState.income:
        return Icons.money;
      case MajorState.others:
        return Icons.question_mark;
    }
  }
}
