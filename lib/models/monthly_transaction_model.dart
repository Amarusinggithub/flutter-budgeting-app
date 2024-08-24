import 'package:budgetingapp/models/transaction_model.dart';

class MonthlyTransactionModel {
  int month;
  List<TransactionModel> transactions;

  MonthlyTransactionModel({
    required this.month,
    required this.transactions,
  });

  double get totalAmount =>
      transactions.fold(0, (sum, item) => sum + item.amount);
}
