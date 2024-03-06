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
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("収支概要", style: TextStyle(fontSize: 18.0)),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.money),
                    title: Text("¥${overviewData.sumOfMoney}",
                        textAlign: TextAlign.right),
                    subtitle: const Text('貯金', textAlign: TextAlign.right),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        createRowItem(Icons.abc, "月間収入",
                            overviewData.totalIncomesOnMonth),
                        createRowItem(Icons.abc, "月間支出",
                            overviewData.totalExpencesOnMonth)
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        createRowItem(Icons.abc, "予算", overviewData.budget),
                        createRowItem(Icons.abc, "対予算残高",
                            overviewData.balanceAgainstBudget)
                      ])
                ])));
  }

  Widget createRowItem(IconData icon, String label, int value) {
    return Expanded(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Icon(icon),
      Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Text("¥$value", textAlign: TextAlign.right),
        Text(label, textAlign: TextAlign.right)
      ])
    ]));
  }
}
