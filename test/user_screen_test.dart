import 'package:bacon_bringer/data/user_data.dart';
import 'package:bacon_bringer/model/user/user_screen_model.dart';
import 'package:bacon_bringer/repository/user_screen_repository.dart';
import 'package:bacon_bringer/ui/user/view_model/user_screen_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

import 'util.dart';

class UserScreenTestRepository extends UserScreenRepository {
  @override
  Future<UserData> signup(
      String userName, String password, String password2) async {
    return UserData(id: 0, userName: userName, password: password);
  }
}

void main() {
  group("AccountScreenModel", () {
    test("AccountScreenModelが正しく初期化されていること", () async {
      userScreenRepositoryProvider
          .overrideRepository(() => UserScreenTestRepository());

      final model =
          UserScreenModel(TestNotifier(), userScreenRepositoryProvider);
      expect(model.name, "");
      expect(model.password, "");
      expect(model.password2, "");
    });

    test("AccountScreenModelのプロパティを更新できていること", () async {
      const testUserName = "test_user_name";
      const testPassword = "test_password";
      const testPassword2 = "test_password2";
      userScreenRepositoryProvider
          .overrideRepository(() => UserScreenTestRepository());

      final model =
          UserScreenModel(TestNotifier(), userScreenRepositoryProvider);
      model.name = testUserName;
      model.password = testPassword;
      model.password2 = testPassword2;

      expect(model.name, testUserName);
      expect(model.password, testPassword);
      expect(model.password2, testPassword2);
    });

    test("authenticateメソッドが機能すること", () async {
      const testUserName = "test_user_name";
      const testPassword = "test_password";
      const testPassword2 = "test_password2";
      userScreenRepositoryProvider
          .overrideRepository(() => UserScreenTestRepository());

      final model =
          UserScreenModel(TestNotifier(), userScreenRepositoryProvider);
      model.name = testUserName;
      model.password = testPassword;
      model.password2 = testPassword2;

      final user = await model.authenticate();
      expect(user.userName, testUserName);
      expect(user.password, testPassword);
    });
  });
}
