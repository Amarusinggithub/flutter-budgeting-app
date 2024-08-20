import 'package:budgetingapp/pages/budget/components/piechart_container.dart';
import 'package:budgetingapp/pages/budget/provider/budget_provider.dart';
import 'package:budgetingapp/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            TotalBalanceAndExpenseContainer(
              budgetProvider: budgetProvider,
            ),
            const SizedBox(
              height: 70,
            ),
            const PieChartContainer(),
            SizedBox(
              height: 100,
            ),
            CustomButton(text: "Make a Budget", onPressed: () {})
          ],
        ),
      ))),
    );
  }
}
