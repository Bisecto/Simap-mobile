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
    the1StCat: json["1ST CAT"],
    the2NdCat: json["2ND CAT"],
    assignment: json["ASSIGNMENT"],
    project: json["PROJECT"],
    exam: json["EXAM"],
  );

  Map<String, dynamic> toJson() => {
    "1ST CAT": the1StCat,
    "2ND CAT": the2NdCat,
    "ASSIGNMENT": assignment,
    "PROJECT": project,
    "EXAM": exam,
  };
}
