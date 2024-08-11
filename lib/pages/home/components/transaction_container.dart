import 'package:budgetingapp/pages/transaction/provider/transaction_provider.dart';
import 'package:flutter/material.dart';

class TransactionContainer extends StatelessWidget {
  final TransactionProvider transactionProvider;

  const TransactionContainer({super.key, required this.transactionProvider});

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
