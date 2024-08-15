import 'package:budgetingapp/pages/transaction/components/transaction_point.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LinechartContainer extends StatelessWidget {
  final List<TransactionPoint> points;

  const LinechartContainer({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(), enabled: true),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    getTitlesWidget: (value, meta) => Text(
                          meta.formattedValue,
                        ),
                    showTitles: true)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          lineBarsData: [
            LineChartBarData(
              color: Color(0xFF6263F1),
              show: true,
              barWidth: 4,
              isCurved: true,
              preventCurveOverShooting: true,
              belowBarData: BarAreaData(
                  show: true, color: Color(0xFF6263F1).withOpacity(0.4)),
              spots: points.map((point) => FlSpot(point.x, point.y)).toList(),
            ),
          ],
          gridData: FlGridData(
            show: false,
          ),
          borderData: FlBorderData(
              border: Border(
                  right: BorderSide.none,
                  top: BorderSide.none,
                  bottom: BorderSide(),
                  left: BorderSide())),
        ),
      ),
    );
  }
}
