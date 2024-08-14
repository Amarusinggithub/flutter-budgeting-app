import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/transaction_model.dart';

class TransactionService extends ChangeNotifier {
  final FirebaseAuth auth;
  List<TransactionModel> transactions = [];

  TransactionService({required this.auth}) {
    fetchTransactionsFromDatabase();
  }

  Future<void> fetchTransactionsFromDatabase() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      String? userId = auth.currentUser?.uid;

      if (userId == null) {
        // Handle the case where the user is not logged in
        return;
      }

      DocumentSnapshot documentSnapshot =
          await firestore.collection('users').doc(userId).get();

      if (documentSnapshot.exists) {
        List<dynamic> transactionsFromDatabase =
            documentSnapshot['transactions'];
        transactions = transactionsFromDatabase
            .map((item) => TransactionModel(
                id: item["Id"],
                title: item["title"],
                amount: item["amount"],
                date: item["date"],
                category: item["category"]))
            .toList();
      } else {
        transactions = [];
      }

      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching transactions: $e");
      }
    }
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
