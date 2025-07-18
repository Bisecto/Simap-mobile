import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../../model/perfomance/overall_performance.dart';

class OverallPerformanceTrendChart extends StatelessWidget {
  final List<OverallPerformance> performances;

  const OverallPerformanceTrendChart({
    Key? key,
    required this.performances,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sortedPerformances = List<OverallPerformance>.from(performances)
      ..sort((a, b) => a.date.compareTo(b.date));

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: 10,
          verticalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey[300],
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: Colors.grey[300],
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: (value, meta) {
                if (value.toInt() >= sortedPerformances.length) return const Text('');
                final performance = sortedPerformances[value.toInt()];
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    performance.term,
                    style: const TextStyle(fontSize: 10),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 10,
              getTitlesWidget: (value, meta) {
                return Text('${value.toInt()}%', style: const TextStyle(fontSize: 10));
              },
              reservedSize: 42,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d)),
        ),
        minX: 0,
        maxX: (sortedPerformances.length - 1).toDouble(),
        minY: 0,
        maxY: 100,
        lineBarsData: [
          LineChartBarData(
            spots: sortedPerformances.asMap().entries.map((entry) {
              return FlSpot(entry.key.toDouble(), entry.value.average);
            }).toList(),
            isCurved: true,
            gradient: LinearGradient(
              colors: [
                Colors.blue.withOpacity(0.8),
                Colors.blue,
              ],
            ),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: Colors.blue,
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  Colors.blue.withOpacity(0.3),
                  Colors.blue.withOpacity(0.1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            //tooltipBgColor: Colors.blueAccent,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                final performance = sortedPerformances[spot.x.toInt()];
                return LineTooltipItem(
                  '${performance.term}\n',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: 'Average: ${performance.average.toStringAsFixed(1)}%\n',
                      style: const TextStyle(
                        color: Colors.yellow,
                        fontSize: 12,
                      ),
                    ),
                    TextSpan(
                      text: 'Position: #${performance.position}',
                      style: const TextStyle(
                        color: Colors.yellow,
                        fontSize: 12,
                      ),
                    ),
                  ],
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }
}
