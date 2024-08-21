import 'package:budgetingapp/generated/assets.dart';
import 'package:flutter/material.dart';

class UtilitiesContainer extends StatelessWidget {
  const UtilitiesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(10),
      height: 65,
      width: 65,
      child: Image.asset(
        Assets.imagesUtilities,
        fit: BoxFit.contain,
      ),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(18),
      ),
    );
  }
}
