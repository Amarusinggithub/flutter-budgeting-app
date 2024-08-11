import 'package:budgetingapp/pages/budget/provider/budget_provider.dart';
import 'package:budgetingapp/pages/home/components/credit_card.dart';
import 'package:budgetingapp/pages/transaction/provider/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
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
                    IconButton.outlined(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications,
                          color: Colors.black,
                        )),
                  ],
                ),
                const CreditCard(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ExpenseContainer(
                      expense: budget!.spentAmount,
                    ),
                    IncomeContainer(income: budget.income)
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                LinearPercentIndicator(
                  width: 170.0,
                  animation: true,
                  animationDuration: 1000,
                  lineHeight: 20.0,
                  leading: const Text("left content"),
                  trailing: const Text("right content"),
                  percent: 0.2,
                  center: const Text("20.0%"),
                  progressColor: Colors.red,
                  animateFromLastPercent: true,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Recent Transaction"),
                    GestureDetector(onTap: () {}, child: const Text("See All"))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: List.generate(10, (index) {
                    return TransactionContainer(
                        transactionProvider:
                            transactionProvider); // Adding each transaction item
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
