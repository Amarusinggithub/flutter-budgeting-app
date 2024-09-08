import 'package:budgetingapp/provider/budget_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PieChartContainer extends StatelessWidget {
  PieChartContainer({super.key});

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final budgetProvider = Provider.of<BudgetProvider>(context);
    if (budgetProvider.currentBudget == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final utilities = budgetProvider.getCategoryPlanToSpend("Utilities");
    final transportation =
        budgetProvider.getCategoryPlanToSpend("Transportation");
    final housing = budgetProvider.getCategoryPlanToSpend("Housing");
    final shopping = budgetProvider.getCategoryPlanToSpend("Shopping");
    final entertainment =
        budgetProvider.getCategoryPlanToSpend("Entertainment");
    final personalCare = budgetProvider.getCategoryPlanToSpend("Personal care");
    final groceries = budgetProvider.getCategoryPlanToSpend("Groceries");

    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 260, // Increased the size to reduce fuzziness
            width: 260,
            child: Stack(
              children: [
                PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      },
                    ),
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 5,
                    centerSpaceRadius: 75,
                    // Increased center space
                    sections: _showingSections(
                      utilities,
                      transportation,
                      housing,
                      shopping,
                      entertainment,
                      groceries,
                      personalCare,
                      context,
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Expense',
                        style: TextStyle(
                          fontSize: 20, // Adjusted text size
                          color: Colors.white54,
                        ),
                      ),
                      Text(
                        '\$${budgetProvider.currentBudget!.expense}',
                        style: const TextStyle(
                          fontSize: 24, // Adjusted text size
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _showingSections(
      double utilities,
      double transportation,
      double housing,
      double shopping,
      double entertainment,
      double groceries,
      double personalCare,
      BuildContext context) {
    final budgetProvider = Provider.of<BudgetProvider>(context);
    return List.generate(budgetProvider.currentBudget!.categories.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize =
          isTouched ? 24.0 : 18.0; // Increased font size for clarity
      final radius = isTouched ? 85.0 : 70.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: transportation,
            title:
                '${budgetProvider.calculatePercentageOfTotalPlanToSpend(transportation)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.6),
              width: isTouched ? 4 : 2,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.orange,
            value: utilities,
            title:
                '${budgetProvider.calculatePercentageOfTotalPlanToSpend(utilities)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.6),
              width: isTouched ? 4 : 2,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.purple,
            value: housing,
            title:
                '${budgetProvider.calculatePercentageOfTotalPlanToSpend(housing)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.6),
              width: isTouched ? 4 : 2,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.green,
            value: shopping,
            title:
                '${budgetProvider.calculatePercentageOfTotalPlanToSpend(shopping)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.6),
              width: isTouched ? 4 : 2,
            ),
          );
        case 4:
          return PieChartSectionData(
            color: Colors.yellow,
            value: entertainment,
            title:
                '${budgetProvider.calculatePercentageOfTotalPlanToSpend(entertainment)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.6),
              width: isTouched ? 4 : 2,
            ),
          );
        case 5:
          return PieChartSectionData(
            color: Colors.red,
            value: groceries,
            title:
                '${budgetProvider.calculatePercentageOfTotalPlanToSpend(groceries)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.6),
              width: isTouched ? 4 : 2,
            ),
          );
        case 6:
          return PieChartSectionData(
            color: Colors.pink,
            value: personalCare,
            title:
                '${budgetProvider.calculatePercentageOfTotalPlanToSpend(personalCare)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.6),
              width: isTouched ? 4 : 2,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
