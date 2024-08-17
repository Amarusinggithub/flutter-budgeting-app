import 'package:budgetingapp/models/transaction_model.dart';
import 'package:budgetingapp/pages/transaction/components/linechart_container.dart';
import 'package:budgetingapp/pages/transaction/components/transactions_by_date_container.dart';
import 'package:budgetingapp/pages/transaction/provider/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../budget/provider/budget_provider.dart';
import 'components/select_category_container.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final budgetProvider = Provider.of<BudgetProvider>(context);
    final savings = budgetProvider.budget!.savings;
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
                  points: transactionProvider.transactionPoints,
                  savings: savings,
                ),
                const SizedBox(
                  height: 20,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showTransactionBottomSheet(
              context, transactionProvider, budgetProvider);
        },
        shape: const CircleBorder(),
        elevation: 0,
        child: const Icon(Icons.add), // Add an icon to the button
      ),
    );
  }

  void _showTransactionBottomSheet(BuildContext context,
      TransactionProvider transactionProvider, BudgetProvider budgetProvider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      builder: (context) {
        final titleController = TextEditingController();
        final amountController = TextEditingController();

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
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: amountController,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              SelectCategoryContainer(budgetProvider: budgetProvider),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 155),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blueAccent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                onPressed: () {
                  final newTransaction = TransactionModel(
                    id: '',
                    // You might want to generate a unique ID here
                    title: titleController.text,
                    amount: double.tryParse(amountController.text) ?? 0,
                    date: DateTime.now().millisecondsSinceEpoch,
                    category: budgetProvider.selectedCategory?.name ?? '',
                  );
                  transactionProvider.addTransaction(newTransaction);
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
