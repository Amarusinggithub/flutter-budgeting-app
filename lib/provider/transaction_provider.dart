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

  Future<void> editTransaction(TransactionModel transaction) async {
    final index = transactions.indexWhere((t) => t.date == transaction.date);
    if (index != -1) {
      transactions[index] = transaction;
      organizeTransactionsByDate();
      await updateTheTransactionsInTheDatabase();
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

  /*List<DailyTransactionModel> _groupByDay() {
    final now = DateTime.now();
    final currentYear = now.year;
    final currentMonth = now.month;

    // Create a map that will hold the grouped transactions
    final Map<DateTime, List<TransactionModel>> grouped = {};

    // Populate the map with all days of the current week that days that have passed month, even if no transactions exist
    for (int day = 1; day <= HelperFunctions.daysPassedInCurrentWeek(); day++) {
      final date = DateTime(currentYear, currentMonth, day);
      grouped[date] = []; // Initialize with an empty list
    }

    // Group existing transactions by day
    for (var transaction in transactions) {
      final date = DateTime.fromMillisecondsSinceEpoch(transaction.date);

      if (date.year == currentYear && date.month == currentMonth) {
        final dayKey = DateTime(date.year, date.month, date.day);
        grouped[dayKey]?.add(transaction);
      }
    }

    // Convert the map entries to the list of DailyTransactionModel
    return grouped.entries
        .map((entry) =>
            DailyTransactionModel(date: entry.key, transactions: entry.value))
        .toList();
  }
*/
  List<DailyTransactionModel> _groupByDay() {
    final now = DateTime.now();
    final currentYear = now.year;
    final currentMonth = now.month;

    // Get the current week of the month
    final currentWeek = HelperFunctions.getCurrentWeekOfMonth();

    // Get the first day of the current week
    final firstDayOfWeek = DateTime(currentYear, currentMonth, 1)
        .add(Duration(days: (currentWeek - 1) * 7));

    // Get the last day of the current week
    final lastDayOfWeek = firstDayOfWeek.add(const Duration(days: 6));

    // Create a map that will hold the grouped transactions for the current week
    final Map<DateTime, List<TransactionModel>> grouped = {};

    // Initialize the map with empty lists for each day of the current week
    for (int i = 0; i <= HelperFunctions.daysPassedInCurrentWeek(); i++) {
      final date = firstDayOfWeek.add(Duration(days: i));
      grouped[date] = [];
    }

    // Group existing transactions by day, but only for the current week
    for (var transaction in transactions) {
      final date = DateTime.fromMillisecondsSinceEpoch(transaction.date);

      // Only include transactions that fall within the current week
      if (date.isAfter(firstDayOfWeek.subtract(const Duration(days: 1))) &&
          date.isBefore(lastDayOfWeek.add(const Duration(days: 1)))) {
        final dayKey = DateTime(date.year, date.month, date.day);
        grouped[dayKey]?.add(transaction);
      }
    }

    // Convert the map entries to the list of DailyTransactionModel
    return grouped.entries
        .map((entry) =>
            DailyTransactionModel(date: entry.key, transactions: entry.value))
        .toList();
  }

  List<MonthlyTransactionModel> _groupByMonth() {
    final now = DateTime.now();
    final currentYear = now.year;

    // Create a map that will hold the grouped transactions
    final Map<DateTime, List<TransactionModel>> grouped = {};

    // Populate the map with all months of the current year, even if no transactions exist
    for (int month = 1; month <= now.month; month++) {
      final date = DateTime(currentYear, month); // Up to the current month
      grouped[date] = []; // Initialize with an empty list
    }

    // Group existing transactions by month within the current year
    for (var transaction in transactions) {
      final date = DateTime.fromMillisecondsSinceEpoch(transaction.date);

      // Only include transactions from the current year
      if (date.year == currentYear) {
        final monthKey = DateTime(date.year, date.month);
        grouped[monthKey]
            ?.add(transaction); // Add transaction to the appropriate month
      }
    }

    // Convert the map entries into a list of MonthlyTransactionModel
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

  // Adjust category spending when editing a transaction
  Future<void> adjustCategorySpending(TransactionModel originalTransaction,
      TransactionModel updatedTransaction) async {
    // Check if category or amount has changed
    if (originalTransaction.category != updatedTransaction.category) {
      // Decrease the spent amount from the original category
      await budgetProvider.decreaseCategorySpent(
          originalTransaction.category, originalTransaction.amount);

      // Increase the spent amount for the new category
      await budgetProvider.increaseCategorySpent(
          updatedTransaction.category, updatedTransaction.amount);
    } else if (originalTransaction.amount != updatedTransaction.amount) {
      // If only the amount changed within the same category, adjust the spent amount
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

    // Update the current budget accordingly
    await budgetProvider
        .updateCategorySpentWithTransactionAmount(updatedTransaction);
  }

  // Edit an existing transaction
  Future<void> edit_Transaction(TransactionModel updatedTransaction,
      TransactionModel originalTransaction) async {
    // Find the index of the original transaction
    final index =
        transactions.indexWhere((t) => t.date == originalTransaction.date);
    if (index != -1) {
      // Adjust category spending before updating
      await adjustCategorySpending(originalTransaction, updatedTransaction);

      // Update the transaction
      transactions[index] = updatedTransaction;
      organizeTransactionsByDate();
      await updateTheTransactionsInTheDatabase();
      notifyListeners();
    }
  }
}
