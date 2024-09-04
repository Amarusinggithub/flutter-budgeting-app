import 'package:budgetingapp/provider/transaction_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LineChartContainer extends StatelessWidget {
  const LineChartContainer({super.key});

  List<Color> get gradientColors => [
        const Color(0xFF007AFF),
        const Color(0xFF00A2FF),
      ];

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
              _mainData(transactionProvider),
            ),
          ),
        ],
      ),
    );
  }

  LineChartData _mainData(TransactionProvider transactionProvider) {
    final points = transactionProvider.getTransactionPoints(
        transactionProvider.selectedIndexForTransactionTime);

    final maxY = points.isEmpty
        ? 0.0
        : points.map((p) => p.y).reduce((a, b) => a > b ? a : b) + 1;

    return LineChartData(
      backgroundColor: Colors.white,
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
              switch (transactionProvider.selectedIndexForTransactionTime) {
                case 0:
                  return bottomTitleForDays(value.toInt());
                case 1:
                  return bottomTitleForWeeks(value.toInt());
                case 2:
                  return bottomTitleForMonths(value.toInt());
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
        border: const Border(
          bottom: BorderSide(color: Colors.black),
          left: BorderSide.none,
          right: BorderSide.none,
          top: BorderSide.none,
        ),
      ),
      minX: 0,
      maxX: points.isEmpty ? 0 : points.length - 1.0,
      minY: 0,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          preventCurveOvershootingThreshold: 15,
          preventCurveOverShooting: true,
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
                  .map((color) => color.withOpacity(0.1))
                  .toList(),
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
            spotsLine: const BarAreaSpotsLine(
              show: false,
            ),
          ),
        ),
      ],
    );
  }

  Text bottomTitleForMonths(int value) {
    switch (value.toInt()) {
      case 0:
        return const Text('JAN',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
      case 1:
        return const Text('FEB',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
      case 2:
        return const Text('MAR',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
      case 3:
        return const Text('APR',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
      case 4:
        return const Text('MAY',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
      case 5:
        return const Text('JUN',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
      case 6:
        return const Text('JUL',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
      case 7:
        return const Text('AUG',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
      case 8:
        return const Text('SEP',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
      case 9:
        return const Text('OCT',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
      case 10:
        return const Text('NOV',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
      case 11:
        return const Text('DEC',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
      default:
        return const Text('');
    }
  }

  Text bottomTitleForDays(int value) {
    switch (value.toInt()) {
      case 0:
        return const Text('SUN',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
      case 1:
        return const Text('MON',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
      case 2:
        return const Text('TUE',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
      case 3:
        return const Text('WED',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
      case 4:
        return const Text('THU',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
      case 5:
        return const Text('FRI',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
      case 6:
        return const Text('SAT',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
      default:
        return const Text('');
    }
  }

  Text bottomTitleForWeeks(int value) {
    switch (value.toInt()) {
      case 0:
        return const Text('WK 1',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
      case 1:
        return const Text('WK 2',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
      case 2:
        return const Text('WK 3',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
      case 3:
        return const Text('WK 4',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
      case 4:
        return const Text('WK 5',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
      default:
        return const Text('');
    }
  }
}
