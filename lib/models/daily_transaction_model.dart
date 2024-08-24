import 'package:budgetingapp/models/transaction_model.dart';

class DailyTransactionModel {
  DateTime date;
  List<TransactionModel> transactions;

  DailyTransactionModel({
    required this.date,
    required this.transactions,
  });

  double get totalAmount =>
      transactions.fold(0, (sum, item) => sum + item.amount);
}
