import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/helper_functions.dart';
import '../../../provider/budget_provider.dart';

class SavingsContainer extends StatelessWidget {
  const SavingsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final budgetProvider = Provider.of<BudgetProvider>(context);

    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.green,
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Column(
        children: [
          const Text(
            'Savings',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 13,
              fontFamily: 'Readex Pro',
              fontWeight: FontWeight.w600,
              height: 1.5,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            HelperFunctions.numberCurrencyFormatter(
              budgetProvider.calculateSavings(),
            ), // Handle null case
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontFamily: 'Readex Pro',
              fontWeight: FontWeight.bold,
              height: 1.2,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
