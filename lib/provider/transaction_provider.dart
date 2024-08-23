import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';

import '../models/transaction_model.dart';
import '../pages/transaction/components/transaction_point.dart';
import '../services/transaction_service.dart';

class TransactionProvider extends ChangeNotifier {
  int? selectedCategory;
  double? totalBalanceModel;
  List<List<TransactionModel>> transactionsByDate = [];
  String? transactionTitle;
  double? transactionAmount;
  int _selectedIndexForTransactionTime = 1;

  int get selectedIndexForTransactionTime => _selectedIndexForTransactionTime;
  TransactionService transactionService;
  List<TransactionModel> transactions = [];

  TransactionProvider({required this.transactionService}) {
    getTransactions();
  }

  Future<void> getTransactions() async {
    List<TransactionModel>? _transactions =
        await transactionService.fetchTransactionsFromDatabase();
    if (_transactions != null) {
      transactions = _transactions;
      organizeTransactionsByDate();
    } else {
      transactions = [];
      organizeTransactionsByDate();
      await transactionService.updateTransactionsInDatabase(transactions);
    }
    notifyListeners();
  }

  Future<void> updateTheTransactionsInTheDatabase(
      List<TransactionModel> transactions) async {
    await transactionService.updateTransactionsInDatabase(transactions);
  }

  Future<void> deleteTransaction(TransactionModel transaction) async {
    transactions.remove(transaction);
    await updateTheTransactionsInTheDatabase(transactions);
  }

  Future<void> editTransaction(TransactionModel transaction) async {
    final index = transactions.indexWhere((t) => t.title == transaction.title);
    if (index != -1) {
      transactions[index] = transaction;
      await updateTheTransactionsInTheDatabase(transactions);
    }
  }

  List<TransactionModel>? getTransactionByDate(int index) {
    if (index < 0 || index >= transactionsByDate.length) {
      return null;
    }
    return transactionsByDate[index];
  }

  List<TransactionPoint> get transactionPoints {
    if (transactions.isEmpty) return [];
    final data = transactions.map((transaction) => transaction.amount).toList();
    return data.isEmpty
        ? []
        : data
            .mapIndexed((index, element) =>
                TransactionPoint(x: index.toDouble(), y: element))
            .toList();
  }

  void organizeTransactionsByDate() {
    if (transactions.isEmpty) return;

    List<TransactionModel> reversedTransactions =
        List.from(transactions.reversed);

    transactionsByDate = reversedTransactions
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
    transactions.add(transaction);
    organizeTransactionsByDate();
    await updateTheTransactionsInTheDatabase(transactions);
    notifyListeners();
    print("Transaction added: ${transaction.title}, ${transaction.amount}");
  }

  void updateTransactionTitle(String title) {
    transactionTitle = title;
    notifyListeners();
  }

  void updateTransactionAmount(double amount) {
    transactionAmount = amount;
    notifyListeners();
  }

  void selectCategory(int categoryIndex) {
    selectedCategory = categoryIndex;
    notifyListeners();
  }

  void clearTransactionInputs() {
    transactionTitle = null;
    transactionAmount = null;
    selectedCategory = null;
    notifyListeners();
  }

  void setSelectedIndexForTransactionTime(int index) {
    _selectedIndexForTransactionTime = index;
    notifyListeners();
  }
}
