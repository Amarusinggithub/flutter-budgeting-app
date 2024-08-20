class CategoryModel {
  String id;
  String name;
  String icon;
  double totalSpent;

  CategoryModel({
    required this.id,
    required this.name,
    this.icon = '',
    this.totalSpent = 0.0,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'totalSpent': totalSpent,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      icon: map['icon'] ?? '',
      totalSpent: (map['totalSpent'] ?? 0).toDouble(),
    );
  }
}
