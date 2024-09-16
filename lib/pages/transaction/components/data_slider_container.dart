import 'package:budgetingapp/provider/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataSliderContainer extends StatelessWidget {
  const DataSliderContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    return Container(
      width: 350,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      decoration: ShapeDecoration(
        color: Colors.white.withOpacity(0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildSliderOption(context, 'Daily', 0, transactionProvider),
          buildSliderOption(context, 'Weekly', 1, transactionProvider),
          buildSliderOption(context, 'Monthly', 2, transactionProvider),
        ],
      ),
    );
  }

  Widget buildSliderOption(BuildContext context, String text, int index,
      TransactionProvider transactionProvider) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          transactionProvider.setSelectedIndexForTransactionTime(index);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: ShapeDecoration(
            color: transactionProvider.selectedIndexForTransactionTime == index
                ? Colors.blueAccent
                : Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color:
                    transactionProvider.selectedIndexForTransactionTime == index
                        ? const Color(0xFFF3F3F3)
                        : const Color(0xFF323232),
                fontSize: 16,
                fontFamily: 'Readex Pro',
                fontWeight: FontWeight.w400,
                height: 1.5,
                letterSpacing: 0.10,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
