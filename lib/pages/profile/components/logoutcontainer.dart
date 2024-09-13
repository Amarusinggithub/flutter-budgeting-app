import 'package:budgetingapp/provider/budget_provider.dart';
import 'package:budgetingapp/provider/notification_provider.dart';
import 'package:budgetingapp/provider/transaction_provider.dart';
import 'package:budgetingapp/provider/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/terms_and_condition_provider.dart';
import '../../../services/auth_service.dart';

class LogoutContainer extends StatelessWidget {
  const LogoutContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsetsDirectional.symmetric(vertical: 12, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(15),
        color: Colors.white.withOpacity(0.4),
      ),
      child: GestureDetector(
        onTap: () {
          _showLogoutDialog(context);
        },
        child: const Row(
          children: [
            Icon(Icons.exit_to_app, size: 24, color: Colors.white),
            SizedBox(width: 12),
            Text(
              "Logout",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final budgetProvider = Provider.of<BudgetProvider>(context, listen: false);
    final transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);
    final notificationProvider =
        Provider.of<NotificationProvider>(context, listen: false);
    final userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    final termsProvider =
        Provider.of<TermsAndConditionsProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to log out?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Yes"),
              onPressed: () async {
                Navigator.of(context).pop();
                termsProvider.selectAll(!termsProvider.areBothAgreed);
                try {
                  await Future.wait([
                    budgetProvider.updateTheBudgetHistoryInTheDatabase(),
                    transactionProvider.updateTheTransactionsInTheDatabase(),
                    notificationProvider.updateNotificationDailyLimit(),
                    userDataProvider.updateUserData(),
                  ]);

                  userDataProvider.toggleDidUserFinishOnboarding();

                  await authService.logout();

                  await Future.wait([
                    budgetProvider.createNewBudgetHistoryModel(),
                    transactionProvider.createTransactions(),
                    notificationProvider.createNewNotificationLimit(),
                    userDataProvider.createNewUserData()
                  ]);
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error during logout: $error')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
