import 'package:bacon_bringer/data/category_budget.dart';
import 'package:flutter/material.dart';

class CategoryBudgetListComponent extends StatelessWidget {
  final List<CategoryBudget> data;

  const CategoryBudgetListComponent({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: data
            .map((item) => ListTile(
                title: Text(item.category.name),
                subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("¥${item.leftBudgetPerMonth}"),
                      Text("¥${item.budgetPerDay}")
                    ])))
            .toList());
  }
}
