// widgets/performance_charts.dart

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../../model/perfomance/overall_performance.dart';
import '../../../../../model/perfomance/student_performance.dart';

// Custom Chart Widget (matching your original design pattern)
class CustomChart extends StatefulWidget {
  final StudentPerformanceComparison studentPerformance;
  final bool isShowingMainData;

  const CustomChart({
    Key? key,
    required this.studentPerformance,
    required this.isShowingMainData,
  }) : super(key: key);

  @override
  State<CustomChart> createState() => _CustomChartState();
}

class _CustomChartState extends State<CustomChart> {
  bool isShowingMainData = false;

  @override
  void initState() {
    super.initState();
    isShowingMainData = widget.isShowingMainData;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Performance Trend',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            IconButton(
              icon: Icon(
                isShowingMainData ? Icons.bar_chart : Icons.show_chart,
                color: Colors.indigo,
              ),
              onPressed: () {
                setState(() {
                  isShowingMainData = !isShowingMainData;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: isShowingMainData
              ? _buildPerformanceTrendChart()
              : _buildSubjectComparisonChart(),
        ),
      ],
    );
  }

  Widget _buildPerformanceTrendChart() {
    final performances = widget.studentPerformance.overallPerformance;
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
          border: Border.all(color: Colors.grey[300]!),
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
                Colors.indigo.withOpacity(0.8),
                Colors.indigo,
              ],
            ),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: Colors.indigo,
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  Colors.indigo.withOpacity(0.3),
                  Colors.indigo.withOpacity(0.1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectComparisonChart() {
    final subjects = widget.studentPerformance.subjectImprovements.entries.take(8).toList();

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 100,
        minY: 0,
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            // tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final subject = subjects[group.x.toInt()];
              final improvement = subject.value;
              return BarTooltipItem(
                '${(subject.key)}\n',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: rodIndex == 0
                        ? 'Previous: ${improvement.previousScore.toStringAsFixed(1)}%'
                        : 'Current: ${improvement.latestScore.toStringAsFixed(1)}%',
                    style: const TextStyle(
                      color: Colors.yellow,
                      fontSize: 12,
                    ),
                  ),
                ],
              );
            },
          ),
        ),

        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() >= subjects.length) return const Text('');
                final subject = subjects[value.toInt()];
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    (subject.key.trim().substring(0,3)),
                    style: const TextStyle(fontSize: 9),
                    textAlign: TextAlign.center,
                  ),
                );
              },
              reservedSize: 40,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 35,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toInt()}',
                  style: const TextStyle(fontSize: 9),
                );
              },
            ),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        barGroups: subjects.asMap().entries.map((entry) {
          final index = entry.key;
          final subject = entry.value;
          final improvement = subject.value;

          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: improvement.previousScore,
                color: Colors.grey[400],
                width: 10,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(2),
                  topRight: Radius.circular(2),
                ),
              ),
              BarChartRodData(
                toY: improvement.latestScore,
                color: improvement.improvement >= 0 ? Colors.green : Colors.red,
                width: 10,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(2),
                  topRight: Radius.circular(2),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  // String _getShortSubjectName(String fullName) {
  //   final words = fullName.split('');
  //   if (words.length <= 2) {
  //     return fullName;
  //   } else {
  //     return words.map((word) {
  //     if (word.length <= 3) return word;
  //     return word.substring(0, 3);
  //   }).join(' ');
  //   }
  // }
}





