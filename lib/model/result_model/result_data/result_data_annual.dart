import 'annual_subject_result.dart';

class ResultDataAnnual {
  List<AnnualSubjectResult> subjectResults;
  String annualTotal;
  String annualAverage;
  String annualPosition;

  ResultDataAnnual({
    required this.subjectResults,
    required this.annualTotal,
    required this.annualAverage,
    required this.annualPosition,
  });

  factory ResultDataAnnual.fromJson(Map<String, dynamic> json) => ResultDataAnnual(
    subjectResults: List<AnnualSubjectResult>.from(json["subject_results"].map((x) => AnnualSubjectResult.fromJson(x))),
    annualTotal: json["annual_total"],
    annualAverage: json["annual_average"],
    annualPosition: json["annual_position"],
  );

  Map<String, dynamic> toJson() => {
    "subject_results": List<dynamic>.from(subjectResults.map((x) => x.toJson())),
    "annual_total": annualTotal,
    "annual_average": annualAverage,
    "annual_position": annualPosition,
  };
}
