import 'package:budgetingapp/models/user_data_model.dart';
import 'package:budgetingapp/services/auth_service.dart';
import 'package:budgetingapp/services/user_data_service.dart';
import 'package:flutter/cupertino.dart';

import '../core/utils/validators.dart';

class UserDataProvider extends ChangeNotifier {
  UserDataModel? userDataModel;
  UserDataService userDataService;
  AuthService authService;

  String _username = "";
  String _email = "";
  String _password = "";

  UserDataProvider({required this.userDataService, required this.authService}) {
    initialize();
  }

  String get username => _username;

  String get email => _email;

  String get password => _password;

  void setUsername(String username) {
    _username = username;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  Future<void> initialize() async {
    await fetchUserData();
    notifyListeners();
  }

  Future<void> fetchUserData() async {
    UserDataModel? fetchedUserData = await userDataService.fetchUserData();
    if (userDataModel == null && fetchedUserData != null) {
      userDataModel = fetchedUserData;
    } else {
      userDataModel = UserDataModel(username: _username, email: _email);
    }
  }

  Future<void> updateUserData() async {
    await userDataService.updateUserDataInDatabase(userDataModel!);
  }

  Future<void> register() async {
    await authService.signUp(
      email,
      password,
    );
    await authService.login(
      email,
      password,
    );
    final userEmail = authService.auth.currentUser?.email;
    userDataModel?.username = username;
    userDataModel?.email = userEmail!;

    if (Validators.validateEmail(email) &&
        Validators.validatePassword(password)) {}
  }

  Future<void> login() async {
    await authService.login(
      email,
      password,
    );
    final userEmail = authService.auth.currentUser?.email;
    userDataModel?.username = username;
    userDataModel?.email = userEmail!;
    if (Validators.validateEmail(email) &&
        Validators.validatePassword(email)) {}
  }
}
