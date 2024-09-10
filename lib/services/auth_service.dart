import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth auth;

  AuthService({
    required this.auth,
  });

  Future<void> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      if (kDebugMode) {
        print('User document created successfully in Firestore with UID');
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error signing in user : $e");
      }
    }
    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .set({});
      if (kDebugMode) {
        print('User document created successfully in Firestore with UID');
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error Signing up and creating Firestore document: $e");
      }
    }
    notifyListeners();
  }

  Future<void> logout() async {
    await auth.signOut();
    notifyListeners();
  }
}
