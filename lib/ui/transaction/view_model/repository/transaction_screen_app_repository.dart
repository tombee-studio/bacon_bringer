import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/category_data.dart';
import 'package:bacon_bringer/data/transaction_data.dart';
import 'package:bacon_bringer/repository/transaction_screen_repository.dart';

class TransactionScreenAppRepository extends TransactionScreenRepository {
  @override
  Future<TransactionData> create(AccountData account, String purpose,
      double money, CategoryData category, DateTime transactionDate) async {
    return TransactionData(
        account: account,
        purpose: purpose,
        money: money,
        category: category,
        transactionDate: transactionDate);
  }
}
