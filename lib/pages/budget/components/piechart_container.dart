import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'indicator.dart';

class PieChartContainer extends StatelessWidget {
  const PieChartContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400, // Fixed height for the container
      child: Column(
        children: [
          const SizedBox(height: 18),
          SizedBox(
            height: 200,
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      // Interaction can be added here
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 0,
                  centerSpaceRadius: 90,
                  sections: _showingSections(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 60),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Indicator(
                      color: Colors.blue, text: 'Housing', isSquare: true),
                  SizedBox(height: 4),
                  Indicator(
                      color: Colors.blue,
                      text: 'Transportation',
                      isSquare: true),
                  SizedBox(height: 4),
                  Indicator(
                      color: Colors.blue, text: 'Utilities', isSquare: true),
                  SizedBox(height: 4),
                  Indicator(
                      color: Colors.blue, text: 'Groceries', isSquare: true),
                  SizedBox(height: 18),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Indicator(
                      color: Colors.blue, text: 'Healthcare', isSquare: true),
                  SizedBox(height: 4),
                  Indicator(
                      color: Colors.blue,
                      text: 'Entertainment',
                      isSquare: true),
                  SizedBox(height: 4),
                  Indicator(
                      color: Colors.blue, text: 'Shopping', isSquare: true),
                  SizedBox(height: 18),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _showingSections() {
    return List.generate(4, (i) {
      final fontSize = 16.0;
      final radius = 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.blue,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.blue,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.blue,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
