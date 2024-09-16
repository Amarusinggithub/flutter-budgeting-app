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
          const EdgeInsetsDirectional.symmetric(vertical: 12, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(15),
        color: Colors.white.withOpacity(0.4),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              MainContent.pushNewScreen(context, const HelpSupportPage());
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.help_outline, size: 24, color: Colors.white),
                    SizedBox(width: 12),
                    Text(
                      "Help and Support",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ],
                ),
                Icon(Icons.arrow_forward_ios, size: 18, color: Colors.white),
              ],
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              MainContent.pushNewScreen(context, const PrivacyPolicyPage());
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.policy_outlined, size: 24, color: Colors.white),
                    SizedBox(width: 12),
                    Text(
                      "Privacy Policy",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ],
                ),
                Icon(Icons.arrow_forward_ios, size: 18, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
