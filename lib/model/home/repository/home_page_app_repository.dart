import 'package:bacon_bringer/repository/home_page_repository.dart';

class HomePageAppRepository extends HomePageRepository {
  @override
  Future loadLocalData() async {
    await Future.delayed(const Duration(milliseconds: 1000));
  }

  @override
  Future authenticate() async {
    await Future.delayed(const Duration(milliseconds: 1000));
  }

  @override
  Future connectDatabase() async {
    await Future.delayed(const Duration(milliseconds: 1000));
  }
}
