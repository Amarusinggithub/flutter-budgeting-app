import 'package:budgetingapp/models/transaction_model.dart';
import 'package:budgetingapp/services/tansaction_service.dart';
import 'package:flutter/material.dart';

class TransactionProvider extends ChangeNotifier {
  List<TransactionModel>? transactions;
  final TransactionService transactionService;

  TransactionProvider({required this.transactionService}) {
    getTransactionFromDatabase();
  }

  void getTransactionFromDatabase() {
    if (transactionService.transactions!.isNotEmpty) {
      transactions = transactionService.transactions;
    } else {
      transactions = [];
    }
  }

  void updateTransactionsInDatabase(List<TransactionModel> transactions) {
    transactionService.updateTransactionsInDatabase(transactions);
  }
}
