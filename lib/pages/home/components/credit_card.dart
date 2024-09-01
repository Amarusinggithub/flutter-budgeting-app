import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../generated/assets.dart';
import '../../../provider/budget_provider.dart';

class CreditCard extends StatelessWidget {
  const CreditCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final budgetProvider = Provider.of<BudgetProvider>(context);
    return Container(
      width: 354.84,
      height: 170.0,
      padding: const EdgeInsets.all(20),
      // Add padding to the container
      decoration: ShapeDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF42A5F5), Color(0xFF64B5F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Balance',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              // White text color
              fontSize: 16,
              fontFamily: 'Readex Pro',
              fontWeight: FontWeight.w500,
              height: 1.5,
              letterSpacing: 0.10,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            budgetProvider
                .numberCurrencyFormater(budgetProvider.totalBalanceModel!),
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              // White text color
              fontSize: 24,
              fontFamily: 'Readex Pro',
              fontWeight: FontWeight.bold,
              height: 1.2,
              letterSpacing: 0.10,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '**** **** **** 1234',
                style: TextStyle(
                  color: Color(0xFFE3F2FD),
                  // Light blue-grey text color
                  fontSize: 16,
                  fontFamily: 'Readex Pro',
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                  letterSpacing: 0.10,
                ),
              ),
              Image.asset(
                Assets.imagesMastercardLogo,
                fit: BoxFit.contain,
                height: 56,
                width: 60,
              )
            ],
          ),
        ],
      ),
    );
  }
}
