import 'package:bacon_bringer/bases/model.dart';
import 'package:bacon_bringer/bases/property.dart';

class HomePageModel extends Model {
  final String _title;
  late Property<int> _counter;

  String get title => _title;
  String get counter => '${_counter.value}';

  HomePageModel(super.notifier, this._title) {
    _counter = propertyOf(0);
  }

  void incrementCounter() {
    _counter.value++;
  }
}
