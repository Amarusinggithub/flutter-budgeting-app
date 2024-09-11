import 'package:budgetingapp/generated/assets.dart';
import 'package:flutter/material.dart';

class EntertainmentContainer extends StatelessWidget {
  const EntertainmentContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(10),
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.yellowAccent,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Image.asset(
        Assets.imagesEntertainment,
        fit: BoxFit.contain,
      ),
    );
  }
}
