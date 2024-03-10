import 'package:bacon_bringer/bases/repository.dart';
import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/category_budget.dart';
import 'package:bacon_bringer/data/overview_data.dart';
import 'package:bacon_bringer/data/transaction_data.dart';
import 'package:bacon_bringer/data/user_data.dart';

abstract class HomePageRepository implements Repository {
  /// ローカルデータの読み込み
  Future loadLocalData();

  /// Firebase Authによるユーザ認証
  Future<UserData> authenticate();

  /// データベース接続
  Future connectDatabase();

  /// アカウントを取得
  Future<List<AccountData>> fetchAccounts(UserData user);

  /// 月間収支概要を取得
  Future<OverviewData> fetchMonthlyOverview(AccountData account);

  /// 月間カテゴリ予算概要を表示
  Future<List<CategoryBudget>> fetchCategoryBudgetList(AccountData account);

  /// 一定の期間の収支をリストで取得
  /// [account] リスト取得する対象のアカウント
  /// [from] 期間の開始日 ※ 該当日を含む
  /// [to] 期間の終了日 ※該当日を含まない
  Future<List<TransactionData>> fetchTransactions(AccountData account,
      {required DateTime from, required DateTime to});
}
