

class SchoolModel {
  String name;
  String address;
  String logoUrl;
  String schoolBaseUrl;

  SchoolModel({
    required this.name,
    required this.address,
    required this.logoUrl,
    required this.schoolBaseUrl,
  });

  factory SchoolModel.fromJson(Map<String, dynamic> json) => SchoolModel(
    name: json["name"],
    address: json["address"],
    logoUrl: json["logo_url"],
    schoolBaseUrl: json["school_base_url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "address": address,
    "logo_url": logoUrl,
    "school_base_url": schoolBaseUrl,
  };
}


