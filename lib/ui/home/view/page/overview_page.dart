import 'package:bacon_bringer/data/category_budget.dart';
import 'package:bacon_bringer/data/overview_data.dart';
import 'package:bacon_bringer/ui/home/view/components/category_budget_list_component.dart';
import 'package:bacon_bringer/ui/home/view/components/monthly_report_component.dart';
import 'package:flutter/material.dart';

class OverviewPage extends StatelessWidget {
  final OverviewData overviewData;
  final List<CategoryBudget> categoryBudgetList;

  const OverviewPage(
      {super.key,
      required this.overviewData,
      required this.categoryBudgetList});

  Widget get monthlyReportComponent {
    return MonthlyReportComponent(overviewData: overviewData);
  }

  Widget get categoryBudgetListComponent {
    return CategoryBudgetListComponent(data: categoryBudgetList);
  }

  @override
  Widget build(BuildContext context) {
    final views = [monthlyReportComponent, categoryBudgetListComponent];
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: 2, itemBuilder: (context, index) => views[index]));
  }
}
