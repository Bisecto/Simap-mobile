import 'package:simap/model/result_model/result_data/result_data_annual.dart';
import 'package:simap/model/result_model/result_data/result_data_term.dart';

class ResultData {
  List<ResultDataTerm> terms;
  ResultDataAnnual annual;

  ResultData({
    required this.terms,
    required this.annual,
  });

  factory ResultData.fromJson(Map<String, dynamic> json) => ResultData(
    terms: List<ResultDataTerm>.from(json["terms"].map((x) => ResultDataTerm.fromJson(x))),
    annual: ResultDataAnnual.fromJson(json["annual"]),
  );

  Map<String, dynamic> toJson() => {
    "terms": List<dynamic>.from(terms.map((x) => x.toJson())),
    "annual": annual.toJson(),
  };
}
