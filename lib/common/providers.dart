import 'package:bacon_bringer/bases/repository_provider.dart';
import 'package:bacon_bringer/repository/account_screen_repository.dart';
import 'package:bacon_bringer/repository/category_screen_repository.dart';
import 'package:bacon_bringer/repository/home_screen_repository.dart';
import 'package:bacon_bringer/repository/user_screen_repository.dart';
import 'package:bacon_bringer/ui/account/view_model/repository/account_screen_app_repository.dart';
import 'package:bacon_bringer/ui/category/view_model/repository/category_screen_app_repository.dart';
import 'package:bacon_bringer/ui/home/view_model/repository/home_page_app_repository.dart';
import 'package:bacon_bringer/ui/user/view_model/repository/user_screen_app_repository.dart';

final homeScreenRepositoryProvider =
    RepositoryProvider<HomeScreenRepository>(() => HomeScreenAppRepository());
final categoryScreenRepositoryProvider =
    RepositoryProvider<CategoryScreenRepository>(
        () => CategoryScreenAppRepository());
final accountScreenRepositoryProvider =
    RepositoryProvider<AccountScreenRepository>(
        () => AccountScreenAppRepository());
final userScreenRepositoryProvider =
    RepositoryProvider<UserScreenRepository>(() => UserScreenAppRepository());
