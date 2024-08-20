import 'package:budgetingapp/models/budget_history_model.dart';
import 'package:budgetingapp/models/budget_model.dart';
import 'package:budgetingapp/models/category_model.dart';
import 'package:budgetingapp/services/budget_service.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../models/transaction_model.dart';
import '../../transaction/components/transaction_point.dart';

class BudgetProvider extends ChangeNotifier {
  BudgetModel? currentBudget;
  int? selectedCategory;
  double? totalBalanceModel;
  BudgetHistoryModel? budgetHistoryModel;
  List<List<TransactionModel>> transactionsByDate = [];
  String? transactionTitle;
  double? transactionAmount;

  final BudgetService budgetService;
  List<CategoryModel> categories = [
    CategoryModel(id: "Housing", name: "Housing", icon: "", totalSpent: 0),
    CategoryModel(id: "Utilities", name: "Utilities", icon: "", totalSpent: 0),
    CategoryModel(
        id: "Transportation", name: "Transportation", icon: "", totalSpent: 0),
    CategoryModel(id: "Groceries", name: "Groceries", icon: "", totalSpent: 0),
    CategoryModel(
        id: "Entertainment", name: "Entertainment", icon: "", totalSpent: 0),
    CategoryModel(id: "Shopping", name: "Shopping", icon: "", totalSpent: 0),
    CategoryModel(id: "Salary", name: "Salary", icon: "", totalSpent: 0),
    CategoryModel(id: "Healthcare", name: "Healthcare", icon: "", totalSpent: 0)
  ];

  BudgetProvider({required this.budgetService}) {
    initializeBudgetData();
  }

  Future<void> initializeBudgetData() async {
    await getBudgetHistory();
    await getTotalBalance();

    notifyListeners();
  }

  Future<void> getBudgetHistory() async {
    BudgetHistoryModel? _budgetHistoryModel =
        await budgetService.fetchBudgetsFromDatabase();

    if (_budgetHistoryModel != null) {
      budgetHistoryModel = _budgetHistoryModel;
      await getCurrentBudget();
    } else {
      budgetHistoryModel = BudgetHistoryModel(totalBalance: 0, budgets: []);
      await createNewBudget();
    }

    notifyListeners();
  }

  Future<void> getCurrentBudget() async {
    if (budgetHistoryModel != null && budgetHistoryModel!.budgets.isNotEmpty) {
      currentBudget = budgetHistoryModel!.budgets.last;
      calculateSavings();
      organizeTransactionsByDate();
    } else {
      await createNewBudget();
    }
    notifyListeners();
  }

  Future<void> createNewBudget() async {
    BudgetModel newBudget = BudgetModel(
      income: 0,
      expense: 0,
      categories: categories,
      savings: 0,
      transactions: [],
    );
    currentBudget = newBudget;
    budgetHistoryModel!.budgets.add(newBudget);
    await updateTheBudgetInTheDatabase(budgetHistoryModel!);
  }

  Future<void> getTotalBalance() async {
    if (budgetHistoryModel != null && totalBalanceModel == null) {
      totalBalanceModel = budgetHistoryModel?.totalBalance;
    } else if (totalBalanceModel == null) {
      totalBalanceModel = 0;
      await updateTotalBalanceInTheDatabase(totalBalanceModel!);
    }
    notifyListeners();
  }

  Future<void> updateTheBudgetInTheDatabase(BudgetHistoryModel budgets) async {
    if (currentBudget != null && budgetHistoryModel != null) {
      budgetHistoryModel!.budgets.last = currentBudget!;
      await budgetService.updateBudgetsInDatabase(budgets);
    }
  }

  Future<void> updateTotalBalanceInTheDatabase(double totalBalance) async {
    budgetHistoryModel?.totalBalance = totalBalance;
    await updateTheBudgetInTheDatabase(budgetHistoryModel!);
    notifyListeners();
  }

  void calculateSavings() {
    if (currentBudget != null && totalBalanceModel != null) {
      currentBudget!.savings = currentBudget!.income - currentBudget!.expense;
      totalBalanceModel = (totalBalanceModel ?? 0) + currentBudget!.savings;
      updateTheBudgetInTheDatabase(budgetHistoryModel!);
    }
  }

  void updateIncome(double newIncome) {
    if (currentBudget != null) {
      currentBudget!.income += newIncome;
      calculateSavings();
    }
  }

  void updateExpense(double newExpense) {
    if (currentBudget != null) {
      currentBudget!.expense += newExpense;
      calculateSavings();
    }
  }

  Future<void> deleteTransaction(TransactionModel transaction) async {
    if (currentBudget != null) {
      currentBudget!.transactions.remove(transaction);
      await updateTheBudgetInTheDatabase(budgetHistoryModel!);
    }
  }

  Future<void> editTransaction(TransactionModel transaction) async {
    if (currentBudget != null) {
      final index = currentBudget!.transactions
          .indexWhere((t) => t.title == transaction.title);
      if (index != -1) {
        currentBudget!.transactions[index] = transaction;
        await updateTheBudgetInTheDatabase(budgetHistoryModel!);
      }
    }
  }

  List<TransactionModel>? getTransactionByDate(int index) {
    if (index < 0 || index >= transactionsByDate.length) {
      return null;
    }
    return transactionsByDate[index];
  }

  List<TransactionPoint> get transactionPoints {
    if (currentBudget == null) return [];
    final data = currentBudget!.transactions.map((t) => t.amount).toList();
    return data.isEmpty
        ? []
        : data
            .mapIndexed((index, element) =>
                TransactionPoint(x: index.toDouble(), y: element))
            .toList();
  }

  void organizeTransactionsByDate() {
    if (currentBudget?.transactions == null ||
        currentBudget!.transactions.isEmpty) return;

    transactionsByDate = currentBudget!.transactions
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
    if (currentBudget != null) {
      currentBudget!.transactions.add(transaction);
      organizeTransactionsByDate();
      await updateTheBudgetInTheDatabase(budgetHistoryModel!);
      notifyListeners();
      print("Transaction added: ${transaction.title}, ${transaction.amount}");
    } else {
      print("No current budget available");
    }
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
}
