import 'package:simap/model/perfomance/subject_improvement.dart';

import 'overall_performance.dart';

class StudentPerformanceComparison {
  final Map<String, SubjectImprovement> subjectImprovements;
  final List<OverallPerformance> overallPerformance;

  StudentPerformanceComparison({
    required this.subjectImprovements,
    required this.overallPerformance,
  });

  factory StudentPerformanceComparison.fromJson(Map<String, dynamic> json) {
    Map<String, SubjectImprovement> subjects = {};
    if (json['subject_improvements'] != null) {
      json['subject_improvements'].forEach((key, value) {
        subjects[key] = SubjectImprovement.fromJson(value);
      });
    }

    List<OverallPerformance> overall = [];
    if (json['overall_performance'] != null) {
      overall = (json['overall_performance'] as List)
          .map((item) => OverallPerformance.fromJson(item))
          .toList();
    }

    return StudentPerformanceComparison(
      subjectImprovements: subjects,
      overallPerformance: overall,
    );
  }
}
