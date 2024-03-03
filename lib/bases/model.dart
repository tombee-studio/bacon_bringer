import 'package:bacon_bringer/bases/notifier.dart';
import 'package:bacon_bringer/bases/property.dart';

abstract class Model {
  final Notifier _notifier;

  Model(this._notifier);

  Property<T> propertyOf<T>(T initial) {
    return Property(initial, _notifier);
  }
}
