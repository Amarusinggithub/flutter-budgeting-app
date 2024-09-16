import 'package:budgetingapp/core/utils/helper_functions.dart';
import 'package:budgetingapp/provider/budget_provider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../models/daily_transaction_model.dart';
import '../models/monthly_transaction_model.dart';
import '../models/transaction_model.dart';
import '../models/weekly_transaction_model.dart';
import '../pages/transaction/components/transaction_point.dart';
import '../services/transaction_service.dart';

class TransactionProvider extends ChangeNotifier {
  int? selectedCategory;
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
      await createTransactions();
    }

    notifyListeners();
  }

  Future<void> createTransactions() async {
    List<TransactionModel> newTRransactions = [];
    transactions = newTRransactions;
    if (kDebugMode) {
      print("Created new transactions: ${transactions.length}");
    }
    notifyListeners();
  }

  Future<void> updateTheTransactionsInTheDatabase() async {
    await transactionService.updateTransactionsInDatabase(transactions);
  }

  Future<void> deleteTransaction(TransactionModel transaction) async {
    transactions.remove(transaction);
    organizeTransactionsByDate();
    await updateTheTransactionsInTheDatabase();
    notifyListeners();
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

    final currentWeek = HelperFunctions.getCurrentWeekOfMonth();

    final firstDayOfWeek = DateTime(currentYear, currentMonth, 1)
        .add(Duration(days: (currentWeek - 1) * 7));

    final lastDayOfWeek = firstDayOfWeek.add(const Duration(days: 6));

    final Map<DateTime, List<TransactionModel>> grouped = {};

    for (int i = 0; i <= HelperFunctions.daysPassedInCurrentWeek(); i++) {
      final date = firstDayOfWeek.add(Duration(days: i));
      grouped[date] = [];
    }

    for (var transaction in transactions) {
      final date = DateTime.fromMillisecondsSinceEpoch(transaction.date);

      if (date.isAfter(firstDayOfWeek.subtract(const Duration(days: 1))) &&
          date.isBefore(lastDayOfWeek.add(const Duration(days: 1)))) {
        final dayKey = DateTime(date.year, date.month, date.day);
        grouped[dayKey]?.add(transaction);
      }
    }

    return grouped.entries
        .map((entry) =>
            DailyTransactionModel(date: entry.key, transactions: entry.value))
        .toList();
  }

  List<MonthlyTransactionModel> _groupByMonth() {
    final now = DateTime.now();
    final currentYear = now.year;

    final Map<DateTime, List<TransactionModel>> grouped = {};

    for (int month = 1; month <= now.month; month++) {
      final date = DateTime(currentYear, month);
      grouped[date] = [];
    }

    for (var transaction in transactions) {
      final date = DateTime.fromMillisecondsSinceEpoch(transaction.date);

      if (date.year == currentYear) {
        final monthKey = DateTime(date.year, date.month);
        grouped[monthKey]?.add(transaction);
      }
    }

    return grouped.entries
        .map((entry) => MonthlyTransactionModel(
              month: entry.key,
              transactions: entry.value,
            ))
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
      (transaction) => HelperFunctions.weekOfMonth(
          DateTime.fromMillisecondsSinceEpoch(transaction.date)),
    );

    return grouped.entries
        .where((entry) => entry.value.isNotEmpty)
        .map((entry) => WeeklyTransactionModel(
            weekNumber: entry.key, transactions: entry.value))
        .toList();
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

    await budgetProvider.updateCategorySpentWithTransactionAmount(transaction);
    await budgetProvider
        .checkIfOverSpendTheBudgetForTransactionCategory(transaction.category);
    await updateTheTransactionsInTheDatabase();
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

  Future<void> adjustCategorySpending(TransactionModel originalTransaction,
      TransactionModel updatedTransaction) async {
    if (originalTransaction.category != updatedTransaction.category) {
      await budgetProvider.decreaseCategorySpent(
          originalTransaction.category, originalTransaction.amount);

      await budgetProvider.increaseCategorySpent(
          updatedTransaction.category, updatedTransaction.amount);
    } else if (originalTransaction.amount != updatedTransaction.amount) {
      double difference =
          updatedTransaction.amount - originalTransaction.amount;

      if (difference > 0) {
        await budgetProvider.increaseCategorySpent(
            updatedTransaction.category, difference);
      } else {
        await budgetProvider.decreaseCategorySpent(
            updatedTransaction.category, difference.abs());
      }
    }

    await budgetProvider
        .updateCategorySpentWithTransactionAmount(updatedTransaction);
  }

  Future<void> editTransaction(TransactionModel updatedTransaction,
      TransactionModel originalTransaction) async {
    final index =
        transactions.indexWhere((t) => t.date == originalTransaction.date);
    if (index != -1) {
      await adjustCategorySpending(originalTransaction, updatedTransaction);

      transactions[index] = updatedTransaction;

      organizeTransactionsByDate();

      budgetProvider.calculateTotalExpenseForTheMonth();

      await updateTheTransactionsInTheDatabase();

      notifyListeners();
    }
  }
}
