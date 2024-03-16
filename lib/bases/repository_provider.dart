import 'package:bacon_bringer/bases/provider.dart';
import 'package:bacon_bringer/bases/repository.dart';

class RepositoryProvider<T extends Repository> extends Provider<T> {
  T get repository => instance;

  RepositoryProvider(T instance) : super(instance);
}
