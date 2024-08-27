import 'package:budgetingapp/provider/budget_provider.dart';
import 'package:budgetingapp/provider/transaction_provider.dart';
import 'package:budgetingapp/services/auth_service.dart';
import 'package:budgetingapp/services/budget_service.dart';
import 'package:budgetingapp/services/transaction_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/firebase_options.dart';
import 'core/routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Error initializing Firebase'),
              ),
            ),
            debugShowCheckedModeBanner: false,
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<AuthService>(
                create: (context) => AuthService(auth: FirebaseAuth.instance),
              ),
              ChangeNotifierProvider<BudgetService>(
                create: (context) => BudgetService(auth: FirebaseAuth.instance),
              ),
              ChangeNotifierProvider<BudgetProvider>(
                create: (context) => BudgetProvider(
                  budgetService: context.read<BudgetService>(),
                ),
              ),
              ChangeNotifierProvider<TransactionService>(
                create: (context) =>
                    TransactionService(auth: FirebaseAuth.instance),
              ),
              ChangeNotifierProvider<TransactionProvider>(
                create: (context) => TransactionProvider(
                  budgetProvider: context.read<BudgetProvider>(),
                  transactionService: context.read<TransactionService>(),
                ),
              )
            ],
            child: Consumer<AuthService>(
              builder: (context, authService, child) {
                return MaterialApp(
                  routes: AppRoutes.getRoutes(),
                  debugShowCheckedModeBanner: false,
                );
              },
            ),
          );
        }

        return const MaterialApp(
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
