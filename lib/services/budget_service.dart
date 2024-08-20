import 'package:budgetingapp/models/budget_history_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class BudgetService extends ChangeNotifier {
  final FirebaseAuth auth;

  BudgetService({required this.auth});

  Future<void> updateBudgetsInDatabase(BudgetHistoryModel budgets) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      String userId = auth.currentUser!.uid;

      await firestore.collection('users').doc(userId).update({
        "budgets": budgets.toJson(),
      });

      notifyListeners();
    } catch (e) {
      print("Error updating budgets in database: $e");
    }
  }

  Future<BudgetHistoryModel?> fetchBudgetsFromDatabase() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      String userId = auth.currentUser!.uid;

      DocumentSnapshot documentSnapshot =
          await firestore.collection('users').doc(userId).get();

      if (documentSnapshot.exists) {
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey('budgets')) {
          // Convert the JSON data back into a BudgetHistoryModel object
          BudgetHistoryModel budgets = BudgetHistoryModel.fromJson(
              data["budgets"] as Map<String, dynamic>);
          if (kDebugMode) {
            print("Fetched budgets in database: $budgets");
          }
          return budgets;
        }
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching budgets from database: $e");
      }
      return null;
    }
  }
}
