import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/budget_provider.dart';

class DataSliderContainer extends StatelessWidget {
  const DataSliderContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final budgetProvider = Provider.of<BudgetProvider>(context);
    return Container(
      width: 350,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      decoration: ShapeDecoration(
        color: Color(0xFFE0E0E0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // Ensures full width is used
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildSliderOption(context, 'Daily', 0, budgetProvider),
          buildSliderOption(context, 'Weekly', 1, budgetProvider),
          buildSliderOption(context, 'Monthly', 2, budgetProvider),
        ],
      ),
    );
  }

  Widget buildSliderOption(BuildContext context, String text, int index,
      BudgetProvider budgetProvider) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          budgetProvider.setSelectedIndexForTransactionTime(index);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: ShapeDecoration(
            color: budgetProvider.selectedIndexForTransactionTime == index
                ? Color(0xFF323232)
                : Color(0xFFE0E0E0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: budgetProvider.selectedIndexForTransactionTime == index
                    ? Color(0xFFF3F3F3) // Light text color for selected
                    : Color(0xFF323232),
                // Dark text color for unselected
                fontSize: 16,
                fontFamily: 'Readex Pro',
                fontWeight: FontWeight.w400,
                height: 1.5,
                letterSpacing: 0.10,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
