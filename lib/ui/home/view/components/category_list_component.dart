import 'package:bacon_bringer/data/category_data.dart';
import 'package:flutter/material.dart';

class CategoryListComponent extends StatelessWidget {
  final List<CategoryData> categories;

  const CategoryListComponent({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: const EdgeInsets.all(12.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text("カテゴリー", style: TextStyle(fontSize: 18)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.add))
          ])),
      const Divider(),
      Column(
          children: categories.map(((category) {
        return ListTile(
            title: Text(category.name), subtitle: Text("${category.minor}"));
      })).toList())
    ]);
  }
}
