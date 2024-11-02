

class SchoolModel {
  int id;
  String name;
  String logo;

  SchoolModel({
    required this.id,
    required this.name,
    required this.logo,
  });

  factory SchoolModel.fromJson(Map<String, dynamic> json) => SchoolModel(
    id: json["id"],
    name: json["name"],
    logo: json["logo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "logo": logo,
  };
}
