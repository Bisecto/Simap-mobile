import 'package:flutter/material.dart';

import '../../../../../model/perfomance/overall_performance.dart';
import '../../../../../model/student_profile.dart';
import 'overall_trend_chart.dart';

class SessionPerformanceChart extends StatelessWidget {
  final List<OverallPerformance> performances;
  final StudentProfile? studentProfile;

  const SessionPerformanceChart({
    Key? key,
    required this.performances,
    this.studentProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    studentProfile != null
                        ? '${studentProfile!.studentFullname[0]}\'s Session Analysis'
                        : 'Session Performance Analysis',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.indigo.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${performances.length} Terms',
                    style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: OverallPerformanceTrendChart(performances: performances),
            ),
            const SizedBox(height: 16),
            _buildPerformanceMetrics(),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceMetrics() {
    if (performances.isEmpty) return const SizedBox();

    final averageScore = performances.map((p) => p.average).reduce((a, b) => a + b) / performances.length;
    final bestPerformance = performances.reduce((a, b) => a.average > b.average ? a : b);
    final worstPerformance = performances.reduce((a, b) => a.average < b.average ? a : b);
    final trend = performances.length > 1
        ? performances.last.average - performances.first.average
        : 0.0;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                'Average Score',
                '${averageScore.toStringAsFixed(1)}%',
                Colors.blue,
                Icons.trending_up,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildMetricCard(
                'Best Performance',
                '${bestPerformance.term}\n${bestPerformance.average.toStringAsFixed(1)}%',
                Colors.green,
                Icons.star,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                'Overall Trend',
                '${trend >= 0 ? '+' : ''}${trend.toStringAsFixed(1)}%',
                trend >= 0 ? Colors.green : Colors.red,
                trend >= 0 ? Icons.trending_up : Icons.trending_down,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildMetricCard(
                'Focus Area',
                worstPerformance.term,
                Colors.orange,
                Icons.warning,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: color.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
