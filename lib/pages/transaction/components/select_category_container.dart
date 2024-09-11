import 'package:budgetingapp/provider/budget_provider.dart';
import 'package:budgetingapp/provider/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectCategoryContainer extends StatelessWidget {
  const SelectCategoryContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final budgetProvider = Provider.of<BudgetProvider>(context);
    final transactionProvider = Provider.of<TransactionProvider>(context);

    final categories = budgetProvider.currentBudget?.categories ?? [];
    final selectedCategoryIndex = transactionProvider.selectedCategory;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select a Category',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: List.generate(categories.length, (index) {
            final category = categories[index];
            return ChoiceChip(
              elevation: 4,
              checkmarkColor: Colors.white,
              side: const BorderSide(style: BorderStyle.none),
              avatarBorder:
                  const OutlineInputBorder(borderSide: BorderSide.none),
              chipAnimationStyle: ChipAnimationStyle(
                  selectAnimation: AnimationStyle(
                      duration: const Duration(milliseconds: 1000))),
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
              backgroundColor: Colors.white.withOpacity(0.4),
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
