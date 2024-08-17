import 'category_model.dart';

class BudgetModel {
  double income;
  double availableBalance;
  double expense;
  double savings;
  List<CategoryModel> categories;

  BudgetModel(
      {required this.income,
      required this.availableBalance,
      required this.expense,
      required this.categories,
      required this.savings});

  Map<String, dynamic> toJson() {
    return {
      'income': income,
      'totalAmount': availableBalance,
      'spentAmount': expense,
      'categories': categories.map((category) => category.toJson()).toList(),
      'savings': savings
    };
  }

  factory BudgetModel.fromJson(Map<String, dynamic> json) {
    return BudgetModel(
        income: (json['income'] ?? 0).toDouble(),
        availableBalance: (json['totalAmount'] ?? 0).toDouble(),
        expense: (json['spentAmount'] ?? 0).toDouble(),
        categories: json['categories'] != null
            ? List<CategoryModel>.from(json['categories']
                .map((category) => CategoryModel.fromJson(category)))
            : [],
        savings: (json["savings"] ?? 0).toDouble());
  }
}
