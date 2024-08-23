import 'package:budgetingapp/provider/budget_provider.dart';
import 'package:budgetingapp/provider/transaction_provider.dart';
import 'package:flutter/material.dart';

class SelectCategoryContainer extends StatelessWidget {
  final TransactionProvider transactionProvider;
  final BudgetProvider budgetProvider;

  const SelectCategoryContainer({
    super.key,
    required this.transactionProvider,
    required this.budgetProvider,
  });

  @override
  Widget build(BuildContext context) {
    final categories = budgetProvider.currentBudget?.categories;
    final selectedCategoryIndex = transactionProvider.selectedCategory;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select a Category',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: List.generate(categories!.length, (index) {
            final category = categories[index];
            return ChoiceChip(
              label: Text(category.name),
              selected: index == selectedCategoryIndex,
              onSelected: (selected) {
                if (selected) {
                  transactionProvider.selectCategory(index);
                }
              },
              selectedColor: Colors.blueAccent,
              labelStyle: TextStyle(
                color: index == selectedCategoryIndex
                    ? Colors.white
                    : Colors.grey[700],
              ),
              backgroundColor: Colors.grey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            );
          }),
        ),
      ],
    );
  }
}
