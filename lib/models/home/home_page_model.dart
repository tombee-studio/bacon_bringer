import 'package:bacon_bringer/bases/model.dart';
import 'package:bacon_bringer/bases/property.dart';

class HomePageModel extends Model {
  final String title;
  late Property<int> _counter;

  String get counter => '${_counter.value}';

  HomePageModel(super.notifier, this.title) {
    _counter = propertyOf(0);
  }

  void incrementCounter() {
    _counter.value++;
  }
}
