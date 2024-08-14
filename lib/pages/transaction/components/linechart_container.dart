import 'package:budgetingapp/pages/transaction/transaction_point.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LinechartContainer extends StatelessWidget {
  final List<TransactionPoint> points;

  const LinechartContainer({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(LineChartData(
          titlesData: FlTitlesData(
            show: true,
          ),
          lineBarsData: [
            LineChartBarData(
              color: Colors.blue,
              show: true,
              barWidth: 6,
              isCurved: true,
              preventCurveOverShooting: true,
              belowBarData:
                  BarAreaData(show: true, color: Colors.blue.withOpacity(0.4)),
              spots: points.map((point) => FlSpot(point.x, point.y)).toList(),
            )
          ])),
    );
  }
}
