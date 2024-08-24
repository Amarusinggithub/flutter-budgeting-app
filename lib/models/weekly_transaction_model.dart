import 'package:budgetingapp/models/transaction_model.dart';

class WeeklyTransactionModel {
  int weekNumber;
  List<TransactionModel> transactions;

  WeeklyTransactionModel({
    required this.weekNumber,
    required this.transactions,
  });

  double get totalAmount =>
      transactions.fold(0, (sum, item) => sum + item.amount);
}
