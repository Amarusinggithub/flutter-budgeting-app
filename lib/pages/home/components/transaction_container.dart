import 'package:flutter/material.dart';

class TransactionContainer extends StatelessWidget {
  const TransactionContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      child: const Row(
        children: [Text("Transaction")],
      ),
    );
  }
}
