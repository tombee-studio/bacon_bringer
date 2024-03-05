import 'package:bacon_bringer/bases/notifier.dart';

class Property<T> {
  T _value;
  final Notifier _onNotified;

  Notifier get onNotified => _onNotified;

  set value(T _value) {
    this._value = _value;
    _onNotified.notify();
  }

  T get value => _value;

  Property(T initial, this._onNotified) : _value = initial;
}
