import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/transaction_model.dart';

class TransactionService extends ChangeNotifier {
  final FirebaseAuth auth;

  TransactionService({required this.auth});

  Future<List<TransactionModel>> fetchTransactionsFromDatabase() async {
    List<TransactionModel> transactions = [];
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      String? userId = auth.currentUser?.uid;

      if (userId == null) {
        return transactions;
      }

      DocumentSnapshot documentSnapshot =
          await firestore.collection('users').doc(userId).get();

      if (documentSnapshot.exists) {
        List<dynamic> transactionsFromDatabase =
            documentSnapshot['transactions'] ?? [];

        transactions = transactionsFromDatabase
            .map((item) =>
                TransactionModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching transactions: $e');
      }
    }
    notifyListeners();
    return transactions;
  }

  Future<void> updateTransactionsInDatabase(
      List<TransactionModel> transactions) async {
    try {
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
    } catch (e) {
      if (kDebugMode) {
        print('Error updating transactions: $e');
      }
    }
  }
}
