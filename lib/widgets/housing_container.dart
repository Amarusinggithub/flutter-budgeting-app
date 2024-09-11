import 'package:budgetingapp/generated/assets.dart';
import 'package:flutter/material.dart';

class HousingContainer extends StatelessWidget {
  const HousingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(10),
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Image.asset(
        Assets.imagesHouse,
        fit: BoxFit.contain,
        height: 50,
        width: 50,
      ),
    );
  }
}
