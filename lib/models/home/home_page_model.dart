import 'package:bacon_bringer/bases/model.dart';
import 'package:bacon_bringer/bases/property.dart';
import 'package:bacon_bringer/bases/repository.dart';
import 'package:bacon_bringer/data/overview_data.dart';

class HomePageModel<T extends Repository> extends Model<T> {
  final String _title;
  late Property<bool> _isLoading;
  late Property<OverviewData> _overviewData;

  String get title => _title;

  bool get isLoading => _isLoading.value;
  OverviewData get overviewData => _overviewData.value;

  HomePageModel(super.notifier, super._repository, this._title) {
    _overviewData = propertyOf(OverviewData(
        sumOfMoney: 100000,
        balanceAgainstBudget: 12000,
        budget: 20000,
        totalExpencesOnMonth: 8000,
        totalIncomesOnMonth: 0));
    _isLoading = propertyOf(false);
  }
}
