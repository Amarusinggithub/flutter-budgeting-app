import 'package:budgetingapp/pages/profile/pages/privacy_policy_screen.dart';
import 'package:flutter/material.dart';

import '../../main/main_screen.dart';
import '../pages/help_and_support_screen.dart';

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 10),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(15),
        color: Colors.white,
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              MainScreen.pushNewScreen(context, const HelpSupportPage());
            },
            child: const Row(
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
                Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              MainScreen.pushNewScreen(context, const PrivacyPolicyPage());
            },
            child: const Row(
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
                Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
          )
        ],
      ),
    );
  }
}
