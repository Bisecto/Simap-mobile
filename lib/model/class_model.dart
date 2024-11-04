

class ClassModel {
  int id;
  ClassName className;
  String nameOfClassType;

  ClassModel({
    required this.id,
    required this.className,
    required this.nameOfClassType,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) => ClassModel(
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
