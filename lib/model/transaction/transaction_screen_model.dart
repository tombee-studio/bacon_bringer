import 'package:bacon_bringer/bases/list_property.dart';
import 'package:bacon_bringer/bases/model.dart';
import 'package:bacon_bringer/bases/property.dart';
import 'package:bacon_bringer/data/category_data.dart';
import 'package:bacon_bringer/repository/transaction_screen_repository.dart';

class TransactionScreenModel extends Model<TransactionScreenRepository> {
  late Property<double> _money;
  late Property<String> _purpose;
  late Property<DateTime> _transactionDate;
  late ListProperty<CategoryData> _categories;

  TransactionScreenModel(
      super.notifier, super.provider, List<CategoryData> categories) {
    _money = propertyOf(0.0);
    _purpose = propertyOf("");
    _transactionDate = propertyOf(DateTime.now());
    _categories = listPropertyOf(categories);
  }

  set money(double money) => _money.value = money;
  double get money => _money.value;

  set purpose(String purpose) => _purpose.value = purpose;
  String get purpose => _purpose.value;

  set transactionDate(DateTime date) => _transactionDate.value = date;
  DateTime get transactionDate => _transactionDate.value;

  List<CategoryData> get categories => _categories.value;
}
