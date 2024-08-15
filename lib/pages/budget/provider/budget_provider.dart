import 'package:budgetingapp/models/budget_model.dart';
import 'package:budgetingapp/models/category_model.dart';
import 'package:budgetingapp/services/budget_service.dart';
import 'package:flutter/material.dart';

class BudgetProvider extends ChangeNotifier {
  BudgetModel? budget;
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
    makeOrFetchBudget();
  }

  Future<void> makeOrFetchBudget() async {
    // budget = await budgetService.fetchBudgetFromDatabase();

    budget = BudgetModel(
        availableBalance: 0, expense: 0, categories: categories, income: 0);
    addBudgetInTheDatabase(budget!);

    notifyListeners();
  }

  void updateTheBudgetInTheDatabase(BudgetModel budget) {
    budgetService.updateBudgetInDatabase(budget);
    makeOrFetchBudget();
    notifyListeners();
  }

  void addBudgetInTheDatabase(BudgetModel budgetModel) {
    budgetService.addBudgetToDatabase(budget!);
    makeOrFetchBudget();
    notifyListeners();
  }
}
