import 'package:budgetingapp/pages/home/components/credit_card.dart';
import 'package:budgetingapp/pages/home/components/no_transaction_container.dart';
import 'package:budgetingapp/pages/main/main_screen.dart';
import 'package:budgetingapp/pages/transaction/transaction_screen.dart';
import 'package:budgetingapp/provider/transaction_provider.dart';
import 'package:budgetingapp/widgets/transaction_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/budget_provider.dart';
import 'components/expense_container.dart';
import 'components/income_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final budgetProvider = Provider.of<BudgetProvider>(context);
    final budget = budgetProvider.currentBudget;
    final transactionProvider = Provider.of<TransactionProvider>(context);

    if (budget == null) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome Back!",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          "Amar Campbell",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: const CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                CreditCard(budgetProvider: budgetProvider),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IncomeContainer(budgetProvider: budgetProvider),
                    ExpenseContainer(budgetProvider: budgetProvider),
                  ],
                ),
                const SizedBox(
                  width: 354.0,
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Recent Transaction",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        MainScreen.pushNewScreen(
                            context, const TransactionScreen(),
                            isNavBarItem: true, tabIndex: 1);
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Text(
                          "See All",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black,
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
                        transactionProvider.transactionsByDate.last.isNotEmpty
                    ? Column(
                        children: List.generate(
                            transactionProvider.transactionsByDate[0].length,
                            (index) {
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
    );
  }

  void _showBottomSheet(BuildContext context, BudgetProvider budgetProvider) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        return Padding(
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
                    'Edit Balances ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelText: 'Total Balance',
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  onSubmitted: (value) {
                    budgetProvider.totalBalanceModel =
                        double.tryParse(value) ?? 0;
                  },
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 120),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.blueAccent,
                    ),
                    onPressed: () {
                      // Calculate the total expenses by summing up all category expenditures

                      budgetProvider.updateTheBudgetHistoryInTheDatabase(
                          budgetProvider.budgetHistoryModel!);
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Save Balances',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
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
