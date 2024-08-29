import 'package:budgetingapp/models/transaction_model.dart';
import 'package:budgetingapp/provider/transaction_provider.dart';
import 'package:budgetingapp/widgets/entertainment_container.dart';
import 'package:budgetingapp/widgets/groceries_container.dart';
import 'package:budgetingapp/widgets/healthcare_container.dart';
import 'package:budgetingapp/widgets/housing_container.dart';
import 'package:budgetingapp/widgets/shopping_container.dart';
import 'package:budgetingapp/widgets/transportation_container.dart';
import 'package:budgetingapp/widgets/utilities_container.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionContainer extends StatelessWidget {
  final int index;
  final TransactionProvider transactionProvider;
  final Color iconBackgroundColor;

  const TransactionContainer({
    super.key,
    this.iconBackgroundColor = const Color(0xFFA0AEC0),
    required this.index,
    required this.transactionProvider,
  });

  @override
  Widget build(BuildContext context) {
    final transactionsByDate = transactionProvider.getTransactionByDate(0);

    if (transactionsByDate == null ||
        transactionsByDate.isEmpty ||
        index < 0 ||
        index >= transactionsByDate.length) {
      return Container(
        width: 370,
        height: 79,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            "No transaction available",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
            ),
          ),
        ),
      );
    }

    final transaction = transactionsByDate[index];

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: 370,
      height: 79,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          getCategoryIcon(transaction),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  transaction.category,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  transaction.title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${transaction.amount}",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 6),
              Text(
                formatTime(transaction.date),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getCategoryIcon(TransactionModel transaction) {
    switch (transaction.category) {
      case "Housing":
        return HousingContainer();
      case "Utilities":
        return UtilitiesContainer();
      case "Transportation":
        return TransportationContainer();
      case "Groceries":
        return GroceriesContainer();
      case "Entertainment":
        return EntertainmentContainer();
      case "Shopping":
        return ShoppingContainer();
      case "Personal care":
        return HealthcareContainer();
      default:
        return Container(); // You can define a default container or return a placeholder widget
    }
  }

  String formatTime(int epochMillis) {
    // Convert the epoch time to a DateTime object
    final DateTime parsedTime =
        DateTime.fromMillisecondsSinceEpoch(epochMillis);

    // Format the time to include hour, minute, and AM/PM without leading zeros for the hour
    final String formattedTime =
        DateFormat('h:m a', 'en_US').format(parsedTime);

    return formattedTime;
  }
}
