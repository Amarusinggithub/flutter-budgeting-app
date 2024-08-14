import 'package:budgetingapp/models/transaction_model.dart';
import 'package:budgetingapp/services/tansaction_service.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../transaction_point.dart';

class TransactionProvider extends ChangeNotifier {
  List<TransactionModel>? transactions;
  final TransactionService transactionService;

  TransactionProvider({required this.transactionService}) {
    getTransactionFromDatabase();
  }

  void getTransactionFromDatabase() {
    if (transactionService.transactions.isNotEmpty) {
      transactions = transactionService.transactions;
    } else {
      transactions = [];
    }
  }

  void updateTransactionsInDatabase(List<TransactionModel> transactions) {
    transactionService.updateTransactionsInDatabase(transactions);
  }

  List<TransactionPoint> get transactionPoints {
    final data = <double>[5.0, 4.0, 10.0, 5.0];
    return data
        .mapIndexed(((index, element) =>
            TransactionPoint(x: index.toDouble(), y: element)))
        .toList();
  }
}
