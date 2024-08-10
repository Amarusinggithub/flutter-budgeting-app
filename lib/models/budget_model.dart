import 'category_model.dart';

class BudgetModel {
  double totalAmount;
  double spentAmount;
  List<CategoryModel> categories;

  BudgetModel({
    required this.totalAmount,
    required this.spentAmount,
    required this.categories,
  });

  Map<String, dynamic> toJson() {
    return {
      'totalAmount': totalAmount,
      'spentAmount': spentAmount,
      'transactions':
          categories.map((category) => CategoryModel().toJson()).toList(),
    };
  }

  factory BudgetModel.fromJson(Map<String, dynamic> json) {
    return BudgetModel(
      totalAmount: json['totalAmount'],
      spentAmount: json['spentAmount'],
      categories: List<CategoryModel>.from(json['categories']
          .map((category) => CategoryModel.fromJson(category))),
    );
  }
}
