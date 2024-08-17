import 'package:budgetingapp/models/budget_model.dart';
import 'package:flutter/material.dart';

import '../../../generated/assets.dart';

class CreditCard extends StatelessWidget {
  final BudgetModel budget;

  const CreditCard({super.key, required this.budget});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(20)),
        height: 180,
        width: 360,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Available Balance",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white.withOpacity(0.8)),
                      ),
                      Text(
                        "\$${budget.availableBalance}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 27,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 86,
                  ),
                  Image.asset(
                    fit: BoxFit.contain,
                    Assets.imagesCreditCard,
                    height: 30,
                    width: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    fit: BoxFit.contain,
                    Assets.imagesWifi,
                    height: 30,
                    width: 30,
                  )
                ],
              ),
              Row(
                children: [
                  const Text(
                    "**** **** **** 3456",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 93,
                  ),
                  Image.asset(
                    Assets.imagesMastercardLogo,
                    width: 53,
                    height: 53,
                  )
                ],
              )
            ],
          ),
        ));
  }
}
