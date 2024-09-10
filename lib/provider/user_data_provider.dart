import 'package:budgetingapp/models/user_data_model.dart';
import 'package:budgetingapp/provider/budget_provider.dart';
import 'package:budgetingapp/provider/notification_provider.dart';
import 'package:budgetingapp/provider/transaction_provider.dart';
import 'package:budgetingapp/services/auth_service.dart';
import 'package:budgetingapp/services/user_data_service.dart';
import 'package:flutter/foundation.dart';

import '../core/utils/validators.dart';

class UserDataProvider extends ChangeNotifier {
  UserDataModel? userDataModel;
  UserDataService userDataService;
  AuthService authService;
  BudgetProvider budgetProvider;
  TransactionProvider transactionProvider;
  NotificationProvider notificationProvider;

  String _username = "";
  String _email = "";
  String _password = "";

  String get username => _username;

  String get email => _email;

  String get password => _password;

  UserDataProvider({
    required this.userDataService,
    required this.authService,
    required this.budgetProvider,
    required this.transactionProvider,
    required this.notificationProvider,
  }) {
    initialize();
  }

  Future<void> initialize() async {
    await fetchUserData();
    notifyListeners();
  }

  Future<void> fetchUserData() async {
    UserDataModel? fetchedUserData = await userDataService.fetchUserData();
    if (fetchedUserData != null) {
      userDataModel = fetchedUserData;
    } else {
      await createNewUserData();
    }
    notifyListeners();
  }

  Future<void> createNewUserData() async {
    UserDataModel newUserData = UserDataModel(username: '', email: '');
    userDataModel = newUserData;
    if (kDebugMode) {
      print("Created new userdata: ${userDataModel?.email}");
    }
    notifyListeners();
  }

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

  Future<void> updateUserData() async {
    await userDataService.updateUserDataInDatabase(userDataModel!);
    notifyListeners();
  }

  Future<void> register() async {
    await authService.signUp(email, password);
    userDataModel?.username = _username;
    userDataModel?.email = authService.auth.currentUser?.email ?? '';
    await budgetProvider.updateTheBudgetHistoryInTheDatabase();
    await transactionProvider.updateTheTransactionsInTheDatabase();
    await notificationProvider.updateNotificationDailyLimit();
    await updateUserData();
    if (Validators.validateEmail(email) &&
        Validators.validatePassword(password)) {}
  }

  Future<void> login() async {
    await authService.login(email, password);
    await fetchUserData();
    await budgetProvider.initializeBudgetData();
    await transactionProvider.getTransactions();
    await notificationProvider.initialize();

    if (Validators.validateEmail(email) &&
        Validators.validatePassword(email)) {}
  }
}
