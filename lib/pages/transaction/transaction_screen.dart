import 'package:budgetingapp/models/transaction_model.dart';
import 'package:budgetingapp/pages/transaction/components/linechart_container.dart';
import 'package:budgetingapp/pages/transaction/components/transactions_by_date_container.dart';
import 'package:budgetingapp/provider/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/budget_provider.dart';
import 'components/budget_for_the_month_container.dart';
import 'components/data_slider_container.dart';
import 'components/select_category_container.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    final budgetProvider = Provider.of<BudgetProvider>(context);
    final transactionProvider = Provider.of<TransactionProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Transactions",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _showTransactionBottomSheet(
                            context, budgetProvider, transactionProvider);
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              const WidgetStatePropertyAll(Color(0xFFE0E0E0)),
                          iconColor: const WidgetStatePropertyAll(Colors.black),
                          iconSize: const WidgetStatePropertyAll(30),
                          padding: const WidgetStatePropertyAll(
                              EdgeInsetsDirectional.all(0)),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)))),
                      child: const Icon(
                        Icons.add,
                        weight: 20,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const DataSliderContainer(),
                const SizedBox(
                  height: 10,
                ),
                LineChartContainer(
                  provider: transactionProvider,
                ),
                const SizedBox(
                  height: 10,
                ),
                const BudgetForTheMonthContainer(),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: List.generate(
                    transactionProvider.transactionsByDate.length,
                    (index) => TransactionsByDateContainer(
                      transactionProvider: transactionProvider,
                      index: index,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showTransactionBottomSheet(BuildContext context,
      BudgetProvider budgetProvider, TransactionProvider transactionProvider) {
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
                const SizedBox(height: 20),
                TextField(
                  onChanged: (value) {
                    transactionProvider.updateTransactionTitle(value);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelText: 'Title',
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  onChanged: (value) {
                    transactionProvider
                        .updateTransactionAmount(double.tryParse(value) ?? 0);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelText: 'Amount',
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                SelectCategoryContainer(
                  transactionProvider: transactionProvider,
                  budgetProvider: budgetProvider,
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 120),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.blueAccent,
                    ),
                    onPressed: () {
                      final newTransaction = TransactionModel(
                        title: transactionProvider.transactionTitle ?? '',
                        amount: transactionProvider.transactionAmount ?? 0,
                        date: DateTime.now().millisecondsSinceEpoch,
                        category: budgetProvider
                            .categories[transactionProvider.selectedCategory!]
                            .name,
                      );
                      transactionProvider.addTransaction(newTransaction);
                      transactionProvider.clearTransactionInputs();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Add Expense',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
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
