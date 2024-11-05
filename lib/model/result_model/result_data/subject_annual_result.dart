class SubjectResultAnnual {
  String totalScore;
  String averageScore;
  String grade;
  String remark;
  String position;

  SubjectResultAnnual({
    required this.totalScore,
    required this.averageScore,
    required this.grade,
    required this.remark,
    required this.position,
  });

  factory SubjectResultAnnual.fromJson(Map<String, dynamic> json) => SubjectResultAnnual(
    totalScore: json["total_score"],
    averageScore: json["average_score"],
    grade: json["grade"]??'',
    remark: json["remark"]??'',
    position: json["position"]??'',
  );

  Map<String, dynamic> toJson() => {
    "total_score": totalScore,
    "average_score": averageScore,
    "grade": grade,
    "remark": remark,
    "position": position,
  };
}
