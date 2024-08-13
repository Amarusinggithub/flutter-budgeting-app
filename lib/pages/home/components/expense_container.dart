import 'package:flutter/material.dart';

class ExpenseContainer extends StatelessWidget {
  final double expense;

  const ExpenseContainer({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 170,
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.7),
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
              color: Colors.red,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          SizedBox(
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
            "\$ $expense",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
