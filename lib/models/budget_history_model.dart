import 'budget_model.dart';

class BudgetHistoryModel {
  double totalBalance;
  List<BudgetModel> budgets;

  BudgetHistoryModel({
    required this.totalBalance,
    required this.budgets,
  });

  Map<String, dynamic> toJson() {
    return {
      'totalBalance': totalBalance,
      'budgets': budgets.map((budget) => budget.toJson()).toList(),
    };
  }

  factory BudgetHistoryModel.fromJson(Map<String, dynamic> json) {
    return BudgetHistoryModel(
      totalBalance: (json['totalBalance'] ?? 0).toDouble(),
      budgets: json['budgets'] != null
          ? List<BudgetModel>.from(
              json['budgets'].map((budget) => BudgetModel.fromJson(budget)))
          : [],
    );
  }
}
