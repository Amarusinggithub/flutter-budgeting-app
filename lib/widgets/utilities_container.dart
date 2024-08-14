import 'package:budgetingapp/generated/assets.dart';
import 'package:flutter/material.dart';

class UtilitiesContainer extends StatelessWidget {
  const UtilitiesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(10),
      height: 50,
      width: 50,
      child: Image.asset(
        Assets.imagesUtilities,
        fit: BoxFit.contain,
      ),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
