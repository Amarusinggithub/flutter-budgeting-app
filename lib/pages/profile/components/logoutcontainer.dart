import 'package:budgetingapp/provider/budget_provider.dart';
import 'package:budgetingapp/provider/notification_provider.dart';
import 'package:budgetingapp/provider/transaction_provider.dart';
import 'package:budgetingapp/provider/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/auth_service.dart';

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
              onPressed: () {
                budgetProvider.updateTheBudgetHistoryInTheDatabase();
                transactionProvider.updateTheTransactionsInTheDatabase();
                notificationProvider.updateNotificationDailyLimit();
                userDataProvider.updateUserData();
                authService.logout();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
