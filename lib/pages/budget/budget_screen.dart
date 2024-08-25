import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/budget_provider.dart';
import 'components/piechart_container.dart';
import 'components/total_balance_and_expense_container.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final budgetProvider = Provider.of<BudgetProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Budget",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Color(0xFFE0E0E0)),
                      iconColor: WidgetStatePropertyAll(Colors.black),
                      iconSize: WidgetStatePropertyAll(30),
                      padding: const WidgetStatePropertyAll(
                          EdgeInsetsDirectional.all(0)),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)))),
                  child: Icon(
                    Icons.edit,
                    weight: 20,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TotalBalanceAndExpenseContainer(
              budgetProvider: budgetProvider,
            ),
            const SizedBox(
              height: 50,
            ),
            const PieChartContainer(),
          ],
        ),
      ))),
    );
  }
}
