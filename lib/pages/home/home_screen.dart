import 'package:budgetingapp/pages/budget/provider/budget_provider.dart';
import 'package:budgetingapp/pages/home/components/credit_card.dart';
import 'package:budgetingapp/pages/main/main_screen.dart';
import 'package:budgetingapp/pages/transaction/provider/transaction_provider.dart';
import 'package:budgetingapp/pages/transaction/transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/expense_container.dart';
import 'components/income_container.dart';
import 'components/transaction_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final budgetProvider = Provider.of<BudgetProvider>(context);
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final budget = budgetProvider.budget;

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
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                CreditCard(
                  budget: budget,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IncomeContainer(income: budget.income),
                    ExpenseContainer(
                      expense: budget.expense,
                    ),
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
                          MainScreen.pushNewScreen(context, TransactionScreen(),
                              isNavBarItem: true, tabIndex: 1);
                        },
                        child: Container(
                          child: const Text(
                            "See All",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.blue),
                          ),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: List.generate(6, (index) {
                    return TransactionContainer(
                        transactionProvider: transactionProvider, index: index);
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
