import 'package:simap/model/result_model/result_data/subject_annual_result.dart';
import 'package:simap/model/result_model/result_data/subject_result_term.dart';

class AnnualSubjectResult {
  String subject;
  List<SubjectResultTerm> terms;
  SubjectResultAnnual annual;

  AnnualSubjectResult({
    required this.subject,
    required this.terms,
    required this.annual,
  });

  factory AnnualSubjectResult.fromJson(Map<String, dynamic> json) => AnnualSubjectResult(
    subject: json["subject"],
    terms: List<SubjectResultTerm>.from(json["terms"].map((x) => SubjectResultTerm.fromJson(x))),
    annual: SubjectResultAnnual.fromJson(json["annual"]),
  );

  Map<String, dynamic> toJson() => {
    "subject": subject,
    "terms": List<dynamic>.from(terms.map((x) => x.toJson())),
    "annual": annual.toJson(),
  };
}
