import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/category_data.dart';
import 'package:bacon_bringer/data/transaction_data.dart';
import 'package:bacon_bringer/data/transaction_overview_data.dart';
import 'package:bacon_bringer/data/user_data.dart';
import 'package:bacon_bringer/enum/major_state.dart';
import 'package:bacon_bringer/enum/minor_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("TransactionData", () {
    test("TransactionDataが初期化されること", () {
      final user =
          UserData(id: 0, userName: "testUserName", password: "testPassword");
      const testAccountName = "test_account_name_created";
      const testAccountPurpose = "test_account_purpose_created";
      const testPurpose = "test_purpose";
      const testMoney = 100.0;
      final testDate = DateTime.fromMicrosecondsSinceEpoch(3000);
      final category = CategoryData(
          account: AccountData(
              id: 0,
              user: user,
              name: testAccountName,
              purpose: testAccountPurpose),
          major: MajorState.expense,
          minor: MinorState.fixedCosts,
          name: testAccountName);
      final data = TransactionData(
          purpose: testPurpose,
          money: testMoney,
          category: category,
          createdAt: testDate);
      expect(data.purpose, testPurpose);
      expect(data.money, testMoney);
      expect(data.createdAt, testDate);

      expect(data.category.name, category.name);
      expect(data.category.major, category.major);
      expect(data.category.minor, category.minor);

      expect(data.category.account.name, category.account.name);
      expect(data.category.account.purpose, category.account.purpose);

      expect(data.category.account.user.id, category.account.user.id);
      expect(
          data.category.account.user.password, category.account.user.password);
      expect(
          data.category.account.user.userName, category.account.user.userName);
    });
  });

  group("TransactionOverviewData", () {
    test("TransactionOverviewDataが初期化されること", () {
      final data = TransactionOverviewData(
          1000.0, 2000.0, DateTime(2024, 3, 1), DateTime(2024, 4, 1));
      expect(data.monthlyTotalExpense, 1000.0);
      expect(data.monthlyTotalIncome, 2000.0);
      expect(data.from, DateTime(2024, 3, 1));
      expect(data.to, DateTime(2024, 4, 1));
    });
  });
}
