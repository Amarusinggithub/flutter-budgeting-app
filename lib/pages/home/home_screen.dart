import 'package:budgetingapp/core/utils/helper_functions.dart';
import 'package:budgetingapp/pages/home/components/credit_card.dart';
import 'package:budgetingapp/pages/home/components/no_transaction_container.dart';
import 'package:budgetingapp/pages/main/main_screen.dart';
import 'package:budgetingapp/pages/profile/profile_screen.dart';
import 'package:budgetingapp/pages/transaction/transaction_screen.dart';
import 'package:budgetingapp/provider/transaction_provider.dart';
import 'package:budgetingapp/widgets/transaction_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/budget_provider.dart';
import '../../provider/user_data_provider.dart';
import 'components/expense_container.dart';
import 'components/income_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final budgetProvider = Provider.of<BudgetProvider>(context);
    final userDataProvider = Provider.of<UserDataProvider>(context);
    final username = userDataProvider.userDataModel?.username;
    final budget = budgetProvider.currentBudget;
    final transactionProvider = Provider.of<TransactionProvider>(context);

    if (budget == null && userDataProvider.userDataModel == null) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
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
          ),
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Welcome!",
                              style: TextStyle(
                                color: Colors.white,
                                // Changed text color to white for contrast
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              HelperFunctions.capitalizeFirstLetterOfEachWord(
                                  username!),
                              style: const TextStyle(
                                  color: Colors.white,
                                  // Changed text color to white for contrast
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            MainScreen.pushNewScreen(
                                context, const ProfileScreen(),
                                isNavBarItem: true, tabIndex: 3);
                          },
                          child: const CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.blueAccent,
                            // Adjusted background color
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CreditCard(),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              _showBudgetBottomSheet(context);
                            },
                            child: const IncomeContainer()),
                        const ExpenseContainer(),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Recent Transaction",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                            color: Colors
                                .white, // Set text color to white for contrast
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            MainScreen.pushNewScreen(
                                context, const TransactionScreen(),
                                isNavBarItem: true, tabIndex: 1);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Text(
                              "See All",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color(0xFF6D77FB),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    transactionProvider.transactionsByDate.isNotEmpty &&
                            transactionProvider
                                .transactionsByDate.last.isNotEmpty
                        ? Column(
                            children: List.generate(
                                transactionProvider
                                    .transactionsByDate[0].length, (index) {
                              return TransactionContainer(
                                index: index,
                                transactionProvider: transactionProvider,
                              );
                            }),
                          )
                        : const NoTransactionContainer(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showBudgetBottomSheet(BuildContext context) {
    final budgetProvider = Provider.of<BudgetProvider>(context, listen: false);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        return Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF1976D2),
                Color(0xFFF1F8E9),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Income',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Ensure visibility against gradient
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Income',
                    labelStyle: const TextStyle(color: Colors.black87),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.4),
                  ),
                  onChanged: (value) {
                    budgetProvider.userIncomeInput = double.parse(value);
                  },
                ),
                const SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      backgroundColor: Colors.blueAccent,
                      fixedSize: const Size(360, 55),
                    ),
                    onPressed: () {
                      budgetProvider.addNewIncome();
                      budgetProvider.updateTheBudgetHistoryInTheDatabase();
                      Navigator.of(context).pop(); // Close the bottom sheet
                    },
                    child: const Text(
                      'Add Income',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      backgroundColor: Colors.blueAccent,
                      fixedSize: const Size(360, 55),
                    ),
                    onPressed: () {
                      budgetProvider.editIncome();
                      budgetProvider.updateTheBudgetHistoryInTheDatabase();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Edit Income",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
