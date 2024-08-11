import 'package:flutter/material.dart';

class ExpenseContainer extends StatelessWidget {
  final double expense;

  const ExpenseContainer({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 150,
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [Text("\$ $expense")],
      ),
    );
  }
}
