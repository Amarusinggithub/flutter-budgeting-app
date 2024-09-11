import 'package:budgetingapp/core/utils/helper_functions.dart';
import 'package:budgetingapp/models/transaction_model.dart';
import 'package:budgetingapp/provider/transaction_provider.dart';
import 'package:budgetingapp/widgets/entertainment_container.dart';
import 'package:budgetingapp/widgets/groceries_container.dart';
import 'package:budgetingapp/widgets/healthcare_container.dart';
import 'package:budgetingapp/widgets/housing_container.dart';
import 'package:budgetingapp/widgets/shopping_container.dart';
import 'package:budgetingapp/widgets/transportation_container.dart';
import 'package:budgetingapp/widgets/utilities_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/transaction/components/select_category_container.dart';
import '../provider/budget_provider.dart';
import 'miscellaneous_container.dart';

class TransactionContainer extends StatelessWidget {
  final int index;
  final TransactionProvider transactionProvider;
  final Color iconBackgroundColor;

  const TransactionContainer({
    super.key,
    this.iconBackgroundColor = const Color(0xFFA0AEC0),
    required this.index,
    required this.transactionProvider,
  });

  @override
  Widget build(BuildContext context) {
    final transactionsByDate = transactionProvider.getTransactionByDate(0);

    if (transactionsByDate == null ||
        transactionsByDate.isEmpty ||
        index < 0 ||
        index >= transactionsByDate.length) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: const EdgeInsets.only(bottom: 10),
        height: 85,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            "No transaction available",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
            ),
          ),
        ),
      );
    }

    final transaction = transactionsByDate[index];

    return GestureDetector(
      onTap: () {
        _showEditTransactionBottomSheet(context, transaction);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: 370,
        height: 90,
        // Increased height for better layout
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        // Adjusted padding for balance
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            getCategoryIcon(transaction),
            const SizedBox(width: 16), // Adequate space between icon and text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          transaction.title,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          transaction.category,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "-${HelperFunctions.numberCurrencyFormatter(transaction.amount)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  HelperFunctions.formatTime(transaction.date),
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getCategoryIcon(TransactionModel transaction) {
    switch (transaction.category) {
      case "Housing":
        return const HousingContainer();
      case "Utilities":
        return const UtilitiesContainer();
      case "Transportation":
        return const TransportationContainer();
      case "Groceries":
        return const GroceriesContainer();
      case "Entertainment":
        return const EntertainmentContainer();
      case "Shopping":
        return const ShoppingContainer();
      case "Personal care":
        return const HealthcareContainer();
      case "Miscellaneous":
        return const MiscellaneousContainer();
      default:
        return Container();
    }
  }

  void _showEditTransactionBottomSheet(
    BuildContext context,
    TransactionModel transaction,
  ) {
    final budgetProvider = Provider.of<BudgetProvider>(context, listen: false);
    final transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);

    TextEditingController titleController =
        TextEditingController(text: transaction.title);
    TextEditingController amountController =
        TextEditingController(text: transaction.amount.toString());

    String originalCategory = transaction.category;
    double originalAmount = transaction.amount;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        return Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF1976D2),
                Color(0xFFF1F8E9),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
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
                const SizedBox(height: 20),
                const Text(
                  'Edit Transaction',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: titleController,
                  onChanged: (value) {
                    transactionProvider.updateTransactionTitle(value);
                  },
                  decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: const TextStyle(color: Colors.black87),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.4),
                  ),
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: amountController,
                  onChanged: (value) {
                    transactionProvider
                        .updateTransactionAmount(double.tryParse(value) ?? 0);
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    labelStyle: const TextStyle(color: Colors.black87),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.4),
                  ),
                ),
                const SizedBox(height: 20),
                const SelectCategoryContainer(),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      backgroundColor: Colors.blueAccent,
                      fixedSize: const Size(360, 55),
                    ),
                    onPressed: () async {
                      String newCategory = budgetProvider
                          .currentBudget!
                          .categories[transactionProvider.selectedCategory!]
                          .name;
                      double newAmount =
                          transactionProvider.transactionAmount ??
                              transaction.amount;

                      if (newCategory != originalCategory) {
                        await budgetProvider.decreaseCategorySpent(
                            originalCategory, originalAmount);
                        await budgetProvider.increaseCategorySpent(
                            newCategory, newAmount);
                      } else {
                        if (newAmount != originalAmount) {
                          double amountDifference = newAmount - originalAmount;
                          if (amountDifference > 0) {
                            await budgetProvider.increaseCategorySpent(
                                newCategory, amountDifference);
                          } else {
                            await budgetProvider.decreaseCategorySpent(
                                newCategory, amountDifference.abs());
                          }
                        }
                      }

                      TransactionModel updatedTransaction = TransactionModel(
                        title: transactionProvider.transactionTitle ??
                            transaction.title,
                        amount: newAmount,
                        date: transaction.date,
                        category: newCategory,
                      );
                      await transactionProvider
                          .editTransaction(updatedTransaction);

                      transactionProvider.clearTransactionInputs();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Save Changes',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
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
