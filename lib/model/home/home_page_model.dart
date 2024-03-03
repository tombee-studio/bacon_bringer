import 'package:bacon_bringer/bases/model.dart';
import 'package:bacon_bringer/bases/property.dart';
import 'package:bacon_bringer/data/overview_data.dart';
import 'package:bacon_bringer/model/home/repository/home_page_app_repository.dart';

class HomePageModel<T extends HomePageAppRepository> extends Model<T> {
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

    init();
  }

  void init() async {
    await repository.loadLocalData();
    await repository.authenticate();
    await repository.connectDatabase();
  }
}
