class Provider<T> {
  late T _instance;
  T get instance => _instance;

  Provider(this._instance);

  void overrideRepository(T instance) {
    _instance = instance;
  }
}
