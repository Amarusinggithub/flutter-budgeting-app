import 'package:flutter/material.dart';

class HelpAndsupport extends StatelessWidget {
  const HelpAndsupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 10),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(15),
        color: Colors.white,
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.account_balance_wallet_rounded),
                      SizedBox(
                        width: 8,
                      ),
                      Text("Help and Support"),
                    ],
                  ),
                  Text("Edit")
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.account_balance_wallet_rounded),
                      SizedBox(
                        width: 8,
                      ),
                      Text("Privacy Policy"),
                    ],
                  ),
                  Text("Edit")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
