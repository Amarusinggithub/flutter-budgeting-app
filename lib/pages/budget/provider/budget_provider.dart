import 'package:budgetingapp/models/budget_model.dart';
import 'package:budgetingapp/models/category_model.dart';
import 'package:budgetingapp/services/budget_service.dart';
import 'package:flutter/material.dart';

class BudgetProvider extends ChangeNotifier {
  BudgetModel? budget;
  CategoryModel? selectedCategory;

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
    BudgetModel? _budgetModel = await budgetService.fetchBudgetFromDatabase();
    if (budget == null && _budgetModel != null) {
      budget = _budgetModel;
      calculateSavings();
    } else {
      BudgetModel? budget = BudgetModel(
          availableBalance: 0,
          expense: 0,
          categories: categories,
          income: 0,
          savings: 0);
      calculateSavings();
      await updateTheBudgetInTheDatabase(budget);
    }
    notifyListeners();
  }

  Future<void> updateTheBudgetInTheDatabase(BudgetModel budget) async {
    await budgetService.updateBudgetInDatabase(budget);
    this.budget = budget;
    notifyListeners();
  }

  void calculateSavings() {
    if (budget != null) {
      budget!.savings = budget!.income - budget!.expense;
      budget!.availableBalance = budget!.availableBalance + budget!.savings;
      updateTheBudgetInTheDatabase(budget!);
    }
  }

  void selectCategory(CategoryModel category) {
    selectedCategory = category;
    notifyListeners();
  }
}
