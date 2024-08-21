import 'package:flutter/material.dart';

import '../../../provider/budget_provider.dart';

class SelectCategoryContainer extends StatelessWidget {
  final BudgetProvider budgetProvider;

  const SelectCategoryContainer({
    super.key,
    required this.budgetProvider,
  });

  @override
  Widget build(BuildContext context) {
    final categories = budgetProvider.categories;
    final selectedCategoryIndex = budgetProvider.selectedCategory;

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
                  budgetProvider.selectCategory(
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
