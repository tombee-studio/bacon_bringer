import 'package:bacon_bringer/bases/notifier.dart';
import 'package:bacon_bringer/bases/view_model.dart';
import 'package:bacon_bringer/models/home_page_model.dart';
import 'package:flutter/material.dart';

class HomePageViewModel extends ViewModel<HomePageModel> {
  final String _title;

  HomePageViewModel(super.notifier, this._title);

  @override
  HomePageModel createModel(Notifier notifier) =>
      HomePageModel(notifier, _title);

  Widget get title => Text(model.title);
  String get counter => model.counter;

  void incrementCounter() => model.incrementCounter();
}
