import 'package:budgetingapp/models/budget_history_model.dart';
import 'package:budgetingapp/models/budget_model.dart';
import 'package:budgetingapp/models/category_model.dart';
import 'package:budgetingapp/services/budget_service.dart';
import 'package:flutter/material.dart';

class BudgetProvider extends ChangeNotifier {
  BudgetModel? currentBudget;
  double? totalBalanceModel;
  BudgetHistoryModel? budgetHistoryModel;

  final BudgetService budgetService;
  List<CategoryModel> categories = [
    CategoryModel(id: "Housing", name: "Housing", totalSpent: 0),
    CategoryModel(id: "Utilities", name: "Utilities", totalSpent: 0),
    CategoryModel(id: "Transportation", name: "Transportation", totalSpent: 0),
    CategoryModel(id: "Groceries", name: "Groceries", totalSpent: 0),
    CategoryModel(id: "Entertainment", name: "Entertainment", totalSpent: 0),
    CategoryModel(id: "Shopping", name: "Shopping", totalSpent: 0),
    CategoryModel(id: "Salary", name: "Salary", totalSpent: 0),
    CategoryModel(id: "Healthcare", name: "Healthcare", totalSpent: 0)
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
      date: DateTime.now().millisecondsSinceEpoch,
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
}
