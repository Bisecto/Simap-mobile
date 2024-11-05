import 'package:simap/model/result_model/result_data/term_subject_result.dart';

import 'addditional_result_data.dart';

class ResultDataTerm {
  String term;
  List<TermSubjectResult> subjectResults;
  Behaviour behaviour;
  Psychomotor psychomotor;
  Comments comments;
  String totalScore;
  String averageScore;
  String position;

  ResultDataTerm({
    required this.term,
    required this.subjectResults,
    required this.behaviour,
    required this.psychomotor,
    required this.comments,
    required this.totalScore,
    required this.averageScore,
    required this.position,
  });

  factory ResultDataTerm.fromJson(Map<String, dynamic> json) => ResultDataTerm(
    term: json["term"].toString(),
    subjectResults: List<TermSubjectResult>.from(json["subject_results"].map((x) => TermSubjectResult.fromJson(x))),
    behaviour: Behaviour.fromJson(json["behaviour"]),
    psychomotor: Psychomotor.fromJson(json["psychomotor"]),
    comments: Comments.fromJson(json["comments"]),
    totalScore: json["total_score"].toString(),
    averageScore: json["average_score"].toString(),
    position: json["position"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "term": term,
    "subject_results": List<dynamic>.from(subjectResults.map((x) => x.toJson())),
    "behaviour": behaviour.toJson(),
    "psychomotor": psychomotor.toJson(),
    "comments": comments.toJson(),
    "total_score": totalScore,
    "average_score": averageScore,
    "position": position,
  };
}
