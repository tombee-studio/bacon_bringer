import 'package:bacon_bringer/data/account_data.dart';
import 'package:flutter/material.dart';

class AccountListDrawer extends StatelessWidget {
  final List<AccountData> accounts;

  const AccountListDrawer({super.key, required this.accounts});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: [
      SizedBox(
          width: double.infinity,
          height: 76.0,
          child: DrawerHeader(
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: const Text("収支管理アカウント"))),
      Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) {
                final account = accounts[index];
                return ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(account.name),
                    subtitle: Text(account.purpose),
                    trailing: index == 0 ? const Icon(Icons.check) : null);
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: accounts.length))
    ]));
  }
}
