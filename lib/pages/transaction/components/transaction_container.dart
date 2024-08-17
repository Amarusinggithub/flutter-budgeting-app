import 'package:flutter/material.dart';

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
              Container(
                padding: EdgeInsets.all(10),
                height: 50,
                width: 50,
                child: Image.asset(
                  "assets/images/expense.png",
                  fit: BoxFit.contain,
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
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
}
