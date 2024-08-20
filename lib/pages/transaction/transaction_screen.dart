import 'package:budgetingapp/models/transaction_model.dart';
import 'package:budgetingapp/pages/transaction/components/linechart_container.dart';
import 'package:budgetingapp/pages/transaction/components/transactions_by_date_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../budget/provider/budget_provider.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    final budgetProvider = Provider.of<BudgetProvider>(context);
    final savings = budgetProvider.currentBudget!.savings;
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
                const Text(
                  "Transactions",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                LinechartContainer(
                  points: budgetProvider.transactionPoints,
                  savings: savings,
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: List.generate(
                    budgetProvider.transactionsByDate.length,
                    (index) => TransactionsByDateContainer(
                      budgetProvider: budgetProvider,
                      index: index,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showTransactionBottomSheet(context, budgetProvider);
        },
        shape: const CircleBorder(),
        elevation: 0,
        child: const Icon(Icons.add), // Add an icon to the button
      ),
    );
  }

  void _showTransactionBottomSheet(
      BuildContext context, BudgetProvider budgetProvider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Transaction',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  budgetProvider.updateTransactionTitle(value);
                },
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  budgetProvider
                      .updateTransactionAmount(double.tryParse(value) ?? 0);
                },
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children:
                    List.generate(budgetProvider.categories.length, (index) {
                  final category = budgetProvider.categories[index];
                  return ChoiceChip(
                    label: Text(category.name),
                    selected: index == budgetProvider.selectedCategory,
                    onSelected: (selected) {
                      if (selected) {
                        budgetProvider.selectCategory(index);
                      }
                    },
                  );
                }),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ButtonStyle(
                  padding: WidgetStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 155),
                  ),
                  backgroundColor:
                      WidgetStateProperty.all<Color>(Colors.blueAccent),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                onPressed: () {
                  final newTransaction = TransactionModel(
                    title: budgetProvider.transactionTitle ?? '',
                    amount: budgetProvider.transactionAmount ?? 0,
                    date: DateTime.now().millisecondsSinceEpoch,
                    category: budgetProvider
                        .categories[budgetProvider.selectedCategory!].name,
                  );
                  budgetProvider.addTransaction(newTransaction);
                  budgetProvider
                      .clearTransactionInputs(); // Clear inputs after transaction is added
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Add',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
