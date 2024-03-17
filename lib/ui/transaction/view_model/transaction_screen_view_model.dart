import 'package:bacon_bringer/bases/notifier.dart';
import 'package:bacon_bringer/bases/repository_provider.dart';
import 'package:bacon_bringer/bases/view_model.dart';
import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/category_data.dart';
import 'package:bacon_bringer/data/transaction_data.dart';
import 'package:bacon_bringer/model/transaction/transaction_screen_model.dart';
import 'package:bacon_bringer/repository/transaction_screen_repository.dart';
import 'package:bacon_bringer/ui/transaction/view_model/repository/transaction_screen_app_repository.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

final transactionScreenRepositoryProvider =
    RepositoryProvider<TransactionScreenRepository>(
        () => TransactionScreenAppRepository());

class TransactionScreenViewModel extends ViewModel<TransactionScreenModel> {
  final AccountData account;
  final List<CategoryData> categories;

  TransactionScreenViewModel(super.notifier, this.account, this.categories);

  @override
  TransactionScreenModel createModel(Notifier notifier) =>
      TransactionScreenModel(
          notifier, transactionScreenRepositoryProvider, account, categories);

  Widget purpose(BuildContext context) {
    return TextField(
        decoration: const InputDecoration(label: Text("用途")),
        onChanged: (value) => model.purpose = value);
  }

  Widget money(BuildContext context) {
    return TextField(
        decoration: const InputDecoration(label: Text("コスト")),
        onChanged: (value) {
          try {
            model.money = double.parse(value);
          } catch (ex) {
            print(ex);
          }
        });
  }

  Widget date(BuildContext context) {
    return DateTimeFormField(
        decoration: const InputDecoration(label: Text("取引日時")),
        onChanged: (value) {
          if (value != null) {
            model.transactionDate = value;
          }
        });
  }

  Widget category(BuildContext context) {
    return DropdownButtonFormField(
        items: categories
            .map((category) =>
                DropdownMenuItem(value: category, child: Text(category.name)))
            .toList(),
        onChanged: (value) {
          if (value != null) {
            model.category = value;
          }
        });
  }

  Widget content(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const Icon(Icons.person),
          purpose(context),
          money(context),
          category(context),
          date(context)
        ]));
  }

  body(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width >= 641) {
      return SizedBox(width: 640, child: content(context));
    } else {
      return content(context);
    }
  }

  Future<TransactionData> create() => model.create();
}
