import 'package:budgetingapp/models/budget_history_model.dart';
import 'package:budgetingapp/models/budget_model.dart';
import 'package:budgetingapp/models/transaction_model.dart';
import 'package:budgetingapp/services/budget_service.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class BudgetProvider extends ChangeNotifier {
  BudgetModel? currentBudget;
  double? totalBalanceModel;
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
      totalBalanceModel = budgetHistoryModel?.totalBalance;
    } else {
      budgetHistoryModel = BudgetHistoryModel(totalBalance: 0.0, budgets: []);
      await createNewBudget();
    }
  }

  Future<void> getCurrentBudget() async {
    if (budgetHistoryModel!.budgets.isNotEmpty) {
      currentBudget = findBudgetForCurrentMonth();

      if (isEndOfMonthAndDay() && !didSavingsAddAlready) {
        calculateSavings();
      }
    } else {
      await createNewBudget();
    }

    if (isStartOfMonth()) {
      didSavingsAddAlready = false;
    }

    calculatePlanToSpend();
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
    await updateTheBudgetHistoryInTheDatabase();
    notifyListeners();
  }

  Future<void> getTotalBalance() async {
    if (budgetHistoryModel != null) {
      totalBalanceModel = budgetHistoryModel!.totalBalance;
    }
    notifyListeners();
  }

  Future<void> updateTheBudgetHistoryInTheDatabase() async {
    if (currentBudget != null && budgetHistoryModel != null) {
      if (isEndOfMonthAndDay() && !didSavingsAddAlready) {
        calculateSavings();
      }

      budgetHistoryModel!.budgets.last = currentBudget!;
      budgetHistoryModel?.totalBalance = totalBalanceModel!;

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
  }

  void updateIncome(double newIncome) {
    if (currentBudget != null) {
      currentBudget!.income += newIncome;
    }
    notifyListeners();
  }

  void calculateSavings() {
    if (currentBudget != null) {
      currentBudget!.savings = currentBudget!.income - currentBudget!.expense;
      totalBalanceModel = ((totalBalanceModel)! + currentBudget!.savings);
    }
    didSavingsAddAlready = true;
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
  }

  void calculatePlanToSpend() {
    if (currentBudget != null) {
      currentBudget!.planToSpend = currentBudget!.categories.fold(
        0.0,
        (sum, category) => sum + category.planToSpend,
      );
    }
    notifyListeners();
  }

  int calculatePercentageOfTotalPlanToSpend(double num) {
    if (currentBudget!.planToSpend == 0) {
      return 0;
    }
    return ((num / currentBudget!.planToSpend) * 100).round();
  }

  bool isStartOfMonth() {
    DateTime today = DateTime.now();
    return today.day == 1;
  }

  bool isEndOfMonthAndDay() {
    DateTime today = DateTime.now();
    DateTime lastDayOfMonth = DateTime(today.year, today.month + 1, 0);
    bool isEndOfMonth = today.day == lastDayOfMonth.day;
    bool isEndOfDay = today.hour == 23 && today.minute == 59;
    return isEndOfMonth && isEndOfDay;
  }

  String numberCurrencyFormater(double number) {
    final formatCurrency = NumberFormat.simpleCurrency();
    return formatCurrency.format(number);
  }
}
