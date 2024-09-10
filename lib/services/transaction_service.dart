import 'package:budgetingapp/models/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class TransactionService extends ChangeNotifier {
  final FirebaseAuth auth;

  TransactionService({
    required this.auth,
  });

  Future<List<TransactionModel>?> fetchTransactionsFromDatabase() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      String userId = auth.currentUser!.uid;

      DocumentSnapshot documentSnapshot =
          await firestore.collection('users').doc(userId).get();

      if (documentSnapshot.exists) {
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey('transactions')) {
          List<dynamic> transactionsJson = data['transactions'];
          List<TransactionModel> transactions =
              transactionsJson.map((transactionJson) {
            return TransactionModel.fromJson(
                transactionJson as Map<String, dynamic>);
          }).toList();

          if (kDebugMode) {
            print("Fetched transactions from database: $transactions");
          }
          return transactions;
        }
      }
      return [];
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching transactions from database: $e");
      }
      return [];
    }
  }

  Future<void> updateTransactionsInDatabase(
      List<TransactionModel> transactions) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      String userId = auth.currentUser!.uid;

      List<Map<String, dynamic>> transactionsJson =
          transactions.map((transaction) => transaction.toJson()).toList();

      await firestore.collection('users').doc(userId).update({
        "transactions": transactionsJson,
      });

      if (kDebugMode) {
        print(
            "Fetched notification limit model from database: $transactionsJson");
      }

      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print("Error updating transactions in database: $e");
      }
    }
  }
}
