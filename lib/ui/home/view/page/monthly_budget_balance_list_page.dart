import 'package:bacon_bringer/bases/view_model_widget.dart';
import 'package:bacon_bringer/data/transaction_data.dart';
import 'package:bacon_bringer/enum/major_state.dart';
import 'package:bacon_bringer/ui/home/view_model/home_screen_view_model.dart';
import 'package:flutter/material.dart';

class MonthlyBudgetBalanceListPage
    extends ViewModelWidget<HomeScreenViewModel> {
  final List<TransactionData> transactions;

  const MonthlyBudgetBalanceListPage(
      {super.key, required super.parentViewModel, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return ListTile(
                    leading: Icon(icon(transaction)),
                    title: Text(transaction.purpose),
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(transaction.category.name),
                          Text("取引日：${transaction.createdAt}")
                        ]),
                    trailing: Text("¥${transaction.money.toInt()}"));
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: transactions.length))
    ]);
  }

  IconData icon(TransactionData transaction) {
    switch (transaction.category.major) {
      case MajorState.expense:
        return Icons.payment;
      case MajorState.income:
        return Icons.money;
      case MajorState.others:
        return Icons.question_mark;
    }
  }
}
