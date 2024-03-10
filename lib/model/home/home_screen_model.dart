import 'package:bacon_bringer/bases/list_property.dart';
import 'package:bacon_bringer/bases/model.dart';
import 'package:bacon_bringer/bases/property.dart';
import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/category_budget.dart';
import 'package:bacon_bringer/data/loading_data.dart';
import 'package:bacon_bringer/data/overview_data.dart';
import 'package:bacon_bringer/data/transaction_data.dart';
import 'package:bacon_bringer/data/user_data.dart';
import 'package:bacon_bringer/enum/home_page_state.dart';
import 'package:bacon_bringer/repository/home_page_repository.dart';

class HomeScreenModel<T extends HomePageRepository> extends Model<T> {
  final String _title;

  late Property<HomePageState> _currentState;
  late Property<int> _currentAccountIndex;
  late Property<LoadingData> _isLoading;
  late Property<OverviewData> _overviewData;
  late Property<UserData> _user;

  late ListProperty<CategoryBudget> _categoryBudgets;
  late ListProperty<AccountData> _accounts;
  late ListProperty<TransactionData> _transactions;

  String get title => _title;

  LoadingData get isLoading => _isLoading.value;
  OverviewData get overviewData => _overviewData.value;
  UserData get user => _user.value;

  List<CategoryBudget> get categoryBudgetList => _categoryBudgets.value;
  List<AccountData> get accounts => _accounts.value;
  List<TransactionData> get transactions => _transactions.value;

  HomePageState get currentState => _currentState.value;
  set currentState(HomePageState value) => _currentState.value = value;

  int get currentAccountIndex => _currentAccountIndex.value;
  set currentAccountIndex(value) {
    _currentAccountIndex.value = value;

    loadData();
  }

  AccountData get currentAccount => accounts[currentAccountIndex];

  HomeScreenModel(super.notifier, super._repository, this._title) {
    _overviewData = propertyOf(OverviewData(
        sumOfMoney: 0,
        balanceAgainstBudget: 0,
        budget: 0,
        totalExpencesOnMonth: 0,
        totalIncomesOnMonth: 0));

    _currentState = propertyOf(HomePageState.overview);
    _currentAccountIndex = propertyOf(0);

    _user = propertyOf(UserData(id: "", userName: "", password: ""));
    _isLoading =
        propertyOf(LoadingData(isLoading: true, message: "ローカルデータを取得中..."));

    _categoryBudgets = listPropertyOf(<CategoryBudget>[]);
    _accounts = listPropertyOf(<AccountData>[]);
    _transactions = listPropertyOf(<TransactionData>[]);
  }

  Future launch() async {
    await repository.loadLocalData();

    _isLoading.value = LoadingData(isLoading: true, message: "ユーザ認証中...");
    _user.value = await repository.authenticate();

    _isLoading.value = LoadingData(isLoading: true, message: "データベースと接続中...");
    await repository.connectDatabase();
    await loadData();
  }

  void onLoaded() {
    _isLoading.value = LoadingData(isLoading: false, message: "起動時処理成功");
  }

  Future loadData() async {
    _isLoading.value = LoadingData(isLoading: true, message: "各種データ取得中...");
    _accounts.value = await repository.fetchAccounts(user);
    _overviewData.value = await repository.fetchMonthlyOverview(currentAccount);
    _categoryBudgets.value =
        await repository.fetchCategoryBudgetList(currentAccount);
    _transactions.value = await repository.fetchTransactions(currentAccount,
        from: DateTime(2024, 3, 1), to: DateTime(2024, 4, 1));
    onLoaded();
  }
}
