import 'package:budgetingapp/provider/budget_provider.dart';
import 'package:flutter/material.dart';

class IncomeContainer extends StatelessWidget {
  final BudgetProvider budgetProvider;

  const IncomeContainer({super.key, required this.budgetProvider});

  @override
  Widget build(BuildContext context) {
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
            padding: EdgeInsetsDirectional.all(10),
            height: 50,
            width: 50,
            child: Image.asset(
              "assets/images/income.png",
              fit: BoxFit.contain,
            ),
            decoration: BoxDecoration(
              color: Color(0xFF388E3C), // Updated green color
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          SizedBox(
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
            budgetProvider
                .numberCurrencyFormater(budgetProvider.currentBudget!.income),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
