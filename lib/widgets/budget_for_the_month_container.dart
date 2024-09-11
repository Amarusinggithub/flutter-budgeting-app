import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/utils/helper_functions.dart';
import '../provider/budget_provider.dart';

class BudgetForTheMonthContainer extends StatelessWidget {
  const BudgetForTheMonthContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final budgetProvider = Provider.of<BudgetProvider>(context);
    final width = budgetProvider.calculateTheBudgetPercentageForIndicator();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: ShapeDecoration(
        color: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Budget for this Month',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                // Use Expanded here to avoid overflow
                child: Text(
                  HelperFunctions.numberCurrencyFormatter(
                      budgetProvider.currentBudget!.planToSpend),
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Stack(
            children: [
              Container(
                width: 330,
                height: 8,
                decoration: ShapeDecoration(
                  color: const Color(0xFF93C5FD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(70),
                  ),
                ),
              ),
              Positioned(
                child: Container(
                  width: width ?? 250,
                  height: 8,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF60A5FA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(70),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'You have spent ${budgetProvider.calculateTheBudgetPercentage()}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                HelperFunctions.numberCurrencyFormatter(
                    budgetProvider.currentBudget!.expense),
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
