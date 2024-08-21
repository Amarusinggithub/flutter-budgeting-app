import 'package:budgetingapp/models/transaction_for_the_day_model.dart';

class TransactionForTheWeekModel {
  double totalIncomeForTheWeek;
  double TotalExpenseForTHeWeek;
  List<TransactionForTheDay> week;

  TransactionForTheWeekModel(
      {required this.totalIncomeForTheWeek,
      required this.TotalExpenseForTHeWeek,
      required this.week});
}
