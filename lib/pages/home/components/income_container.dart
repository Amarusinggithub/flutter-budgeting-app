import 'package:budgetingapp/generated/assets.dart';
import 'package:budgetingapp/provider/budget_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/helper_functions.dart';

class IncomeContainer extends StatelessWidget {
  const IncomeContainer({super.key, r});

  @override
  Widget build(BuildContext context) {
    final budgetProvider = Provider.of<BudgetProvider>(context);
    return Container(
      height: 140,
      width: 170,
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.8), // Updated green color
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsetsDirectional.all(10),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF388E3C), // Updated green color
              borderRadius: BorderRadius.circular(15),
            ),
            child: Image.asset(
              Assets.imagesIncome,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Income",
            style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
          Text(
            HelperFunctions.numberCurrencyFormatter(
                budgetProvider.currentBudget!.income),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
