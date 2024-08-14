import 'package:budgetingapp/generated/assets.dart';
import 'package:flutter/material.dart';

class HealthcareContainer extends StatelessWidget {
  const HealthcareContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(10),
      height: 50,
      width: 50,
      child: Image.asset(
        Assets.imagesHealthcare,
        fit: BoxFit.contain,
      ),
      decoration: BoxDecoration(
        color: Colors.pinkAccent,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
