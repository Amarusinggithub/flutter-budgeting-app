import 'package:flutter/material.dart';

class AccountInfoContainer extends StatelessWidget {
  const AccountInfoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 10),
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(15),
          color: Colors.white,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.account_balance_wallet_rounded),
                SizedBox(
                  width: 8,
                ),
                Text("Account Info"),
              ],
            ),
            Text("Edit")
          ],
        ),
      ),
    );
  }
}
