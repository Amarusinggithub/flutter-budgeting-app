import 'category_model.dart';

class BudgetModel {
  double income;
  double totalAmount;
  double spentAmount;
  List<CategoryModel> categories;

  BudgetModel({
    required this.income,
    required this.totalAmount,
    required this.spentAmount,
    required this.categories,
  });

  Map<String, dynamic> toJson() {
    return {
      'income': income,
      'totalAmount': totalAmount,
      'spentAmount': spentAmount,
      'categories': categories.map((category) => category.toJson()).toList(),
    };
  }

  factory BudgetModel.fromJson(Map<String, dynamic> json) {
    return BudgetModel(
      income: json['income'],
      totalAmount: json['totalAmount'],
      spentAmount: json['spentAmount'],
      categories: List<CategoryModel>.from(json['categories']
          .map((category) => CategoryModel.fromJson(category))),
    );
  }
}
