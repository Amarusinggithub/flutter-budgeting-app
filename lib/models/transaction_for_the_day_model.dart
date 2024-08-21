import 'package:budgetingapp/models/transaction_model.dart';

class TransactionForTheDay {
  int day;
  double totalExpense;
  double income;
  List<TransactionModel> transactions;

  TransactionForTheDay(
      {required this.day,
      required this.transactions,
      required this.income,
      required this.totalExpense});
}
