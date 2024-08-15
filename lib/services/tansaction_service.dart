import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/transaction_model.dart';

class TransactionService extends ChangeNotifier {
  final FirebaseAuth auth;

  TransactionService({required this.auth}) {
    fetchTransactionsFromDatabase();
  }

  Future<List<TransactionModel>> fetchTransactionsFromDatabase() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String? userId = auth.currentUser?.uid;

    DocumentSnapshot documentSnapshot =
        await firestore.collection('users').doc(userId).get();

    List<dynamic> transactionsFromDatabase = documentSnapshot['transactions'];

    List<TransactionModel> transactions = transactionsFromDatabase
        .map((item) => TransactionModel.fromJson(item as Map<String, dynamic>))
        .toList();
    notifyListeners();
    return transactions;
  }

  Future<void> updateTransactionsInDatabase(
      List<TransactionModel> transactions) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String userId = auth.currentUser!.uid;
    List<Map<String, dynamic>> transactionsMap =
        transactions.map((transaction) {
      return {
        'Id': transaction.id,
        'title': transaction.title,
        'amount': transaction.amount,
        'date': transaction.date,
        'category': transaction.category
      };
    }).toList();

    await firestore.collection("users").doc(userId).update({
      'transactions': transactionsMap,
    });
    notifyListeners();
  }
}
