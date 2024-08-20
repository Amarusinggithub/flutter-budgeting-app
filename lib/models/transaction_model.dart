class TransactionModel {
  String title;
  double amount;
  int date;
  String category;

  TransactionModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'amount': amount,
      'date': date,
      'category': category,
    };
  }

  factory TransactionModel.fromJson(Map<String, dynamic> map) {
    return TransactionModel(
      title: map['title'] ?? '',
      amount: (map['amount'] ?? 0).toDouble(),
      date: map['date'] ?? 0,
      category: map['category'] ?? '',
    );
  }
}
