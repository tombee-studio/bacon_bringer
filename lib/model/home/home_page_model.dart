import 'package:bacon_bringer/bases/list_property.dart';
import 'package:bacon_bringer/bases/model.dart';
import 'package:bacon_bringer/bases/property.dart';
import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/category_budget.dart';
import 'package:bacon_bringer/data/loading_data.dart';
import 'package:bacon_bringer/data/overview_data.dart';
import 'package:bacon_bringer/data/user_data.dart';
import 'package:bacon_bringer/repository/home_page_repository.dart';

class HomePageModel<T extends HomePageRepository> extends Model<T> {
  final String _title;

  late Property<int> _currentIndex;
  late Property<LoadingData> _isLoading;
  late Property<OverviewData> _overviewData;
  late Property<UserData> _user;

  late ListProperty<CategoryBudget> _categoryBudgets;
  late ListProperty<AccountData> _accounts;

  String get title => _title;

  LoadingData get isLoading => _isLoading.value;
  OverviewData get overviewData => _overviewData.value;
  UserData get user => _user.value;

  List<CategoryBudget> get categoryBudgetList => _categoryBudgets.value;
  List<AccountData> get accounts => _accounts.value;

  int get currentIndex => _currentIndex.value;
  set currentIndex(int value) => _currentIndex.value = value;

  HomePageModel(super.notifier, super._repository, this._title) {
    _overviewData = propertyOf(OverviewData(
        sumOfMoney: 0,
        balanceAgainstBudget: 0,
        budget: 0,
        totalExpencesOnMonth: 0,
        totalIncomesOnMonth: 0));
    _currentIndex = propertyOf(0);
    _user = propertyOf(UserData(id: "", userName: "", password: ""));
    _categoryBudgets = listPropertyOf(<CategoryBudget>[]);
    _isLoading =
        propertyOf(LoadingData(isLoading: true, message: "ローカルデータを取得中..."));
    _accounts = listPropertyOf(<AccountData>[]);
  }

  Future launch() async {
    await repository.loadLocalData();

    _isLoading.value = LoadingData(isLoading: true, message: "ユーザ認証中...");
    _user.value = await repository.authenticate();

    _isLoading.value = LoadingData(isLoading: true, message: "データベースと接続中...");
    await repository.connectDatabase();

    _isLoading.value = LoadingData(isLoading: true, message: "各種データ取得中...");

    _accounts.value = await repository.fetchAccounts(user);
    _overviewData.value = await repository.fetchMonthlyOverview();
    for (final account in _accounts.value) {
      _categoryBudgets.value =
          await repository.fetchCategoryBudgetList(account);
    }

    onLoaded();
  }

  void onLoaded() {
    _isLoading.value = LoadingData(isLoading: false, message: "起動時処理成功");
  }
}
