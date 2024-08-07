import 'package:budgetingapp/models/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Budget {
  String id;
  String name;
  double totalAmount;
  double spentAmount;
  List<TransactionModel> transactions;

  Budget({
    required this.id,
    required this.name,
    required this.totalAmount,
    required this.spentAmount,
    required this.transactions,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'totalAmount': totalAmount,
      'spentAmount': spentAmount,
      'transactions':
          transactions.map((transaction) => transaction.toMap()).toList(),
    };
  }

  static Budget fromMap(Map<String, dynamic> map) {
    return Budget(
      id: map['id'],
      name: map['name'],
      totalAmount: map['totalAmount'],
      spentAmount: map['spentAmount'],
      transactions: List<TransactionModel>.from(map['transactions']
          .map((transaction) => TransactionModel.fromMap(transaction))),
    );
  }
}

/*
budget.spentAmount = budget.transactions.fold(0, (sum, transaction) => sum + transaction.amount);
*/

void addBudgetToFirestore(Budget budget) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  await firestore.collection('budgets').add(budget.toMap());
}

void getBudgetsFromFirestore() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  QuerySnapshot querySnapshot = await firestore.collection('budgets').get();

  List<Budget> budgets = querySnapshot.docs.map((doc) {
    return Budget.fromMap(doc.data() as Map<String, dynamic>);
  }).toList();

  budgets.forEach((budget) {
    print('Budget Name: ${budget.name}');
    print('Total Amount: \$${budget.totalAmount}');
    print('Spent Amount: \$${budget.spentAmount}');
    budget.transactions.forEach((transaction) {
      print(
          'Transaction - Title: ${transaction.title}, Amount: \$${transaction.amount}, Date: ${DateTime.fromMillisecondsSinceEpoch(transaction.date * 1000)}, Category: ${transaction.category}');
    });
  });
}
