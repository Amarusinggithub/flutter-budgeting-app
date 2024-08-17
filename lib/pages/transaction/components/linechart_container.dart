import 'package:budgetingapp/pages/transaction/components/savings_container.dart';
import 'package:budgetingapp/pages/transaction/components/transaction_point.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LinechartContainer extends StatelessWidget {
  final List<TransactionPoint> points;
  final double savings;

  const LinechartContainer(
      {super.key, required this.points, required this.savings});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.black.withOpacity(0.2),
            width: 0.5,
          )),
      padding: const EdgeInsetsDirectional.all(20),
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 1.4,
            child: LineChart(
              LineChartData(
                lineTouchData: const LineTouchData(
                    touchTooltipData: LineTouchTooltipData(), enabled: true),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                          getTitlesWidget: (value, meta) => Text(
                                meta.formattedValue,
                              ),
                          showTitles: true)),
                  leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                ),
                lineBarsData: [
                  LineChartBarData(
                    color: const Color(0xFF6263F1),
                    show: true,
                    barWidth: 4,
                    isCurved: true,
                    preventCurveOverShooting: true,
                    belowBarData: BarAreaData(
                        show: true,
                        color: const Color(0xFF6263F1).withOpacity(0.2)),
                    spots: points
                        .map((point) => FlSpot(point.x, point.y))
                        .toList(),
                  ),
                ],
                gridData: const FlGridData(
                  show: false,
                ),
                borderData: FlBorderData(
                    border: const Border(
                        right: BorderSide.none,
                        top: BorderSide.none,
                        bottom: BorderSide.none,
                        left: BorderSide.none)),
              ),
            ),
          ),
          Positioned(
              top: 10, left: 40, child: SavingsContainer(savings: savings))
        ],
      ),
    );
  }
}
