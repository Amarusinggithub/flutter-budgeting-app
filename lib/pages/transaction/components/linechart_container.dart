import 'package:budgetingapp/pages/transaction/components/transaction_point.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartContainer extends StatelessWidget {
  final List<TransactionPoint> points;

  const LineChartContainer({super.key, required this.points});

  List<Color> get gradientColors => [
        const Color(0xFF007AFF),
        const Color(0xFF00A2FF),
      ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Ensure the container's background is white
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white,
          width: 0.5,
        ),
      ),
      padding: const EdgeInsetsDirectional.all(10),
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 1.4,
            child: LineChart(
              _mainData(),
            ),
          ),
        ],
      ),
    );
  }

  LineChartData _mainData() {
    return LineChartData(
      backgroundColor: Colors.white,
      // Set the chart's background to white
      gridData: FlGridData(
        show: false,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey.withOpacity(0.3),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.grey.withOpacity(0.3),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 17,
            interval: 1,
            getTitlesWidget: (value, meta) {
              switch (value.toInt()) {
                case 0:
                  return const Text('JAN',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
                case 1:
                  return const Text('FEB',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
                case 2:
                  return const Text('MAR',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
                case 3:
                  return const Text('APR',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
                case 4:
                  return const Text('MAY',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
                case 5:
                  return const Text('JUN',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
                case 6:
                  return const Text('JUL',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
                case 7:
                  return const Text('AUG',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
                case 8:
                  return const Text('SEP',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
                case 9:
                  return const Text('OCT',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
                case 10:
                  return const Text('NOV',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
                case 11:
                  return const Text('DEC',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
                default:
                  return const Text('');
              }
            },
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        border: Border(
            bottom: BorderSide(color: Colors.black),
            left: BorderSide.none,
            right: BorderSide.none,
            top: BorderSide.none),
      ),
      minX: 0,
      maxX: points.length - 1.0,
      minY: 0,
      maxY: points.map((p) => p.y).reduce((a, b) => a > b ? a : b) + 1,
      lineBarsData: [
        LineChartBarData(
          spots: points.map((point) => FlSpot(point.x, point.y)).toList(),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false, // Dot display disabled
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.1)) // Adjusted opacity
                  .toList(),
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
            spotsLine: BarAreaSpotsLine(
              show: false, // Ensure no extra line is drawn
            ),
          ),
        ),
      ],
    );
  }
}
