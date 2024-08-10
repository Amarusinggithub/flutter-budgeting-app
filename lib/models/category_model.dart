class CategoryModel {
  String? id;
  String? name;

  String? icon;

  int? totalSpent;

  CategoryModel({this.id, this.name, this.icon, this.totalSpent});

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'icon': icon, 'Total Spent': totalSpent};
  }

  factory CategoryModel.fromJson(Map<String, dynamic> map) {
    return CategoryModel(
        id: map['id'],
        name: map['name'],
        icon: map['icon'],
        totalSpent: map['Total Spent']);
  }
}
