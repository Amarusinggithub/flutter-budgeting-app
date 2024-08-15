import 'package:budgetingapp/pages/transaction/components/linechart_container.dart';
import 'package:budgetingapp/pages/transaction/components/transactions_by_date_container.dart';
import 'package:budgetingapp/pages/transaction/provider/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 25),
        child: Column(
          children: [
            Text(
              "${transactionProvider.currentDate().millisecondsSinceEpoch}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            LinechartContainer(points: transactionProvider.transactionPoints),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: transactionProvider.transactionsByDate.length,
                  itemBuilder: (context, index) => TransactionsByDateContainer(
                        transactionProvider: transactionProvider,
                        index: index,
                      )),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const CircleBorder(),
        elevation: 0,
      ),
    );
  }
}
