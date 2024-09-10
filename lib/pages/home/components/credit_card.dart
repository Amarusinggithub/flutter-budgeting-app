import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/helper_functions.dart';
import '../../../generated/assets.dart';
import '../../../provider/budget_provider.dart';

class CreditCard extends StatelessWidget {
  const CreditCard({super.key});

  @override
  Widget build(BuildContext context) {
    final budgetProvider = Provider.of<BudgetProvider>(context);

    return Container(
      width: 354.84,
      height: 190.0,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF42A5F5),
            Color(0xFF64B5F6),
            Color(0xFF1976D2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 0.4, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(5, 5),
            blurRadius: 10,
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Available Balance',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 18,
                  fontFamily: 'Readex Pro',
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: 0.5,
                ),
              ),
              const Spacer(),
              Image.asset(
                Assets.imagesCreditCard,
                fit: BoxFit.contain,
                height: 30,
                width: 30,
              ),
              const SizedBox(width: 10),
              Image.asset(
                Assets.imagesWifi,
                fit: BoxFit.contain,
                height: 30,
                width: 30,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              budgetProvider.isTotalBalanceVisible
                  ? Text(
                      budgetProvider.totalBalance != null
                          ? HelperFunctions.numberCurrencyFormatter(
                              budgetProvider.totalBalance!)
                          : "Loading...", // Handle null case
                      style: const TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 26,
                        fontFamily: 'Readex Pro',
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                        letterSpacing: 0.5,
                      ),
                    )
                  : const Text(
                      "\$**********",
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 26,
                        fontFamily: 'Readex Pro',
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                        letterSpacing: 0.5,
                      ),
                    ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  budgetProvider.makeTotalBalanceVisible();
                },
                child: Image.asset(
                  budgetProvider.isTotalBalanceVisible
                      ? Assets.imagesView
                      : Assets.imagesHide,
                  fit: BoxFit.contain,
                  height: 22,
                  width: 22,
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  _showBottomSheet(context, budgetProvider);
                },
                child: Image.asset(
                  Assets.imagesPencil,
                  fit: BoxFit.contain,
                  height: 22,
                  width: 22,
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '**** **** **** 1234',
                style: TextStyle(
                  color: Color(0xFFE3F2FD),
                  fontSize: 22,
                  fontFamily: 'Readex Pro',
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                  letterSpacing: 0.5,
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

  void _showBottomSheet(BuildContext context, BudgetProvider budgetProvider) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Edit Balances',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelText: 'Balance',
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  onSubmitted: (value) {
                    budgetProvider.totalBalance = double.tryParse(value) ?? 0;
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 120),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.blueAccent,
                    ),
                    onPressed: () {
                      budgetProvider.updateTheBudgetHistoryInTheDatabase();
                      budgetProvider.makeScreenRebuild();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Save Balances',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
