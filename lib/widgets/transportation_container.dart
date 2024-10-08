import 'package:budgetingapp/generated/assets.dart';
import 'package:flutter/material.dart';

class TransportationContainer extends StatelessWidget {
  const TransportationContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(10),
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Image.asset(
        Assets.imagesTransportation,
        fit: BoxFit.contain,
      ),
    );
  }
}
