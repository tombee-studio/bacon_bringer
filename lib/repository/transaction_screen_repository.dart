import 'package:bacon_bringer/bases/repository.dart';
import 'package:bacon_bringer/data/account_data.dart';
import 'package:bacon_bringer/data/category_data.dart';
import 'package:bacon_bringer/data/transaction_data.dart';

abstract class TransactionScreenRepository extends Repository {
  Future<TransactionData> create(AccountData account, String purpose,
      double money, CategoryData category, DateTime transactionDate);
}
