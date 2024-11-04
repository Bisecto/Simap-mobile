class Behaviour {
  BehaviourData data;

  Behaviour({
    required this.data,
  });

  factory Behaviour.fromJson(Map<String, dynamic> json) => Behaviour(
    data: BehaviourData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class BehaviourData {
  String punctuality;
  String classAttendance;
  String honesty;
  String relationshipWithPeers;

  BehaviourData({
    required this.punctuality,
    required this.classAttendance,
    required this.honesty,
    required this.relationshipWithPeers,
  });

  factory BehaviourData.fromJson(Map<String, dynamic> json) => BehaviourData(
    punctuality: json["punctuality"],
    classAttendance: json["Class Attendance"],
    honesty: json["Honesty"],
    relationshipWithPeers: json["Relationship With Peers"],
  );

  Map<String, dynamic> toJson() => {
    "punctuality": punctuality,
    "Class Attendance": classAttendance,
    "Honesty": honesty,
    "Relationship With Peers": relationshipWithPeers,
  };
}

class Comments {
  String classTeacher;
  String principal;

  Comments({
    required this.classTeacher,
    required this.principal,
  });

  factory Comments.fromJson(Map<String, dynamic> json) => Comments(
    classTeacher: json["Class Teacher"],
    principal: json["Principal"],
  );

  Map<String, dynamic> toJson() => {
    "Class Teacher": classTeacher,
    "Principal": principal,
  };
}

class Psychomotor {
  PsychomotorData data;

  Psychomotor({
    required this.data,
  });

  factory Psychomotor.fromJson(Map<String, dynamic> json) => Psychomotor(
    data: PsychomotorData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class PsychomotorData {
  String reading;
  String creativeArts;
  String publicSpeaking;
  String sports;

  PsychomotorData({
    required this.reading,
    required this.creativeArts,
    required this.publicSpeaking,
    required this.sports,
  });

  factory PsychomotorData.fromJson(Map<String, dynamic> json) => PsychomotorData(
    reading: json["Reading"],
    creativeArts: json["Creative Arts"],
    publicSpeaking: json["Public Speaking"],
    sports: json["Sports"],
  );

  Map<String, dynamic> toJson() => {
    "Reading": reading,
    "Creative Arts": creativeArts,
    "Public Speaking": publicSpeaking,
    "Sports": sports,
  };
}