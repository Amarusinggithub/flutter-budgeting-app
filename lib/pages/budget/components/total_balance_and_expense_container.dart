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
            children: const [
              Text(
                "Total Balance",
                style: TextStyle(
                  color: Colors.black54, // Inverted text color (dark)
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "\$48,000",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          VerticalDivider(
            width: 20,
            color: Colors.black45,
            thickness: 1,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Total Expense",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "\$25,000",
                style: TextStyle(
                  color: Colors.black, // Inverted text color (darker)
                  fontSize: 24,
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
