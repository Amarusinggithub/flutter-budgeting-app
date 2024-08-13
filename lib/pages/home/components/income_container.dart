import 'package:flutter/material.dart';

class IncomeContainer extends StatelessWidget {
  final double income;

  const IncomeContainer({super.key, required this.income});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 170,
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.8),
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
              color: Colors.green,
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
            "\$ $income",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
