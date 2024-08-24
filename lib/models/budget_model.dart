import 'category_model.dart';

class BudgetModel {
  int date;
  double income;
  double expense;
  double savings;
  List<CategoryModel> categories;

  BudgetModel({
    required this.date,
    required this.income,
    required this.expense,
    required this.savings,
    required this.categories,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'income': income,
      'expense': expense,
      'savings': savings,
      'categories': categories.map((category) => category.toJson()).toList(),
    };
  }

  factory BudgetModel.fromJson(Map<String, dynamic> json) {
    return BudgetModel(
      date: (json['date'] ?? 0).toDouble(),
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
