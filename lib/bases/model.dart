import 'package:bacon_bringer/bases/list_property.dart';
import 'package:bacon_bringer/bases/notifier.dart';
import 'package:bacon_bringer/bases/property.dart';
import 'package:bacon_bringer/bases/repository.dart';
import 'package:bacon_bringer/bases/repository_provider.dart';

abstract class Model<T extends Repository> {
  final RepositoryProvider<T> _provider;
  final Notifier _notifier;

  Model(this._notifier, this._provider);

  T get repository => _provider.repository;

  Property<T> propertyOf<T>(T initial) {
    return Property(initial, _notifier);
  }

  ListProperty<T> listPropertyOf<T>(List<T> initial) {
    return ListProperty(initial, _notifier);
  }
}
