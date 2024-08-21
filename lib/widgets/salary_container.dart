import 'package:budgetingapp/generated/assets.dart';
import 'package:flutter/material.dart';

class SalaryContainer extends StatelessWidget {
  const SalaryContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(10),
      height: 65,
      width: 65,
      child: Image.asset(
        Assets.imagesMoney,
        fit: BoxFit.contain,
      ),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(18),
      ),
    );
  }
}
