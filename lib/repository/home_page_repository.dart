import 'package:bacon_bringer/bases/repository.dart';

abstract class HomePageRepository implements Repository {
  /// ローカルデータの読み込み
  Future loadLocalData();

  /// * Firebase Authによるユーザ認証
  Future authenticate();

  /// * データベース接続
  Future connectDatabase();
}
