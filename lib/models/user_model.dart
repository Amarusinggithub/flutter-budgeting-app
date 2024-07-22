import 'package:flutter/foundation.dart';

class UserModel with ChangeNotifier {
  String? _uid;
  String? _email;
  String? _displayName;
  String? _password;

  UserModel({
    String? uid,
    String? email,
    String? displayName,
    String? password,
  })  : _uid = uid,
        _email = email,
        _displayName = displayName,
        _password = password;

  String? get uid => _uid;
  String? get email => _email;
  String? get displayName => _displayName;
  String? get password => _password;

  void updateEmail(String? newEmail) {
    _email = newEmail;
    notifyListeners();
  }

  void updateDisplayName(String? newDisplayName) {
    _displayName = newDisplayName;
    notifyListeners();
  }

  void updatePassword(String? newPassword) {
    _password = newPassword;
    notifyListeners();
  }

  void updateUser({
    String? uid,
    String? email,
    String? displayName,
    String? password,
  }) {
    _uid = uid;
    _email = email;
    _displayName = displayName;
    _password = password;
    notifyListeners();
  }
}
