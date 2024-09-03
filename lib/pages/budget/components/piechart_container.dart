import 'package:budgetingapp/provider/budget_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'indicator.dart';

class PieChartContainer extends StatelessWidget {
  PieChartContainer({
    super.key,
  });

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

    return Column(
      children: [
        SizedBox(
          height: 300,
          child: AspectRatio(
            aspectRatio: 1.4,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  },
                ),
                borderData: FlBorderData(show: false),
                sectionsSpace: 0,
                centerSpaceRadius: 30,
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
          ),
        ),
        const SizedBox(height: 30),
        // Indicators for the pie chart sections
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Indicator(
                    color: Colors.blue,
                    text: 'Transportation',
                    isSquare: false),
                SizedBox(height: 20),
                Indicator(
                    color: Colors.orange, text: 'Utilities', isSquare: false),
                SizedBox(height: 20),
                Indicator(
                    color: Colors.purple, text: 'Housing', isSquare: false),
                SizedBox(height: 20),
                Indicator(
                    color: Colors.green, text: 'Shopping', isSquare: false),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Indicator(
                    color: Colors.yellow,
                    text: 'Entertainment',
                    isSquare: false),
                SizedBox(height: 20),
                Indicator(
                    color: Colors.red, text: 'Groceries', isSquare: false),
                SizedBox(height: 20),
                Indicator(
                    color: Colors.pink, text: 'Personal care', isSquare: false),
              ],
            ),
          ],
        ),
      ],
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
      final fontSize = isTouched ? 28.0 : 18.0;
      final radius = isTouched ? 80.0 : 70.0;
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
          );
        default:
          throw Error();
      }
    });
  }
}
