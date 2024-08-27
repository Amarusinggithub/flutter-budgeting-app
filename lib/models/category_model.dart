class CategoryModel {
  String id;
  String name;
  double planToSpend;
  double totalSpent;

  CategoryModel({
    required this.id,
    required this.name,
    this.planToSpend = 0.0,
    this.totalSpent = 0.0,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'planToSpend': planToSpend,
      'totalSpent': totalSpent,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      planToSpend: (map['plan to spend'] ?? 0).toDouble(),
      totalSpent: (map['totalSpent'] ?? 0).toDouble(),
    );
  }
}
