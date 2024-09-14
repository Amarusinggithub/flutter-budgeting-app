import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:budgetingapp/pages/main/auth_wrapper.dart';
import 'package:budgetingapp/provider/budget_provider.dart';
import 'package:budgetingapp/provider/help_support_provider.dart';
import 'package:budgetingapp/provider/notification_provider.dart';
import 'package:budgetingapp/provider/terms_and_condition_provider.dart';
import 'package:budgetingapp/provider/transaction_provider.dart';
import 'package:budgetingapp/provider/user_data_provider.dart';
import 'package:budgetingapp/provider/user_selection_provider.dart';
import 'package:budgetingapp/services/auth_service.dart';
import 'package:budgetingapp/services/budget_service.dart';
import 'package:budgetingapp/services/notification_service.dart';
import 'package:budgetingapp/services/transaction_service.dart';
import 'package:budgetingapp/services/user_data_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/firebase_options.dart';
import 'core/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(
    null, // app icon resource
    [
      NotificationChannel(
        channelKey: 'Budgeting_app',
        channelName: 'Budgeting App',
        channelDescription: 'Notification channel for Budgeting app',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        enableVibration: true,
      ),
    ],
  );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ..._serviceProviders(),
        ..._stateProviders(),
      ],
      child: Consumer<AuthService>(
        builder: (context, authService, child) {
          return MaterialApp(
            home: AuthWrapper(),
            routes: AppRoutes.getRoutes(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }

  List<ChangeNotifierProvider> _serviceProviders() {
    return [
      ChangeNotifierProvider<AuthService>(
        create: (context) => AuthService(auth: FirebaseAuth.instance),
      ),
      ChangeNotifierProvider<UserDataService>(
        create: (context) => UserDataService(auth: FirebaseAuth.instance),
      ),
      ChangeNotifierProvider<NotificationService>(
        create: (context) => NotificationService(auth: FirebaseAuth.instance),
      ),
      ChangeNotifierProvider<BudgetService>(
        create: (context) => BudgetService(auth: FirebaseAuth.instance),
      ),
      ChangeNotifierProvider<TransactionService>(
        create: (context) => TransactionService(auth: FirebaseAuth.instance),
      ),
    ];
  }

  List<ChangeNotifierProvider> _stateProviders() {
    return [
      ChangeNotifierProvider<NotificationProvider>(
        create: (context) => NotificationProvider(
          notificationService: context.read<NotificationService>(),
        ),
      ),
      ChangeNotifierProvider<BudgetProvider>(
        create: (context) => BudgetProvider(
          budgetService: context.read<BudgetService>(),
        ),
      ),
      ChangeNotifierProvider<TransactionProvider>(
        create: (context) => TransactionProvider(
          budgetProvider: context.read<BudgetProvider>(),
          transactionService: context.read<TransactionService>(),
        ),
      ),
      ChangeNotifierProvider<UserSelectionProvider>(
        create: (context) => UserSelectionProvider(),
      ),
      ChangeNotifierProvider<TermsAndConditionsProvider>(
        create: (context) => TermsAndConditionsProvider(),
      ),
      ChangeNotifierProvider<UserDataProvider>(
        create: (context) => UserDataProvider(
          userDataService: context.read<UserDataService>(),
          authService: context.read<AuthService>(),
          budgetProvider: context.read<BudgetProvider>(),
          transactionProvider: context.read<TransactionProvider>(),
          notificationProvider: context.read<NotificationProvider>(),
        ),
      ),
      ChangeNotifierProvider<HelpAndSupportProvider>(
        create: (context) => HelpAndSupportProvider(),
      ),
    ];
  }
}
