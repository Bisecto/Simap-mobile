// models/student_performance_models.dart

class SubjectImprovement {
  final String latestTerm;
  final double latestScore;
  final String previousTerm;
  final double previousScore;
  final double improvement;
  final double percentageChange;

  SubjectImprovement({
    required this.latestTerm,
    required this.latestScore,
    required this.previousTerm,
    required this.previousScore,
    required this.improvement,
    required this.percentageChange,
  });

  factory SubjectImprovement.fromJson(Map<String, dynamic> json) {
    return SubjectImprovement(
      latestTerm: json['latest_term'],
      latestScore: (json['latest_score'] as num).toDouble(),
      previousTerm: json['previous_term'],
      previousScore: (json['previous_score'] as num).toDouble(),
      improvement: (json['improvement'] as num).toDouble(),
      percentageChange: (json['percentage_change'] as num).toDouble(),
    );
  }
}







