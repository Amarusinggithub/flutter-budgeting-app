import 'package:budgetingapp/provider/budget_provider.dart';
import 'package:budgetingapp/provider/notification_provider.dart';
import 'package:budgetingapp/provider/transaction_provider.dart';
import 'package:budgetingapp/provider/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/terms_and_condition_provider.dart';
import '../../../services/auth_service.dart';
import '../../main/main_screen.dart';

class LogoutContainer extends StatelessWidget {
  const LogoutContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 10),
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(15),
        color: Colors.white,
      ),
      child: GestureDetector(
        onTap: () {
          _showLogoutDialog(context);
        },
        child: const Row(
          children: [
            Icon(Icons.logout),
            SizedBox(
              width: 8,
            ),
            Text("Logout"),
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
                // Close dialog first
                Navigator.of(context).pop();

                // Defer navigation until the next frame
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  // Ensure the widget is still mounted before accessing context
                  if (context.mounted) {
                    // Navigate back to the initial screen
                    await MainScreen.popUntilFirstScreenOnSelectedTabScreen(
                        context);

                    // Perform the actions after navigation
                    await budgetProvider.updateTheBudgetHistoryInTheDatabase();
                    await transactionProvider
                        .updateTheTransactionsInTheDatabase();
                    await notificationProvider.updateNotificationDailyLimit();
                    await userDataProvider.updateUserData();

                    // Reset states (if necessary)
                    await budgetProvider.createNewBudgetHistoryModel();
                    await transactionProvider.createTransactions();
                    await notificationProvider.createNewNotificationLimit();
                    await userDataProvider.createNewUserData();
                    userDataProvider.toggleDidUserFinishOnboarding();
                    termsProvider.selectAll(!termsProvider.areBothAgreed);
                    // Perform logout
                    await authService.logout();

                    // Ensure the widget is still mounted before accessing context again
                    if (context.mounted) {
                      // Navigate back to the initial screen again (if necessary)
                      await MainScreen.popUntilFirstScreenOnSelectedTabScreen(
                          context);
                    }
                  }
                });
              },
            ),
          ],
        );
      },
    );
  }
}
