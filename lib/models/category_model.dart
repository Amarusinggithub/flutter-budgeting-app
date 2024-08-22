class CategoryModel {
  String id;
  String name;

  double totalSpent;

  CategoryModel({
    required this.id,
    required this.name,
    this.totalSpent = 0.0,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'totalSpent': totalSpent,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      totalSpent: (map['totalSpent'] ?? 0).toDouble(),
    );
  }
}
