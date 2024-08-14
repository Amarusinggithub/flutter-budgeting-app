import 'package:budgetingapp/generated/assets.dart';
import 'package:flutter/material.dart';

class GroceriesContainer extends StatelessWidget {
  const GroceriesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(10),
      height: 50,
      width: 50,
      child: Image.asset(
        Assets.imagesGroceries,
        fit: BoxFit.contain,
      ),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
