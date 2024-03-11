import 'package:bacon_bringer/bases/model.dart';
import 'package:bacon_bringer/bases/notifier.dart';
import 'package:flutter/material.dart';

abstract class ViewModel<T extends Model> {
  final Notifier _notifier;

  late T _model;
  T get model => _model;

  late BuildContext _context;
  set context(BuildContext value) => _context = value;
  BuildContext get context => _context;

  ViewModel(this._notifier) {
    _model = createModel(_notifier);
  }

  T createModel(Notifier notifier);

  void deactivate() {}
}
