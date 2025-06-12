class ResultTemplate {
  int id;
  String fields;
  bool isInUse;
  int branch;
  dynamic session;
  //int classType;

  ResultTemplate({
    required this.id,
    required this.fields,
    required this.isInUse,
    required this.branch,
    required this.session,
    //required this.classType,
  });

  factory ResultTemplate.fromJson(Map<String, dynamic> json) => ResultTemplate(
    id: json["id"],
    fields: json["fields"],
    isInUse: json["is_in_use"],
    branch: json["branch"],
    session: json["session"],
    //classType: json["class_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fields": fields,
    "is_in_use": isInUse,
    "branch": branch,
    "session": session,
   // "class_type": classType,
  };
}
