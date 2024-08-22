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
    final categories = budgetProvider.categories;
    final selectedCategoryIndex = transactionProvider.selectedCategory;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select a Category',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: List.generate(categories.length, (index) {
            final category = categories[index];
            return ChoiceChip(
              label: Text(category.name),
              selected: index == selectedCategoryIndex,
              onSelected: (selected) {
                if (selected) {
                  transactionProvider.selectCategory(
                      index); // Update the selected category index
                }
              },
            );
          }),
        ),
      ],
    );
  }
}
