import 'package:budgetingapp/generated/assets.dart';
import 'package:budgetingapp/provider/budget_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/helper_functions.dart';

class IncomeContainer extends StatelessWidget {
  const IncomeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final budgetProvider = Provider.of<BudgetProvider>(context);
    return Container(
      height: 150,
      width: 170,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF43A047).withOpacity(0.9),
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF388E3C),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.asset(
                  Assets.imagesIncome,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 10),
              Image.asset(
                Assets.imagesPencil,
                fit: BoxFit.contain,
                height: 22,
                width: 22,
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            "Income",
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            HelperFunctions.numberCurrencyFormatter(
                budgetProvider.currentBudget!.income),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
