// To parse this JSON data, do
//
//     final resultModel = resultModelFromJson(jsonString);

import 'dart:convert';

import 'package:simap/model/result_model/result_current_data.dart';
import 'package:simap/model/result_model/result_data/result_data.dart';
import 'package:simap/model/result_model/result_template_model.dart';
import 'package:simap/model/result_model/temp_id_dic.dart';

import 'controls.dart';

ResultModel resultModelFromJson(String str) => ResultModel.fromJson(json.decode(str));

String resultModelToJson(ResultModel data) => json.encode(data.toJson());

class ResultModel {
  ResultData resultData;
  List<String> publishTerms;
  ResultTemplate resultTemplate;
  Controls controls;
  CurrentData currentData;
  TermsIdDic termsIdDic;
  dynamic thirdId;

  ResultModel({
    required this.resultData,
    required this.publishTerms,
    required this.resultTemplate,
    required this.controls,
    required this.currentData,
    required this.termsIdDic,
    required this.thirdId,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
    resultData: ResultData.fromJson(json["resultData"]),
    publishTerms: List<String>.from(json["publish_terms"].map((x) => x)),
    resultTemplate: ResultTemplate.fromJson(json["result_template"]),
    controls: Controls.fromJson(json["controls"]),
    currentData: CurrentData.fromJson(json["current_data"]),
    termsIdDic: TermsIdDic.fromJson(json["terms_id_dic"]),
    thirdId: json["third_id"],
  );

  Map<String, dynamic> toJson() => {
    "resultData": resultData.toJson(),
    "publish_terms": List<dynamic>.from(publishTerms.map((x) => x)),
    "result_template": resultTemplate.toJson(),
    "controls": controls.toJson(),
    "current_data": currentData.toJson(),
    "terms_id_dic": termsIdDic.toJson(),
    "third_id": thirdId,
  };
}















