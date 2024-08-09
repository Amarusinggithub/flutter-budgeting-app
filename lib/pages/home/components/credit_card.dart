import 'package:flutter/material.dart';

class CreditCard extends StatelessWidget {
  const CreditCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        height: 220,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.purple,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 16,
                        left: 16,
                        child: Image.asset(
                          "assets/images/credit-card.png",
                          height: 30,
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 70,
                        child: Image.asset(
                          "assets/images/wifi.png",
                          height: 30,
                          color: Colors.white,
                        ),
                      ),
                      const Positioned(
                        bottom: 16,
                        left: 16,
                        child: Text(
                          "**** **** **** 5054",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.purpleAccent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "\$10,300.00",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Image.asset(
                            "assets/images/mastercard-logo.png",
                            height: 50,
                            width: 50,
                          )
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ));
  }
}
