import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/routes/routes.dart';
import '../../models/category_model.dart';
import '../../provider/budget_provider.dart';
import '../../provider/notification_provider.dart';

class SetUpInitialBudgetOnboardingScreen extends StatelessWidget {
  const SetUpInitialBudgetOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final budgetProvider = Provider.of<BudgetProvider>(context);
    final notificationProvider = Provider.of<NotificationProvider>(context);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1976D2),
              Color(0xFFF1F8E9),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Set Up Your Budget',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Input fields for total balance and income
                    _buildInputField(
                      label: 'Enter Your Total Balance',
                      hint: 'Total Balance',
                      onChanged: (value) {
                        budgetProvider.totalBalance =
                            double.tryParse(value) ?? 0;
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildInputField(
                      label: 'Enter Your Monthly Income',
                      hint: 'Monthly Income',
                      onChanged: (value) {
                        budgetProvider.userIncomeInput =
                            double.tryParse(value) ?? 0;
                        budgetProvider.editIncome();
                      },
                    ),
                    const SizedBox(height: 30),

                    // Category Budget Allocation Section
                    const Text(
                      'Plan Your Budget for Each Category',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ...budgetProvider.currentBudget!.categories.map((category) {
                      return _buildCategoryBudgetInput(
                          category, budgetProvider);
                    }),
                    const SizedBox(height: 20),

                    // Notification toggle
                    _buildNotificationToggle(notificationProvider),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            // Save button
            Center(
              child: ElevatedButton(
                onPressed: budgetProvider.areAllFieldsFilled()
                    ? () {
                        budgetProvider.updateTheBudgetHistoryInTheDatabase();
                        notificationProvider.updateNotificationDailyLimit();
                        Navigator.pushNamed(
                            context, AppRoutes.finishOnboarding);
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: budgetProvider.areAllFieldsFilled()
                        ? Colors.blueAccent
                        : Colors.grey, // Change color when disabled
                    fixedSize: const Size(350, 55)),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(
      {required String label,
      required String hint,
      required Function(String) onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              hintText: hint,
              filled: true,
              fillColor: Colors.white.withOpacity(0.4)),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildCategoryBudgetInput(
      CategoryModel category, BudgetProvider budgetProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          'Budget for ${category.name}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            hintText: 'Enter budget amount',
            filled: true,
            fillColor: Colors.white.withOpacity(0.4),
          ),
          onChanged: (value) {
            category.planToSpend = double.tryParse(value) ?? 0.0;
            budgetProvider.calculatePlanToSpend();
          },
        ),
      ],
    );
  }

  // Helper to build the notification toggle
  Widget _buildNotificationToggle(NotificationProvider notificationProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Enable Notifications',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Switch(
          value: notificationProvider.selectedLimitIndex > 0,
          onChanged: (value) {
            notificationProvider.updateSelectLimit(value ? 3 : 0);
          },
          activeColor: Colors.blueAccent,
        ),
      ],
    );
  }
}
