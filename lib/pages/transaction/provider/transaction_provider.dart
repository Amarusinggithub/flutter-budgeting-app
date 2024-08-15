import 'package:budgetingapp/models/transaction_model.dart';
import 'package:budgetingapp/services/tansaction_service.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../components/transaction_point.dart';

class TransactionProvider extends ChangeNotifier {
  List<TransactionModel>? transactions;
  final TransactionService transactionService;
  List<List<TransactionModel>> transactionsByDate = [];

  TransactionProvider({required this.transactionService}) {
    getTransactionFromDatabase();
    //updateTransactionsInDatabase(transactions);
  }

  void getTransactionFromDatabase() async {
    transactions = await transactionService.fetchTransactionsFromDatabase();
    if (transactions == null) {
      transactions = [];
      updateTransactionsInDatabase(transactions);
    }
    organizeTransactionsByDate();
    notifyListeners();
  }

  void updateTransactionsInDatabase(List<TransactionModel>? transactions) {
    transactionService.updateTransactionsInDatabase(transactions!);
    getTransactionFromDatabase();
  }

  List<dynamic>? getTransactionByDate(int index) {
    if (index < 0 || index >= transactionsByDate.length) {
      return null;
    }
    return transactionsByDate[index];
  }

  List<TransactionPoint> get transactionPoints {
    final data = <double>[5.0, 4.0, 10.0, 5.0];
    return data
        .mapIndexed((index, element) =>
            TransactionPoint(x: index.toDouble(), y: element))
        .toList();
  }

  void organizeTransactionsByDate() {
    if (transactions == null || transactions!.isEmpty) return;

    // Group transactions by date
    Map<int, List<TransactionModel>> grouped = {};
    for (var transaction in transactions!) {
      int date = DateTime.fromMillisecondsSinceEpoch(transaction.date)
          .millisecondsSinceEpoch;
      if (grouped.containsKey(date)) {
        grouped[date]!.add(transaction);
      } else {
        grouped[date] = [transaction];
      }
    }

    transactionsByDate = grouped.values.toList();
    notifyListeners();
  }

  DateTime currentDate() {
    notifyListeners();
    return DateTime.now();
  }
}
