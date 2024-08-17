import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/budget_model.dart';

class BudgetService extends ChangeNotifier {
  final FirebaseAuth auth;

  BudgetService({required this.auth});

  Future<void> updateBudgetInDatabase(BudgetModel budget) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      String userId = auth.currentUser!.uid;
      await firestore.collection('users').doc(userId).update({
        "budget": budget.toJson(),
      });
      notifyListeners();
    } catch (e) {
      print("Error updating budget in database: $e");
    }
  }

  Future<BudgetModel?> fetchBudgetFromDatabase() async {
    BudgetModel? _budget;
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      String userId = auth.currentUser!.uid;

      DocumentSnapshot documentSnapshot =
          await firestore.collection('users').doc(userId).get();

      if (documentSnapshot.exists) {
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey('budget')) {
          _budget =
              BudgetModel.fromJson(data["budget"] as Map<String, dynamic>);
          if (kDebugMode) {
            print("Fetched budget in database: $_budget");
          }
          notifyListeners();
          return _budget;
        }
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching budget from database: $e");
      }
      return null;
    }
  }
}
