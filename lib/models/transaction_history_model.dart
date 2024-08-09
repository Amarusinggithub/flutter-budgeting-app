import 'package:budgetingapp/models/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionHistory {
  String id;
  String name;
  List<TransactionModel> transactions;

  TransactionHistory({
    required this.id,
    required this.name,
    required this.transactions,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'transactions':
          transactions.map((transaction) => transaction.toMap()).toList(),
    };
  }

  static TransactionHistory fromMap(Map<String, dynamic> map) {
    return TransactionHistory(
      id: map['id'],
      name: map['name'],
      transactions: List<TransactionModel>.from(map['transactions']
          .map((transaction) => TransactionModel.fromMap(transaction))),
    );
  }
}

void addTransactionHistoryToFirestore(
    TransactionHistory transactionHistory) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  await firestore
      .collection('transactionHistories')
      .add(transactionHistory.toMap());
}

void getTransactionHistoriesFromFirestore() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  QuerySnapshot querySnapshot =
      await firestore.collection('transactionHistories').get();

  List<TransactionHistory> transactionHistories = querySnapshot.docs.map((doc) {
    return TransactionHistory.fromMap(doc.data() as Map<String, dynamic>);
  }).toList();

  for (var transactionHistory in transactionHistories) {
    print('Transaction History Name: ${transactionHistory.name}');
    for (var transaction in transactionHistory.transactions) {
      print(
          'Transaction - Title: ${transaction.title}, Amount: \$${transaction.amount}, Date: ${DateTime.fromMillisecondsSinceEpoch(transaction.date * 1000)}, Category: ${transaction.category}');
    }
  }
}
