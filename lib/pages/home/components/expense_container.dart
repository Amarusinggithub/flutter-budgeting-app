import 'package:flutter/material.dart';

class ExpenseContainer extends StatelessWidget {
  const ExpenseContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 150,
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
