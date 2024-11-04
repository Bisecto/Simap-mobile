import 'package:simap/model/result_model/result_data/scores.dart';

class TermSubjectResult {
  String teacher;
  String subject;
  Scores scores;
  String grade;
  String totalScore;
  String position;
  String remark;
  String dateAdded;

  TermSubjectResult({
    required this.teacher,
    required this.subject,
    required this.scores,
    required this.grade,
    required this.totalScore,
    required this.position,
    required this.remark,
    required this.dateAdded,
  });

  factory TermSubjectResult.fromJson(Map<String, dynamic> json) => TermSubjectResult(
    teacher: json["teacher"],
    subject: json["subject"],
    scores: Scores.fromJson(json["scores"]),
    grade: json["grade"],
    totalScore: json["total_score"],
    position: json["position"],
    remark: json["remark"],
    dateAdded: json["dateAdded"],
  );

  Map<String, dynamic> toJson() => {
    "teacher": teacher,
    "subject": subject,
    "scores": scores.toJson(),
    "grade": grade,
    "total_score": totalScore,
    "position": position,
    "remark": remark,
    "dateAdded": dateAdded,
  };
}
