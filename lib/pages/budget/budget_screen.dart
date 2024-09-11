import 'package:budgetingapp/widgets/budget_for_the_month_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/budget_provider.dart';
import 'components/indicator.dart';
import 'components/piechart_container.dart';
import 'components/total_income_and_plan_to_spend_container.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final budgetProvider = Provider.of<BudgetProvider>(context);

    if (budgetProvider.currentBudget == null) {
      return const Center(child: CircularProgressIndicator());
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
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Budget",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _showBudgetBottomSheet(context, budgetProvider);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            backgroundColor: Colors.blueAccent,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const TotalIncomeAndPlanTOSpendContainer(),
                    const SizedBox(height: 30),
                    PieChartContainer(),
                    const SizedBox(height: 30),
                    const BudgetForTheMonthContainer(),
                    const SizedBox(height: 20),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Indicator(
                                color: Colors.blue,
                                text: 'Transportation',
                                isSquare: false),
                            SizedBox(height: 20),
                            Indicator(
                                color: Colors.orange,
                                text: 'Utilities',
                                isSquare: false),
                            SizedBox(height: 20),
                            Indicator(
                                color: Colors.purple,
                                text: 'Housing',
                                isSquare: false),
                            SizedBox(height: 20),
                            Indicator(
                                color: Colors.green,
                                text: 'Shopping',
                                isSquare: false),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Indicator(
                                color: Colors.yellow,
                                text: 'Entertainment',
                                isSquare: false),
                            SizedBox(height: 20),
                            Indicator(
                                color: Colors.red,
                                text: 'Groceries',
                                isSquare: false),
                            SizedBox(height: 20),
                            Indicator(
                                color: Colors.pink,
                                text: 'Personal care',
                                isSquare: false),
                            SizedBox(height: 20),
                            Indicator(
                                color: Colors.cyan,
                                text: 'Miscellaneous',
                                isSquare: false),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showBudgetBottomSheet(
      BuildContext context, BudgetProvider budgetProvider) {
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
                    'Edit Budget',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(height: 5),
                ...budgetProvider.currentBudget!.categories.map((category) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        category.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
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
                          labelStyle: const TextStyle(color: Colors.black87),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.4),
                        ),
                        onSubmitted: (value) {
                          category.planToSpend = double.tryParse(value) ?? 0;
                        },
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  );
                }),
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
                      budgetProvider.calculatePlanToSpend();
                      budgetProvider.updateTheBudgetHistoryInTheDatabase();
                      Navigator.of(context).pop(); // Close the bottom sheet
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
