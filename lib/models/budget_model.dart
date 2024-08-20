import 'package:budgetingapp/models/transaction_model.dart';

import 'category_model.dart';

class BudgetModel {
  double income;
  double expense;
  double savings;
  List<CategoryModel> categories;
  List<TransactionModel> transactions;

  BudgetModel({
    required this.income,
    required this.expense,
    required this.categories,
    required this.savings,
    required this.transactions,
  });

  Map<String, dynamic> toJson() {
    return {
      'income': income,
      'expense': expense,
      'savings': savings,
      'categories': categories.map((category) => category.toJson()).toList(),
      'transactions':
          transactions.map((transaction) => transaction.toJson()).toList(),
    };
  }

  factory BudgetModel.fromJson(Map<String, dynamic> json) {
    return BudgetModel(
      income: (json['income'] ?? 0).toDouble(),
      expense: (json['expense'] ?? 0).toDouble(),
      savings: (json['savings'] ?? 0).toDouble(),
      categories: json['categories'] != null
          ? List<CategoryModel>.from(json['categories']
              .map((category) => CategoryModel.fromJson(category)))
          : [],
      transactions: json['transactions'] != null
          ? List<TransactionModel>.from(json['transactions']
              .map((transaction) => TransactionModel.fromJson(transaction)))
          : [],
    );
  }
}
