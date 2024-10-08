import 'package:flutter/material.dart';

class ShoppingContainer extends StatelessWidget {
  const ShoppingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(10),
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Image.asset(
        "assets/images/shopping.png",
        fit: BoxFit.contain,
      ),
    );
  }
}
