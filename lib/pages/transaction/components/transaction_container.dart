import 'package:budgetingapp/core/utils/helper_functions.dart';
import 'package:flutter/material.dart';

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
                      fontSize: 15, // Adjusted font size for consistency
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    transaction.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15, // Adjusted font size for consistency
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
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15, // Adjusted font size for consistency
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                HelperFunctions.formatTime(transaction.date),
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15, // Adjusted font size for consistency
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
        return Container();
    }
  }
}
