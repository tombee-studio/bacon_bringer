import 'package:bacon_bringer/bases/notifier.dart';
import 'package:bacon_bringer/bases/property.dart';
import 'package:bacon_bringer/bases/repository.dart';

abstract class Model<T extends Repository> {
  final T _repository;
  final Notifier _notifier;

  Model(this._notifier, this._repository);

  T get repository => _repository;

  Property<T> propertyOf<T>(T initial) {
    return Property(initial, _notifier);
  }
}
