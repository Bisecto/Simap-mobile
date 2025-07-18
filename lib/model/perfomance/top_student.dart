class TopStudent {
  final String name;
  final String regNumber;
  final String className;
  final int position;
  final double averageScore;
  final String term;
  final String session;

  TopStudent({
    required this.name,
    required this.regNumber,
    required this.className,
    required this.position,
    required this.averageScore,
    required this.term,
    required this.session,
  });

  factory TopStudent.fromJson(Map<String, dynamic> json) {
    return TopStudent(
      name: json['name'],
      regNumber: json['reg_number'],
      className: json['class'],
      position: json['position'],
      averageScore: (json['average_score'] as num).toDouble(),
      term: json['term'],
      session: json['session'],
    );
  }
}
