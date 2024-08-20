import 'budget_model.dart';

class BudgetHistoryModel {
  double totalBalance;
  List<BudgetModel> budgets;

  BudgetHistoryModel({required this.totalBalance, required this.budgets});

  Map<String, dynamic> toJson() {
    return {
      'Total Balance': totalBalance,
      'budgets': budgets.map((budget) => budget.toJson()).toList(),
    };
  }

  factory BudgetHistoryModel.fromJson(Map<String, dynamic> json) {
    return BudgetHistoryModel(
      totalBalance: (json['Total Balance'] ?? 0).toDouble(),
      budgets: (json['budgets'] as List<dynamic>).map((budgetJson) {
        return BudgetModel.fromJson(budgetJson as Map<String, dynamic>);
      }).toList(),
    );
  }
}
