import 'package:budgetingapp/generated/assets.dart';
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
      height: 150,
      // Slightly increased height for more space
      width: 170,
      // Increased width for better layout
      padding: const EdgeInsets.all(12),
      // Uniform padding for consistency
      decoration: BoxDecoration(
        color: Colors.redAccent.withOpacity(0.9), // Updated to a richer red
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFD32F2F), // Consistent red for the icon
              borderRadius: BorderRadius.circular(15),
            ),
            child: Image.asset(
              Assets.imagesExpense,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 15), // Adjusted spacing
          Text(
            "Expense",
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              // Increased opacity for clarity
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            HelperFunctions.numberCurrencyFormatter(
                budgetProvider.currentBudget!.expense),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22, // Increased font size for emphasis
            ),
          ),
        ],
      ),
    );
  }
}
