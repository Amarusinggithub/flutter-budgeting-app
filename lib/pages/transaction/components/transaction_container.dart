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
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              getCategoryIcon(transaction),
              SizedBox(width: 10),
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
                  SizedBox(height: 5),
                  Text(
                    transaction.category,
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
                "transaction.date",
                // Assuming `time` is a property of `TransactionModel`
                style: TextStyle(
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
      case "Healthcare":
        return HealthcareContainer();
      default:
        return Container(); // You can define a default container or return a placeholder widget
    }
  }
}
