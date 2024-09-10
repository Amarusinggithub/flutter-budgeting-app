import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/user_data_model.dart';

class UserDataService extends ChangeNotifier {
  final FirebaseAuth auth;

  UserDataService({
    required this.auth,
  });

  Future<UserDataModel?> fetchUserData() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      String userId = auth.currentUser?.uid ?? '';

      DocumentSnapshot documentSnapshot =
          await firestore.collection('users').doc(userId).get();

      if (documentSnapshot.exists) {
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey('userData')) {
          UserDataModel userData =
              UserDataModel.fromJson(data['userData'] as Map<String, dynamic>);
          return userData;
        }
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching userdata from database: $e");
      }
      return null;
    }
  }

  Future<void> updateUserDataInDatabase(UserDataModel userData) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      String userId = auth.currentUser?.uid ?? '';

      Map<String, dynamic> userDataJson = userData.toJson();

      await firestore.collection('users').doc(userId).set({
        'userData': userDataJson,
      }, SetOptions(merge: true));

      if (kDebugMode) {
        print("Updated userdata in database: $userDataJson");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error updating userData in database: $e");
      }
    }
  }
}
