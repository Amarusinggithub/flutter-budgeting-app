class TransactionModel {
  String id;
  String title;
  double amount;
  int date;
  String category;

  TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'title': title,
      'amount': amount,
      'date': date,
      'category': category,
    };
  }

  factory TransactionModel.fromJson(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['Id'],
      title: map['title'],
      amount: map['amount'],
      date: map['date'],
      category: map['category'],
    );
  }
}
