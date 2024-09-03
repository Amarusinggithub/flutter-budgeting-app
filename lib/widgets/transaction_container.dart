import 'package:budgetingapp/core/utils/helper_functions.dart';
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
        child: const Center(
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
                    fontSize: 14, // Adjusted font size for consistency
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  transaction.title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14, // Adjusted font size for consistency
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
                "-${HelperFunctions.numberCurrencyFormatter(transaction.amount)}",
                // Assuming `amount` is a property of `TransactionModel`
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14, // Adjusted font size for consistency
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                HelperFunctions.formatTime(transaction.date),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14, // Adjusted font size for consistency
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
