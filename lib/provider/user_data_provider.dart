import 'package:budgetingapp/models/user_data_model.dart';
import 'package:budgetingapp/provider/budget_provider.dart';
import 'package:budgetingapp/provider/notification_provider.dart';
import 'package:budgetingapp/provider/transaction_provider.dart';
import 'package:budgetingapp/services/auth_service.dart';
import 'package:budgetingapp/services/user_data_service.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../core/utils/validators.dart';

class UserDataProvider extends ChangeNotifier {
  bool didUserFinishOnboarding = false;
  UserDataModel? userDataModel;
  UserDataService userDataService;
  AuthService authService;
  BudgetProvider budgetProvider;
  TransactionProvider transactionProvider;
  NotificationProvider notificationProvider;

  bool isInitialized = false;

  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: 'email@gmail.com',
    queryParameters: {
      'subject': "Costumer Support",
      'body': "",
    },
  );

  String _username = "";
  String _email = "";
  String _password = "";
  String _confirmPassword = "";
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  String get username => _username;

  String get email => _email;

  String get password => _password;

  String get confirmPassword => _confirmPassword;

  bool get isPasswordVisible => _isPasswordVisible;

  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;

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
    await _loadOnboardingStatus();
    await fetchUserData();
    isInitialized = true;
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
    notifyListeners();
  }

  Future<void> updateUserData() async {
    await userDataService.updateUserDataInDatabase(userDataModel!);
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

  void setConfirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }

  bool validateFieldsForSignUp() {
    return _username.isNotEmpty &&
        _email.isNotEmpty &&
        _password.isNotEmpty &&
        _confirmPassword.isNotEmpty &&
        _password == _confirmPassword;
  }

  bool validateFieldsForSignIn() {
    return _email.isNotEmpty && _password.isNotEmpty;
  }

  Future<void> register() async {
    if (validateFieldsForSignUp()) {
      await authService.signUp(email, password);
      userDataModel?.username = _username;
      userDataModel?.email = authService.auth.currentUser?.email ?? '';
      await budgetProvider.updateTheBudgetHistoryInTheDatabase();
      await transactionProvider.updateTheTransactionsInTheDatabase();
      await notificationProvider.updateNotificationDailyLimit();
      await updateUserData();
      if (Validators.validateEmail(email) &&
          Validators.validatePassword(password)) {}
    } else {
      throw Exception("All fields must be filled, and passwords must match.");
    }
  }

  Future<void> login() async {
    if (validateFieldsForSignIn()) {
      await authService.login(email, password);
      await fetchUserData();
      await budgetProvider.initializeBudgetData();
      await transactionProvider.getTransactions();
      await notificationProvider.initialize();

      if (Validators.validateEmail(email) &&
          Validators.validatePassword(password)) {}
    } else {
      throw Exception("All fields must be filled.");
    }
  }

  Future<void> _loadOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    didUserFinishOnboarding = prefs.getBool('didUserFinishOnboarding') ?? false;
  }

  Future<void> toggleToTrueDidUserFinishOnboarding() async {
    didUserFinishOnboarding = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('didUserFinishOnboarding', didUserFinishOnboarding);
    if (kDebugMode) {
      print('didUserFinishOnboarding: $didUserFinishOnboarding');
    }
    notifyListeners();
  }

  Future<void> resetDidUserFinishOnboardingToFalse() async {
    didUserFinishOnboarding = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('didUserFinishOnboarding', didUserFinishOnboarding);
    notifyListeners();
  }

  Future<void> _openUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> callSupport() async {
    await _openUrl('tel:${917600896744}');
  }

  Future<void> emailSupport() async {
    await _openUrl(emailUri.toString());
  }

  Future<void> smsSupport() async {
    _openUrl('sms:${917600896744}');
  }
}
