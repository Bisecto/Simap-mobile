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
    teacher: json["teacher"].toString(),
    subject: json["subject"].toString(),
    scores: Scores.fromJson(json["scores"]),
    grade: json["grade"].toString(),
    totalScore: json["total_score"].toString(),
    position: json["position"].toString(),
    remark: json["remark"].toString(),
    dateAdded: json["dateAdded"].toString(),
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
