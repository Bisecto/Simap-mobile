class OverallPerformance {
  final String term;
  final double average;
  final int position;
  final DateTime date;

  OverallPerformance({
    required this.term,
    required this.average,
    required this.position,
    required this.date,
  });

  factory OverallPerformance.fromJson(Map<String, dynamic> json) {
    return OverallPerformance(
      term: json['term'],
      average: (json['average'] as num).toDouble(),
      position: json['position'],
      date: DateTime.parse(json['date']),
    );
  }
}
