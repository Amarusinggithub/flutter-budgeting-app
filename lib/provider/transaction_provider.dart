import 'package:budgetingapp/provider/budget_provider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

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
  int _selectedIndexForTransactionTime = 0;
  final BudgetProvider budgetProvider;
  final TransactionService transactionService;
  List<TransactionModel> transactions = [];

  TransactionProvider({
    required this.budgetProvider,
    required this.transactionService,
  }) {
    getTransactions();
  }

  int get selectedIndexForTransactionTime => _selectedIndexForTransactionTime;

  Future<void> getTransactions() async {
    final fetchedTransactions =
        await transactionService.fetchTransactionsFromDatabase();

    if (fetchedTransactions != null) {
      final now = DateTime.now();
      final currentMonth = now.month;
      final currentYear = now.year;

      transactions = fetchedTransactions.where((transaction) {
        final transactionDate =
            DateTime.fromMillisecondsSinceEpoch(transaction.date);
        return transactionDate.month == currentMonth &&
            transactionDate.year == currentYear;
      }).toList();

      organizeTransactionsByDate();
    } else {
      transactions = [];
      organizeTransactionsByDate();
      await transactionService.updateTransactionsInDatabase(transactions);
    }

    notifyListeners();
  }

  Future<void> updateTheTransactionsInTheDatabase(
      List<TransactionModel> updatedTransactions) async {
    await transactionService.updateTransactionsInDatabase(updatedTransactions);
  }

  Future<void> deleteTransaction(TransactionModel transaction) async {
    transactions.remove(transaction);
    organizeTransactionsByDate();
    await updateTheTransactionsInTheDatabase(transactions);
    notifyListeners();
  }

  Future<void> editTransaction(TransactionModel transaction) async {
    final index = transactions.indexWhere((t) => t.date == transaction.date);
    if (index != -1) {
      transactions[index] = transaction;
      organizeTransactionsByDate();
      await updateTheTransactionsInTheDatabase(transactions);
      notifyListeners();
    }
  }

  List<TransactionModel>? getTransactionByDate(int index) {
    if (index < 0 || index >= transactionsByDate.length) {
      return null;
    }
    return transactionsByDate[index];
  }

  List<TransactionPoint> getTransactionPoints(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return _groupByDay()
            .mapIndexed((index, dailyModel) => TransactionPoint(
                  x: index.toDouble(),
                  y: dailyModel.totalAmount,
                ))
            .toList();
      case 1:
        return _groupByWeek()
            .mapIndexed((index, weeklyModel) => TransactionPoint(
                  x: index.toDouble(),
                  y: weeklyModel.totalAmount,
                ))
            .toList();
      case 2:
        return _groupByMonth()
            .mapIndexed((index, monthlyModel) => TransactionPoint(
                  x: index.toDouble(),
                  y: monthlyModel.totalAmount,
                ))
            .toList();
      default:
        return [];
    }
  }

  List<DailyTransactionModel> _groupByDay() {
    final now = DateTime.now();
    final currentYear = now.year;
    final currentMonth = now.month;

    final grouped = transactions.where((transaction) {
      final date = DateTime.fromMillisecondsSinceEpoch(transaction.date);
      return date.year == currentYear && date.month == currentMonth;
    }).groupListsBy(
      (transaction) {
        final date = DateTime.fromMillisecondsSinceEpoch(transaction.date);
        return DateTime(date.year, date.month, date.day);
      },
    );

    return grouped.entries
        .map((entry) =>
            DailyTransactionModel(date: entry.key, transactions: entry.value))
        .toList();
  }

  List<WeeklyTransactionModel> _groupByWeek() {
    final now = DateTime.now();
    final currentYear = now.year;
    final currentMonth = now.month;

    final grouped = transactions.where((transaction) {
      final date = DateTime.fromMillisecondsSinceEpoch(transaction.date);
      return date.year == currentYear && date.month == currentMonth;
    }).groupListsBy(
      (transaction) =>
          _weekOfYear(DateTime.fromMillisecondsSinceEpoch(transaction.date)),
    );

    return grouped.entries
        .map((entry) => WeeklyTransactionModel(
            weekNumber: entry.key, transactions: entry.value))
        .toList();
  }

  List<MonthlyTransactionModel> _groupByMonth() {
    final now = DateTime.now();
    final currentYear = now.year;

    final grouped = transactions.where((transaction) {
      final date = DateTime.fromMillisecondsSinceEpoch(transaction.date);
      return date.year == currentYear;
    }).groupListsBy(
      (transaction) =>
          DateTime.fromMillisecondsSinceEpoch(transaction.date).month,
    );

    return grouped.entries
        .map((entry) => MonthlyTransactionModel(
            month: entry.key, transactions: entry.value))
        .toList();
  }

  int _weekOfYear(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final daysDifference = date.difference(firstDayOfYear).inDays;
    return ((daysDifference + firstDayOfYear.weekday) / 7).ceil();
  }

  void organizeTransactionsByDate() {
    if (transactions.isEmpty) {
      transactionsByDate = [];
    } else {
      final reversedTransactions =
          List<TransactionModel>.from(transactions.reversed);
      transactionsByDate = reversedTransactions
          .groupListsBy((transaction) =>
              DateTime.fromMillisecondsSinceEpoch(transaction.date)
                  .toLocal()
                  .toIso8601String()
                  .substring(0, 10))
          .values
          .toList();
    }
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    transactions.add(transaction);
    organizeTransactionsByDate();
    await updateTheTransactionsInTheDatabase(transactions);

    await budgetProvider.updateCategorySpentWithTransactionAmount(transaction);
  }

  void updateTransactionTitle(String title) {
    if (transactionTitle != title) {
      transactionTitle = title;
      notifyListeners();
    }
  }

  void updateTransactionAmount(double amount) {
    if (transactionAmount != amount) {
      transactionAmount = amount;
      notifyListeners();
    }
  }

  void selectCategory(int categoryIndex) {
    if (selectedCategory != categoryIndex) {
      selectedCategory = categoryIndex;
      notifyListeners();
    }
  }

  void clearTransactionInputs() {
    transactionTitle = null;
    transactionAmount = null;
    selectedCategory = null;
    notifyListeners();
  }

  void setSelectedIndexForTransactionTime(int index) {
    if (_selectedIndexForTransactionTime != index) {
      _selectedIndexForTransactionTime = index;
      notifyListeners();
    }
  }
}
