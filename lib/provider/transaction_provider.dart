import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';

import '../models/daily_transaction_model.dart';
import '../models/monthly_transaction_model.dart';
import '../models/transaction_model.dart';
import '../models/weekly_transaction_model.dart';
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

  List<TransactionPoint> getTransactionPoints(
      int selectedIndexForTransactionTime) {
    switch (selectedIndexForTransactionTime) {
      case 0:
        return _groupByDay().mapIndexed((index, dailyModel) {
          return TransactionPoint(
              x: index.toDouble(), y: dailyModel.totalAmount);
        }).toList();
      case 1:
        return _groupByWeek().mapIndexed((index, weeklyModel) {
          return TransactionPoint(
              x: index.toDouble(), y: weeklyModel.totalAmount);
        }).toList();
      case 2:
        return _groupByMonth().mapIndexed((index, monthlyModel) {
          return TransactionPoint(
              x: index.toDouble(), y: monthlyModel.totalAmount);
        }).toList();
      default:
        return [];
    }
  }

  List<DailyTransactionModel> _groupByDay() {
    final DateTime now = DateTime.now();
    final int currentYear = now.year;
    final int currentMonth = now.month;

    final Map<DateTime, List<TransactionModel>> grouped =
        transactions.where((transaction) {
      final transactionDate =
          DateTime.fromMillisecondsSinceEpoch(transaction.date);
      return transactionDate.year == currentYear &&
          transactionDate.month == currentMonth;
    }).groupListsBy(
      (transaction) => DateTime(
        DateTime.fromMillisecondsSinceEpoch(transaction.date).year,
        DateTime.fromMillisecondsSinceEpoch(transaction.date).month,
        DateTime.fromMillisecondsSinceEpoch(transaction.date).day,
      ),
    );

    return grouped.entries.map((entry) {
      return DailyTransactionModel(date: entry.key, transactions: entry.value);
    }).toList();
  }

  List<WeeklyTransactionModel> _groupByWeek() {
    final DateTime now = DateTime.now();
    final int currentYear = now.year;
    final int currentMonth = now.month;

    final Map<int, List<TransactionModel>> grouped =
        transactions.where((transaction) {
      final transactionDate =
          DateTime.fromMillisecondsSinceEpoch(transaction.date);
      return transactionDate.year == currentYear &&
          transactionDate.month == currentMonth;
    }).groupListsBy(
      (transaction) =>
          _weekOfYear(DateTime.fromMillisecondsSinceEpoch(transaction.date)),
    );

    return grouped.entries.map((entry) {
      return WeeklyTransactionModel(
          weekNumber: entry.key, transactions: entry.value);
    }).toList();
  }

  List<MonthlyTransactionModel> _groupByMonth() {
    final DateTime now = DateTime.now();
    final int currentYear = now.year;

    final Map<int, List<TransactionModel>> grouped =
        transactions.where((transaction) {
      final transactionDate =
          DateTime.fromMillisecondsSinceEpoch(transaction.date);
      return transactionDate.year == currentYear;
    }).groupListsBy(
      (transaction) =>
          DateTime.fromMillisecondsSinceEpoch(transaction.date).month,
    );

    return grouped.entries.map((entry) {
      return MonthlyTransactionModel(
          month: entry.key, transactions: entry.value);
    }).toList();
  }

  int _weekOfYear(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final daysDifference = date.difference(firstDayOfYear).inDays;
    return (daysDifference / 7).ceil();
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

  Future<void> addTransaction(TransactionModel transaction) async {
    transactions.add(transaction);
    organizeTransactionsByDate();
    await updateTheTransactionsInTheDatabase(transactions);
    notifyListeners();
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
