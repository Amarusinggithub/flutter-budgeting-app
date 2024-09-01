import 'category_model.dart';

class BudgetModel {
  int date;
  double income;
  double expense;
  double savings;
  double planToSpend;
  List<CategoryModel> categories;

  BudgetModel({
    required this.date,
    required this.income,
    required this.expense,
    required this.planToSpend,
    required this.savings,
    List<CategoryModel>? categories,
  }) : categories = categories ??
            [
              CategoryModel(
                  id: "Housing",
                  name: "Housing",
                  totalSpent: 0,
                  planToSpend: 0),
              CategoryModel(
                  id: "Utilities",
                  name: "Utilities",
                  totalSpent: 0,
                  planToSpend: 0),
              CategoryModel(
                  id: "Transportation",
                  name: "Transportation",
                  totalSpent: 0,
                  planToSpend: 0),
              CategoryModel(
                  id: "Groceries",
                  name: "Groceries",
                  totalSpent: 0,
                  planToSpend: 0),
              CategoryModel(
                  id: "Entertainment",
                  name: "Entertainment",
                  totalSpent: 0,
                  planToSpend: 0),
              CategoryModel(
                  id: "Shopping",
                  name: "Shopping",
                  totalSpent: 0,
                  planToSpend: 0),
              CategoryModel(
                  id: "Personal care",
                  name: "Personal care",
                  totalSpent: 0,
                  planToSpend: 0),
            ];

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'income': income,
      'expense': expense,
      'savings': savings,
      'plan to spend': planToSpend,
      'categories': categories.map((category) => category.toJson()).toList(),
    };
  }

  factory BudgetModel.fromJson(Map<String, dynamic> json) {
    return BudgetModel(
      date: json['date'] ?? 0,
      income: (json['income'] ?? 0).toDouble(),
      expense: (json['expense'] ?? 0).toDouble(),
      savings: (json['savings'] ?? 0).toDouble(),
      planToSpend: (json['plan to spend'] ?? 0).toDouble(),
      // Consistent key naming
      categories: json['categories'] != null
          ? List<CategoryModel>.from(json['categories']
              .map((category) => CategoryModel.fromJson(category)))
          : [],
    );
  }
}
