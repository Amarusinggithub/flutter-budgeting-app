import 'package:budgetingapp/pages/transaction/provider/transaction_provider.dart';
import 'package:flutter/material.dart';

class TransactionContainer extends StatelessWidget {
  final int index;
  final TransactionProvider transactionProvider;

  const TransactionContainer(
      {super.key, required this.transactionProvider, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsetsDirectional.all(10),
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
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Category",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Title",
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "-\$500",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.red),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "7:50pm",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
              ),
            ],
          )
        ],
      ),
    );
  }
}
