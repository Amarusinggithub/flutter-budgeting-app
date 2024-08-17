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
  }

  Future<void> getTransactionFromDatabase() async {
    List<TransactionModel> _transactions =
        await transactionService.fetchTransactionsFromDatabase();

    if (transactions == null) {
      transactions = _transactions;
    } else {
      transactions = [];

      await updateTransactionsInDatabase(transactions!);
    }
    organizeTransactionsByDate();
    notifyListeners();
  }

  Future<void> updateTransactionsInDatabase(
      List<TransactionModel> transactions) async {
    try {
      await transactionService.updateTransactionsInDatabase(transactions);
      this.transactions = transactions;
      organizeTransactionsByDate();
      notifyListeners();
    } catch (e) {
      print("Error updating transactions: $e");
    }
  }

  List<TransactionModel>? getTransactionByDate(int index) {
    if (index < 0 || index >= transactionsByDate.length) {
      return null;
    }
    return transactionsByDate[index];
  }

  List<TransactionPoint> get transactionPoints {
    final data = transactions?.map((t) => t.amount).toList() ?? [0.0];
    return data
        .mapIndexed((index, element) =>
            TransactionPoint(x: index.toDouble(), y: element))
        .toList();
  }

  void organizeTransactionsByDate() {
    if (transactions == null || transactions!.isEmpty) return;

    // Group transactions by date (ignoring time)
    transactionsByDate = transactions!
        .groupListsBy((transaction) =>
            DateTime.fromMillisecondsSinceEpoch(transaction.date)
                .toLocal()
                .toIso8601String()
                .substring(0, 10))
        .values
        .toList();
  }

  DateTime currentDate() {
    return DateTime.now();
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    transactions!.add(transaction);
    await updateTransactionsInDatabase(transactions!);
    notifyListeners();
  }
}
