import 'package:bacon_bringer/bases/notifier.dart';
import 'package:bacon_bringer/bases/view_model.dart';
import 'package:bacon_bringer/models/home/home_page_model.dart';
import 'package:bacon_bringer/ui/home/repository/home_page_app_repository.dart';
import 'package:flutter/material.dart';

class HomePageViewModel extends ViewModel<HomePageModel> {
  final String _title;

  HomePageViewModel(super.notifier, this._title);

  @override
  HomePageModel createModel(Notifier notifier) =>
      HomePageModel(notifier, HomePageAppRepository(), _title);

  Widget get title => Text(model.title);
  Widget get overview {
    final overviewData = model.overviewData;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(children: [
          Row(children: [const Text("合計"), Text('${overviewData.sumOfMoney}')])
        ]));
  }

  Widget body(BuildContext context) {
    if (model.isLoading) {
      return const CircularProgressIndicator();
    } else {
      final size = MediaQuery.of(context).size;
      if (size.width > 600) {
        return SizedBox(width: 600, child: overview);
      } else {
        return overview;
      }
    }
  }
}
