import 'package:budgetingapp/pages/budget/provider/budget_provider.dart';
import 'package:flutter/material.dart';

class SelectCategoryContainer extends StatelessWidget {
  final BudgetProvider budgetProvider;

  const SelectCategoryContainer({
    super.key,
    required this.budgetProvider,
  });

  @override
  Widget build(BuildContext context) {
    final categories = budgetProvider.categories;
    final selectedCategoryIndex =
        categories.indexOf(budgetProvider.selectedCategory!);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select a Category',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ToggleButtons(
          isSelected: categories
              .asMap()
              .entries
              .map((entry) => entry.key == selectedCategoryIndex)
              .toList(),
          onPressed: (index) {
            budgetProvider.selectCategory(categories[index]);
          },
          children: categories.map((category) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(category.name!),
            );
          }).toList(),
        ),
      ],
    );
  }
}
