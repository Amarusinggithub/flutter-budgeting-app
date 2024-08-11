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
    CategoryModel(id: "Savings", name: "Savings", icon: "", totalSpent: 0),
    CategoryModel(id: "Healthcare", name: "Healthcare", icon: "", totalSpent: 0)
  ];

  BudgetProvider({required this.budgetService}) {
    makeOrFetchBudget();
  }

  void makeOrFetchBudget() {
    if (budget == null && budgetService.budget != null) {
      budget = budgetService.budget;
    } else {
      budget = BudgetModel(
          totalAmount: 0, spentAmount: 0, categories: categories, income: 0);
    }
    notifyListeners();
  }

  void updateTheBudgetInTheDatabase() {
    budgetService.updateBudgetInDatabase(budget!);
    notifyListeners();
  }
}
