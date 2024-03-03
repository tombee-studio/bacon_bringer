import 'package:bacon_bringer/data/overview_data.dart';
import 'package:flutter/material.dart';

class OverviewComponent extends StatelessWidget {
  final OverviewData overviewData;

  const OverviewComponent({super.key, required this.overviewData});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              ListTile(
                leading: const Icon(Icons.money),
                title: Text("¥${overviewData.sumOfMoney}",
                    textAlign: TextAlign.right),
                subtitle: const Text('貯金', textAlign: TextAlign.right),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                createRowItem(
                    Icons.abc, "月間支出", overviewData.totalExpencesOnMonth),
                createRowItem(
                    Icons.abc, "月間収入", overviewData.totalIncomesOnMonth)
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                createRowItem(Icons.abc, "予算", overviewData.budget),
                createRowItem(
                    Icons.abc, "対予算残高", overviewData.balanceAgainstBudget)
              ])
            ])));
  }

  Widget createRowItem(IconData icon, String label, int value) {
    return Row(children: [
      Icon(icon),
      Column(children: [
        Text("¥$value", textAlign: TextAlign.right),
        Text(label, textAlign: TextAlign.right)
      ])
    ]);
  }
}
