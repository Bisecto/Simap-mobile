class Scores {
  String the1StCat;
  String the2NdCat;
  String assignment;
  String project;
  String exam;

  Scores({
    required this.the1StCat,
    required this.the2NdCat,
    required this.assignment,
    required this.project,
    required this.exam,
  });

  factory Scores.fromJson(Map<String, dynamic> json) => Scores(
    the1StCat: json["1ST CAT"].toString(),
    the2NdCat: json["2ND CAT"].toString(),
    assignment: json["ASSIGNMENT"].toString(),
    project: json["PROJECT"].toString(),
    exam: json["EXAM"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "1ST CAT": the1StCat,
    "2ND CAT": the2NdCat,
    "ASSIGNMENT": assignment,
    "PROJECT": project,
    "EXAM": exam,
  };
}
