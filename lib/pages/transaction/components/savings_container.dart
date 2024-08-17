import 'package:flutter/material.dart';

class SavingsContainer extends StatelessWidget {
  final double savings;

  const SavingsContainer({super.key, required this.savings});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.green,
      ),
      child: Column(
        children: [
          Text(
            "Savings",
            style:
                TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 17),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "\$$savings",
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
          )
        ],
      ),
    );
  }
}
