class SubjectResultTerm {
  String term;
  String totalScore;

  SubjectResultTerm({
    required this.term,
    required this.totalScore,
  });

  factory SubjectResultTerm.fromJson(Map<String, dynamic> json) => SubjectResultTerm(
    term: json["term"],
    totalScore: json["total_score"],
  );

  Map<String, dynamic> toJson() => {
    "term": term,
    "total_score": totalScore,
  };
}
