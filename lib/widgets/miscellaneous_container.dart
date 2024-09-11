import 'package:flutter/material.dart';

import '../generated/assets.dart';

class MiscellaneousContainer extends StatelessWidget {
  const MiscellaneousContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(10),
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.cyan,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Image.asset(
        Assets.imagesMiscellaneous,
        fit: BoxFit.contain,
      ),
    );
  }
}
