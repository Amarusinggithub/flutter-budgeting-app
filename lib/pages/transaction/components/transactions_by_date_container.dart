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
        Text("Date: ${DateTime.fromMillisecondsSinceEpoch(index)}"),
        SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(), // Prevent nested scrolling
          itemCount: transactionsByDate.length,
          itemBuilder: (context, transactionIndex) => TransactionContainer(
            index: transactionIndex,
            transactionsByDate: transactionsByDate,
          ),
        ),
      ],
    );
  }
}
