import 'package:budgetingapp/pages/transaction/components/transaction_container.dart';
import 'package:budgetingapp/pages/transaction/provider/transaction_provider.dart';
import 'package:flutter/material.dart';

class TransactionsByDateContainer extends StatelessWidget {
  final int index;
  final TransactionProvider transactionProvider;

  const TransactionsByDateContainer(
      {super.key, required this.index, required this.transactionProvider});

  @override
  Widget build(BuildContext context) {
    final transactionsByDate = transactionProvider.getTransactionByDate(index);

    if (transactionsByDate == null || transactionsByDate.isEmpty) {
      return Container(
        padding: EdgeInsets.all(10),
        child: Text(
          "No transactions available for this day",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Today",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        ListView.builder(
          padding: const EdgeInsets.only(bottom: 10, top: 10),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          // Prevent nested scrolling
          itemCount: transactionsByDate.length,
          itemBuilder: (context, transactionIndex) => TransactionContainer(
            index: transactionIndex,
            transactionsByDate: transactionsByDate,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
