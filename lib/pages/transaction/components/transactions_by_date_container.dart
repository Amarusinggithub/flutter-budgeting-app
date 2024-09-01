import 'package:budgetingapp/models/transaction_model.dart';
import 'package:budgetingapp/pages/transaction/components/transaction_container.dart';
import 'package:budgetingapp/provider/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransactionsByDateContainer extends StatelessWidget {
  final int index;

  const TransactionsByDateContainer({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);

    final transactionsByDate = transactionProvider.getTransactionByDate(index);

    if (transactionsByDate == null || transactionsByDate.isEmpty) {
      return Container(
        padding: EdgeInsets.all(10),
        child: const Text(
          "No transactions available for this day",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${getDate(transactionsByDate)}",
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

  String getDate(List<TransactionModel> transactions) {
    final DateTime now = DateTime.now();
    final DateTime transactionDate =
        DateTime.fromMillisecondsSinceEpoch(transactions.first.date);

    // Get the start of the current week (Sunday)
    final DateTime startOfWeek = now.subtract(Duration(days: now.weekday % 7));
    // Get the end of the current week (Saturday)
    final DateTime endOfWeek = startOfWeek.add(Duration(days: 6));

    // Format the date and day of the week
    final String formattedDate =
        DateFormat('MMM dd, yyyy').format(transactionDate);
    final String formattedDay = DateFormat('EEEE').format(transactionDate);

    if (transactionDate.day == now.day &&
        transactionDate.month == now.month &&
        transactionDate.year == now.year) {
      return "Today";
    } else if (transactionDate.day == now.day - 1 &&
        transactionDate.month == now.month &&
        transactionDate.year == now.year) {
      return "Yesterday";
    } else if (transactionDate.isAfter(startOfWeek) &&
        transactionDate.isBefore(endOfWeek.add(Duration(days: 1)))) {
      // If the date is within the current week, return the day of the week
      return formattedDay;
    } else {
      return formattedDate;
    }
  }
}
