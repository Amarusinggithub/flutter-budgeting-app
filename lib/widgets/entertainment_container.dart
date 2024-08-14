import 'package:budgetingapp/generated/assets.dart';
import 'package:flutter/material.dart';

class EntertainmentContainer extends StatelessWidget {
  const EntertainmentContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(10),
      height: 50,
      width: 50,
      child: Image.asset(
        Assets.imagesEntertainment,
        fit: BoxFit.contain,
      ),
      decoration: BoxDecoration(
        color: Colors.yellowAccent,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
