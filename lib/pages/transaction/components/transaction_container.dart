import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/transaction_model.dart';
import '../../../widgets/entertainment_container.dart';
import '../../../widgets/groceries_container.dart';
import '../../../widgets/healthcare_container.dart';
import '../../../widgets/housing_container.dart';
import '../../../widgets/shopping_container.dart';
import '../../../widgets/transportation_container.dart';
import '../../../widgets/utilities_container.dart';

class TransactionContainer extends StatelessWidget {
  final int index;
  final List<dynamic>? transactionsByDate;

  const TransactionContainer(
      {super.key, required this.index, required this.transactionsByDate});

  @override
  Widget build(BuildContext context) {
    final transaction = transactionsByDate![index];

    return Container(
      padding: const EdgeInsetsDirectional.all(5),
      height: 75,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              getCategoryIcon(transaction),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    transaction.category,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    transaction.title,
                    // Assuming `title` is a property of `TransactionModel`
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "-\$${transaction.amount}",
                // Assuming `amount` is a property of `TransactionModel`
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 5),
              Text(
                formatTime(transaction.date),
                // Assuming `time` is a property of `TransactionModel`
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget getCategoryIcon(TransactionModel transaction) {
    switch (transaction.category) {
      case "Housing":
        return const HousingContainer();
      case "Utilities":
        return const UtilitiesContainer();
      case "Transportation":
        return const TransportationContainer();
      case "Groceries":
        return const GroceriesContainer();
      case "Entertainment":
        return const EntertainmentContainer();
      case "Shopping":
        return const ShoppingContainer();
      case "Personal care":
        return const HealthcareContainer();
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
