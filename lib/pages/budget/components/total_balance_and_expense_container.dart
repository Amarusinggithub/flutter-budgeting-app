import 'package:flutter/material.dart';

import '../../../provider/budget_provider.dart';

class TotalBalanceAndExpenseContainer extends StatelessWidget {
  final BudgetProvider budgetProvider;

  const TotalBalanceAndExpenseContainer(
      {super.key, required this.budgetProvider});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[300], // Inverted background color (light)
        borderRadius:
            BorderRadius.circular(15), // Rounded corners for a smooth look
      ),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Income",
                style: TextStyle(
                  color: Colors.black54, // Inverted text color (dark)
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                budgetProvider.numberCurrencyFormater(
                    budgetProvider.currentBudget!.income),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
            child: VerticalDivider(
              color: Colors.white30,
              thickness: 1,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Total Expense",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                budgetProvider.numberCurrencyFormater(
                    budgetProvider.calculateTotalExpenseForTheMonth()),
                style: const TextStyle(
                  color: Colors.black, // Inverted text color (darker)
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
