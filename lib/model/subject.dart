

class Subject {
  int id;
  //Klass klass;
  SubjectClass subject;

  Subject({
    required this.id,
   // required this.klass,
    required this.subject,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
    id: json["id"],
    //klass: Klass.fromJson(json["klass"]),
    subject: SubjectClass.fromJson(json["subject"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
   // "klass": klass.toJson(),
    "subject": subject.toJson(),
  };
}


class SubjectClass {
  int id;
  String name;

  SubjectClass({
    required this.id,
    required this.name,
  });

  factory SubjectClass.fromJson(Map<String, dynamic> json) => SubjectClass(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
