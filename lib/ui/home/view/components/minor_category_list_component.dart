import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/minor_category_data.dart';
import 'package:bacon_bringer/ui/minor_category/view/screen/minor_category_screen.dart';
import 'package:flutter/material.dart';

class MinorCategoryListComponent extends StatelessWidget {
  final AccountData account;
  final List<MinorCategoryData> minorCategories;
  final Function callback;

  const MinorCategoryListComponent(
      {super.key,
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
            const Text("小カテゴリー", style: TextStyle(fontSize: 18)),
            IconButton(
                onPressed: () async {
                  await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          MinorCategoryScreen(account: account)));
                  callback();
                },
                icon: const Icon(Icons.add))
          ])),
      const Divider(),
      Column(
          children: minorCategories.map(((category) {
        return ListTile(
            title: Text(category.name),
            subtitle: Text("${category.majorCategory}"));
      })).toList())
    ]);
  }
}
