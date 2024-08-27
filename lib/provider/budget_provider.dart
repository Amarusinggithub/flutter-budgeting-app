import 'package:budgetingapp/models/budget_history_model.dart';
import 'package:budgetingapp/models/budget_model.dart';
import 'package:budgetingapp/models/category_model.dart';
import 'package:budgetingapp/models/transaction_model.dart';
import 'package:budgetingapp/services/budget_service.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class BudgetProvider extends ChangeNotifier {
  BudgetModel? currentBudget;
  double totalBalanceModel = 0.0;
  BudgetHistoryModel? budgetHistoryModel;

  final BudgetService budgetService;
  List<CategoryModel> categories = [
    CategoryModel(
        id: "Housing", name: "Housing", totalSpent: 0, planToSpend: 0),
    CategoryModel(
        id: "Utilities", name: "Utilities", totalSpent: 0, planToSpend: 0),
    CategoryModel(
        id: "Transportation",
        name: "Transportation",
        totalSpent: 0,
        planToSpend: 0),
    CategoryModel(
        id: "Groceries", name: "Groceries", totalSpent: 0, planToSpend: 0),
    CategoryModel(
        id: "Entertainment",
        name: "Entertainment",
        totalSpent: 0,
        planToSpend: 0),
    CategoryModel(
        id: "Shopping", name: "Shopping", totalSpent: 0, planToSpend: 0),
    CategoryModel(id: "Salary", name: "Salary", totalSpent: 0, planToSpend: 0),
    CategoryModel(
        id: "Personal care",
        name: "Personal care",
        totalSpent: 0,
        planToSpend: 0)
  ];

  BudgetProvider({required this.budgetService}) {
    initializeBudgetData();
  }

  Future<void> initializeBudgetData() async {
    await getBudgetHistory();
    await getCurrentBudget();
    await getTotalBalance();
    notifyListeners();
  }

  Future<void> getBudgetHistory() async {
    final fetchedBudgetHistory = await budgetService.fetchBudgetsFromDatabase();

    if (fetchedBudgetHistory != null) {
      budgetHistoryModel = fetchedBudgetHistory;
    } else {
      budgetHistoryModel = BudgetHistoryModel(totalBalance: 0.0, budgets: []);
      await createNewBudget();
    }
  }

  Future<void> getCurrentBudget() async {
    if (budgetHistoryModel!.budgets.isNotEmpty) {
      currentBudget = budgetHistoryModel?.budgets.last;
    } else {
      await createNewBudget();
    }
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
    budgetHistoryModel?.budgets.add(newBudget);
    await updateTheBudgetHistoryInTheDatabase(budgetHistoryModel!);
  }

  Future<void> getTotalBalance() async {
    if (budgetHistoryModel != null) {
      totalBalanceModel = budgetHistoryModel!.totalBalance;
      if (kDebugMode) {
        print("Total Balance Fetched: $totalBalanceModel");
      } // Debugging statement
    }
    notifyListeners();
  }

  Future<void> updateTheBudgetHistoryInTheDatabase(
      BudgetHistoryModel budgets) async {
    if (currentBudget != null && budgetHistoryModel != null) {
      budgetHistoryModel!.budgets.last = currentBudget!;
      budgetHistoryModel?.totalBalance = totalBalanceModel;
      await budgetService.updateBudgetsInDatabase(budgets);
    }
  }

  void calculateSavings() {
    if (currentBudget != null) {
      currentBudget!.savings = currentBudget!.income - currentBudget!.expense;
      totalBalanceModel = (totalBalanceModel) + currentBudget!.savings;
      updateTheBudgetHistoryInTheDatabase(budgetHistoryModel!);
    }
  }

  void updateIncome(double newIncome) {
    if (currentBudget != null) {
      currentBudget!.income += newIncome;
      calculateSavings();
    }
  }

  void updateExpense() {
    if (currentBudget != null) {
      currentBudget!.categories.fold(
        0.0,
        (sum, category) => sum + category.totalSpent,
      );
    }
    notifyListeners();
  }

  void calculatePlanToSpend(double newExpense) {
    if (currentBudget != null) {
      currentBudget!.categories.fold(
        0.0,
        (sum, category) => sum + category.planToSpend,
      );
    }
    notifyListeners();
  }

  String numberCurrencyFormater(double number) {
    final formatCurrency = new NumberFormat.simpleCurrency();
    return formatCurrency.format(number);
  }

  double calculateTotalExpenseForTheMonth() {
    List<double> numbers = [];
    currentBudget?.categories.forEach((element) {
      numbers.add(element.totalSpent);
    });

    double num = numbers.fold(0, (sum, item) => sum + item);

    currentBudget?.expense = num;
    notifyListeners();
    return num;
  }

  void updateCategorySpentWithTransactionAmount(TransactionModel transaction) {
    for (int i = 0; i < categories.length; i++) {
      if (transaction.category == categories[i].id) {
        categories[i].totalSpent += transaction.amount;
        break;
      }
    }
    updateTheBudgetHistoryInTheDatabase(budgetHistoryModel!);
    notifyListeners();
  }
}
