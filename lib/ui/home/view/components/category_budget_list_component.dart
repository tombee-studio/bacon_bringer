import 'package:bacon_bringer/data/category_budget.dart';
import 'package:flutter/material.dart';

class CategoryBudgetListComponent extends StatelessWidget {
  final List<CategoryBudget> data;

  const CategoryBudgetListComponent({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("予算概要", style: TextStyle(fontSize: 18.0)),
          const Divider(),
          Column(
              children: data
                  .map((item) => ListTile(
                      title: Text(item.category.name),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("¥${item.leftBudgetPerMonth}"),
                            Text("¥${item.budgetPerDay}")
                          ])))
                  .toList())
        ]));
  }
}
