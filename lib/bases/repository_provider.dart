import 'package:bacon_bringer/bases/repository.dart';

class RepositoryProvider<T extends Repository> {
  late T _repository;
  T get repository => _repository;

  RepositoryProvider(this._repository);

  void overrideRepository(T repository) {
    _repository = repository;
  }
}
