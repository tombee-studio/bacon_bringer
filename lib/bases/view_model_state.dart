import 'package:bacon_bringer/bases/notifier.dart';
import 'package:bacon_bringer/bases/view_model.dart';
import 'package:flutter/material.dart';

abstract class ViewModelState<T extends StatefulWidget, S extends ViewModel>
    extends State<T> implements Notifier {
  late S _viewModel;

  S get viewModel => _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = createViewModel();
  }

  @override
  void notify() {
    setState(nop);
  }

  /// Viewへの更新通知用に作成
  /// 内部では何もしない
  void nop() {}

  S createViewModel();

  @override
  void deactivate() {
    super.deactivate();

    viewModel.deactivate();
  }
}
