import 'package:budgetingapp/core/utils/helper_functions.dart';
import 'package:budgetingapp/models/budget_history_model.dart';
import 'package:budgetingapp/models/budget_model.dart';
import 'package:budgetingapp/models/transaction_model.dart';
import 'package:budgetingapp/services/budget_service.dart';
import 'package:flutter/foundation.dart';

class BudgetProvider extends ChangeNotifier {
  double userIncomeInput = 0;
  bool isTotalBalanceVisible = true;
  BudgetModel? currentBudget;
  double? totalBalance;
  BudgetHistoryModel? budgetHistoryModel;

  final BudgetService budgetService;

  bool didSavingsAddAlready = false;

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
      totalBalance = budgetHistoryModel?.totalBalance;
      notifyListeners();
    } else {
      await createNewBudgetHistoryModel();
    }
  }

  Future<void> createNewBudgetHistoryModel() async {
    BudgetHistoryModel newBudgetHistoryModel =
        BudgetHistoryModel(totalBalance: 0.0, budgets: []);
    budgetHistoryModel = newBudgetHistoryModel;
    totalBalance = budgetHistoryModel?.totalBalance;
    if (kDebugMode) {
      print(
          "Created new BudgetHistoryModel: ${budgetHistoryModel?.totalBalance}");
    }
    await createNewBudget();
    notifyListeners();
  }

  Future<void> getCurrentBudget() async {
    if (budgetHistoryModel!.budgets.isNotEmpty) {
      currentBudget = findBudgetForCurrentMonth();

      if (HelperFunctions.isEndOfMonthAndDay() && !didSavingsAddAlready) {
        calculateSavings();
      }
    } else {
      await createNewBudget();
    }

    if (HelperFunctions.isStartOfMonth()) {
      didSavingsAddAlready = false;
    }
    notifyListeners();
  }

  BudgetModel? findBudgetForCurrentMonth() {
    DateTime now = DateTime.now();
    BudgetModel? foundBudget;
    for (BudgetModel budget in budgetHistoryModel!.budgets) {
      DateTime budgetDate = DateTime.fromMillisecondsSinceEpoch(budget.date);
      if (budgetDate.year == now.year && budgetDate.month == now.month) {
        foundBudget = budget;
        break;
      }
    }

    if (foundBudget == null) {
      createNewBudget();
    }
    notifyListeners();

    return foundBudget;
  }

  Future<void> createNewBudget() async {
    BudgetModel newBudget = BudgetModel(
      income: 0,
      expense: 0,
      savings: 0,
      date: DateTime.now().millisecondsSinceEpoch,
      planToSpend: 0,
    );
    currentBudget = newBudget;
    budgetHistoryModel?.budgets.add(newBudget);
    notifyListeners();
  }

  Future<void> getTotalBalance() async {
    if (budgetHistoryModel != null) {
      totalBalance = budgetHistoryModel?.totalBalance;
    } else {
      totalBalance = 0.0;
      budgetHistoryModel?.totalBalance = totalBalance!;
    }
    notifyListeners();
  }

  Future<void> updateTheBudgetHistoryInTheDatabase() async {
    if (currentBudget != null && budgetHistoryModel != null) {
      if (HelperFunctions.isEndOfMonthAndDay() && !didSavingsAddAlready) {
        calculateSavings();
      }

      budgetHistoryModel!.budgets.last = currentBudget!;
      budgetHistoryModel?.totalBalance = totalBalance!;

      await budgetService.updateBudgetsInDatabase(budgetHistoryModel!);
    }
  }

  Future<void> updateCategorySpentWithTransactionAmount(
      TransactionModel transaction) async {
    if (currentBudget != null) {
      for (int i = 0; i < currentBudget!.categories.length; i++) {
        if (transaction.category == currentBudget?.categories[i].id) {
          currentBudget!.categories[i].totalSpent += transaction.amount;
          break;
        }
      }
      calculateTotalExpenseForTheMonth();
      await updateTheBudgetHistoryInTheDatabase();
    }
    notifyListeners();
  }

  void addNewIncome() {
    if (currentBudget != null) {
      currentBudget!.income += userIncomeInput;
    }
    notifyListeners();
  }

  void editIncome() {
    if (currentBudget != null) {
      currentBudget!.income = userIncomeInput;
    }
    notifyListeners();
  }

  void calculateSavings() {
    if (currentBudget != null) {
      currentBudget!.savings = currentBudget!.income - currentBudget!.expense;
      totalBalance = (totalBalance ?? 0) + currentBudget!.savings;
    }
    didSavingsAddAlready = true;
    notifyListeners();
  }

  void calculateTotalExpenseForTheMonth() {
    double totalExpense = 0.0;
    if (currentBudget != null) {
      totalExpense = currentBudget!.categories.fold(
        0.0,
        (sum, category) => sum + category.totalSpent,
      );
      currentBudget?.expense = totalExpense;
    }
    notifyListeners();
  }

  void calculatePlanToSpend() {
    if (currentBudget == null || currentBudget!.categories.isEmpty) {
      currentBudget?.planToSpend = 0;
      return;
    }

    double totalPlanToSpend = 0.0;

    for (var category in currentBudget!.categories) {
      if (kDebugMode) {
        print(
            'Category ${category.name}: PlanToSpend = ${category.planToSpend}');
      }
      totalPlanToSpend += category.planToSpend;
    }

    currentBudget?.planToSpend = totalPlanToSpend;
    if (kDebugMode) {
      print('Total PlanToSpend = $totalPlanToSpend');
    }
    notifyListeners();
  }

  int calculatePercentageOfTotalPlanToSpend(double num) {
    if (currentBudget!.planToSpend == 0) {
      return 0;
    }
    return ((num / currentBudget!.planToSpend) * 100).round();
  }

  double? calculateTheBudgetPercentageForIndicator() {
    if (currentBudget != null && currentBudget!.planToSpend != 0) {
      double percentage =
          (currentBudget!.expense / currentBudget!.planToSpend) * 100;
      double result = (percentage / 100) * 330;
      return result;
    }
    return null;
  }

  int? calculateTheBudgetPercentage() {
    if (currentBudget != null && currentBudget!.planToSpend != 0) {
      int percentage =
          ((currentBudget!.expense / currentBudget!.planToSpend) * 100).toInt();
      return percentage;
    }
    return null;
  }

  double getCategoryPlanToSpend(String categoryName) {
    if (currentBudget == null) return 0;

    final category =
        currentBudget!.categories.firstWhere((c) => c.name == categoryName);
    return category.planToSpend;
  }

  void makeTotalBalanceVisible() {
    isTotalBalanceVisible = !isTotalBalanceVisible;
    notifyListeners();
  }

  void makeScreenRebuild() {
    notifyListeners();
  }

  // Adjusts to increase the spent amount for a category
  Future<void> increaseCategorySpent(String categoryName, double amount) async {
    final category = currentBudget?.categories
        .firstWhere((category) => category.name == categoryName);

    if (category != null) {
      category.totalSpent += amount;
      await updateTheBudgetHistoryInTheDatabase();
      notifyListeners();
    }
  }

  // Adjusts to decrease the spent amount for a category
  Future<void> decreaseCategorySpent(String categoryName, double amount) async {
    final category = currentBudget?.categories
        .firstWhere((category) => category.name == categoryName);

    if (category != null) {
      category.totalSpent -= amount;
      await updateTheBudgetHistoryInTheDatabase();
      notifyListeners();
    }
  }

  bool areAllFieldsFilled() {
    if (totalBalance == null || totalBalance == 0) return false;
    if (currentBudget?.income == 0) return false;

    for (var category in currentBudget!.categories) {
      if (category.planToSpend == 0) {
        return false;
      }
    }
    notifyListeners();
    return true;
  }
}
