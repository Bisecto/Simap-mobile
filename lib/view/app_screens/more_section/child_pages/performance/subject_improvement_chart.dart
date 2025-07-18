import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../../model/perfomance/subject_improvement.dart';

class SubjectImprovementChart extends StatelessWidget {
  final Map<String, SubjectImprovement> subjectImprovements;

  const SubjectImprovementChart({
    Key? key,
    required this.subjectImprovements,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subjects = subjectImprovements.entries.take(10).toList();

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
                    style: const TextStyle(fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                );
              },
              reservedSize: 60,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toInt()}%',
                  style: const TextStyle(fontSize: 10),
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
                width: 12,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
              BarChartRodData(
                toY: improvement.latestScore,
                color: improvement.improvement >= 0 ? Colors.green : Colors.red,
                width: 12,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  // String _getShortSubjectName(String fullName) {
  //   final words = fullName.split(' ');
  //   if (words.length <= 2) return fullName;
  //
  //   return words.map((word) {
  //     if (word.length <= 3) return word;
  //     return word.substring(0, 3);
  //   }).join(' ');
  // }
}
