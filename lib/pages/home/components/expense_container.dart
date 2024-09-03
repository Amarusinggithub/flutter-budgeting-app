import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/helper_functions.dart';
import '../../../provider/budget_provider.dart';

class ExpenseContainer extends StatelessWidget {
  const ExpenseContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final budgetProvider = Provider.of<BudgetProvider>(context);
    return Container(
      height: 140,
      width: 170,
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.7), // Updated red color
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsetsDirectional.all(10),
            height: 50,
            width: 50,
            child: Image.asset(
              "assets/images/expense.png",
              fit: BoxFit.contain,
            ),
            decoration: BoxDecoration(
              color: Color(0xFFD32F2F), // Updated red color
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Expense",
            style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
          Text(
            " ${HelperFunctions.numberCurrencyFormatter(budgetProvider.currentBudget!.expense)}",
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
