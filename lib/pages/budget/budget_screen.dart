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
                  onPressed: () {
                    _showBudgetBottomSheet(context, budgetProvider);
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          const WidgetStatePropertyAll(Color(0xFFE0E0E0)),
                      iconColor: const WidgetStatePropertyAll(Colors.black),
                      iconSize: const WidgetStatePropertyAll(30),
                      padding: const WidgetStatePropertyAll(
                          EdgeInsetsDirectional.all(0)),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)))),
                  child: const Icon(
                    Icons.edit,
                    weight: 20,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TotalBalanceAndExpenseContainer(),
            const SizedBox(
              height: 50,
            ),
            PieChartContainer(),
          ],
        ),
      ))),
    );
  }

  void _showBudgetBottomSheet(
      BuildContext context, BudgetProvider budgetProvider) {
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
                    'Edit Budget',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelText: 'Income',
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  onSubmitted: (value) {
                    budgetProvider.updateIncome(double.tryParse(value) ?? 0);
                  },
                ),
                const SizedBox(height: 5),
                ...budgetProvider.currentBudget!.categories.map((category) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        category.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          labelText: 'Plan to spend',
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        onSubmitted: (value) {
                          category.planToSpend = double.tryParse(value) ?? 0;
                        },
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 120),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.blueAccent,
                    ),
                    onPressed: () {
                      // Update the budget history in the database
                      budgetProvider.updateTheBudgetHistoryInTheDatabase(
                          budgetProvider.budgetHistoryModel!);
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Save Budget',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
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
