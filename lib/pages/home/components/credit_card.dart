import 'package:budgetingapp/pages/budget/provider/budget_provider.dart';
import 'package:flutter/material.dart';

class CreditCard extends StatelessWidget {
  final BudgetProvider budgetProvider;

  const CreditCard({super.key, required this.budgetProvider});

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
            mainAxisAlignment: MainAxisAlignment.start,
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
                            color: Colors.white.withOpacity(0.6)),
                      ),
                      Text(
                        "\$3,500",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 27,
                            fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          "See Detials",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 86,
                  ),
                  Image.asset(
                    fit: BoxFit.contain,
                    "assets/images/credit-card.png",
                    height: 30,
                    width: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    fit: BoxFit.contain,
                    "assets/images/wifi.png",
                    height: 30,
                    width: 30,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
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
                    "assets/images/mastercard-logo.png",
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
