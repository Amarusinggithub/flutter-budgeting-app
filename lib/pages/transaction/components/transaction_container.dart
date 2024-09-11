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

  const TransactionContainer({
    super.key,
    required this.index,
    required this.transactionsByDate,
  });

  @override
  Widget build(BuildContext context) {
    final transaction = transactionsByDate![index];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      margin: const EdgeInsets.only(bottom: 10),
      height: 85,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              getCategoryIcon(transaction),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    transaction.category,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    transaction.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: Colors.black54,
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
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                HelperFunctions.formatTime(transaction.date),
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: Colors.black54,
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
