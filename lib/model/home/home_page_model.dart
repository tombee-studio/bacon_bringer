import 'package:bacon_bringer/bases/model.dart';
import 'package:bacon_bringer/bases/property.dart';
import 'package:bacon_bringer/data/loading_data.dart';
import 'package:bacon_bringer/data/overview_data.dart';
import 'package:bacon_bringer/model/home/repository/home_page_app_repository.dart';

class HomePageModel<T extends HomePageAppRepository> extends Model<T> {
  final String _title;
  late Property<LoadingData> _isLoading;
  late Property<OverviewData> _overviewData;

  String get title => _title;

  LoadingData get isLoading => _isLoading.value;
  OverviewData get overviewData => _overviewData.value;

  HomePageModel(super.notifier, super._repository, this._title) {
    _overviewData = propertyOf(OverviewData(
        sumOfMoney: 100000,
        balanceAgainstBudget: 12000,
        budget: 20000,
        totalExpencesOnMonth: 8000,
        totalIncomesOnMonth: 0));
    _isLoading =
        propertyOf(LoadingData(isLoading: true, message: "ローカルデータを取得中..."));
  }

  Future launch() async {
    await repository.loadLocalData();
    _isLoading.value = LoadingData(isLoading: true, message: "ユーザ認証中...");
    await repository.authenticate();
    _isLoading.value = LoadingData(isLoading: true, message: "データベースと接続中...");
    await repository.connectDatabase();

    onLoaded();
  }

  void onLoaded() {
    _isLoading.value = LoadingData(isLoading: false, message: "起動時処理成功");
  }
}
