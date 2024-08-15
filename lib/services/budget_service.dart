import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/budget_model.dart';

class BudgetService extends ChangeNotifier {
  final FirebaseAuth auth;

  BudgetService({required this.auth}) {
    fetchBudgetFromDatabase();
  }

  Future<void> addBudgetToDatabase(BudgetModel budget) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String userId = auth.currentUser!.uid;
    await firestore.collection('users').doc(userId).set({
      "budget": budget.toJson(),
    });
    notifyListeners();
  }

  Future<void> updateBudgetInDatabase(BudgetModel budget) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String userId = auth.currentUser!.uid;
    await firestore.collection('users').doc(userId).update({
      "budget": budget.toJson(),
    });

    notifyListeners();
  }

  Future<BudgetModel> fetchBudgetFromDatabase() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String userId = auth.currentUser!.uid;

    DocumentSnapshot documentSnapshot =
        await firestore.collection('users').doc(userId).get();

    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    BudgetModel budget =
        BudgetModel.fromJson(data["budget"] as Map<String, dynamic>);
    notifyListeners();
    return budget;
  }
}
