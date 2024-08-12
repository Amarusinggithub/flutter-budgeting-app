import 'category_model.dart';

class BudgetModel {
  double income;
  double availableBalance;
  double expense;
  List<CategoryModel> categories;

  BudgetModel({
    required this.income,
    required this.availableBalance,
    required this.expense,
    required this.categories,
  });

  Map<String, dynamic> toJson() {
    return {
      'income': income,
      'totalAmount': availableBalance,
      'spentAmount': expense,
      'categories': categories.map((category) => category.toJson()).toList(),
    };
  }

  factory BudgetModel.fromJson(Map<String, dynamic> json) {
    return BudgetModel(
      income: json['income'],
      availableBalance: json['totalAmount'],
      expense: json['spentAmount'],
      categories: List<CategoryModel>.from(json['categories']
          .map((category) => CategoryModel.fromJson(category))),
    );
  }
}
