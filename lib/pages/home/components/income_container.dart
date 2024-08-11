import 'package:flutter/material.dart';

class IncomeContainer extends StatelessWidget {
  final double income;

  const IncomeContainer({super.key, required this.income});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 150,
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [Text("\$ $income")],
      ),
    );
  }
}
