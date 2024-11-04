

class Subject {
  int id;
  Klass klass;
  SubjectClass subject;

  Subject({
    required this.id,
    required this.klass,
    required this.subject,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
    id: json["id"],
    klass: Klass.fromJson(json["klass"]),
    subject: SubjectClass.fromJson(json["subject"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "klass": klass.toJson(),
    "subject": subject.toJson(),
  };
}

class Klass {
  int id;
  ClassName className;
  String nameOfClassType;

  Klass({
    required this.id,
    required this.className,
    required this.nameOfClassType,
  });

  factory Klass.fromJson(Map<String, dynamic> json) => Klass(
    id: json["id"],
    className: ClassName.fromJson(json["class_name"]),
    nameOfClassType: json["name_of_class_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "class_name": className.toJson(),
    "name_of_class_type": nameOfClassType,
  };
}

class ClassName {
  int id;
  String className;
  int school;

  ClassName({
    required this.id,
    required this.className,
    required this.school,
  });

  factory ClassName.fromJson(Map<String, dynamic> json) => ClassName(
    id: json["id"],
    className: json["class_name"],
    school: json["school"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "class_name": className,
    "school": school,
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
