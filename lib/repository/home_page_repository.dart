import 'package:bacon_bringer/bases/repository.dart';
import 'package:bacon_bringer/data/category_budget.dart';
import 'package:bacon_bringer/data/overview_data.dart';

abstract class HomePageRepository implements Repository {
  /// ローカルデータの読み込み
  Future loadLocalData();

  /// Firebase Authによるユーザ認証
  Future authenticate();

  /// データベース接続
  Future connectDatabase();

  /// 月間収支概要を取得
  Future<OverviewData> fetchMonthlyOverview();

  /// 月間カテゴリ予算概要を表示
  Future<List<CategoryBudget>> fetchCategoryBudgetList();
}
