import 'category_model.dart';

class BudgetModel {
  double income;
  double expense;
  double savings;
  List<CategoryModel> categories;

  BudgetModel({
    required this.income,
    required this.expense,
    required this.savings,
    required this.categories,
  });

  Map<String, dynamic> toJson() {
    return {
      'income': income,
      'expense': expense,
      'savings': savings,
      'categories': categories.map((category) => category.toJson()).toList(),
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
    );
  }
}
