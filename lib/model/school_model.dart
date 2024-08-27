

class SchoolModel {
  String name;
  String address;
  String logoUrl;
  Coordinates coordinates;
  Details details;

  SchoolModel({
    required this.name,
    required this.address,
    required this.logoUrl,
    required this.coordinates,
    required this.details,
  });

  factory SchoolModel.fromJson(Map<String, dynamic> json) => SchoolModel(
    name: json["name"],
    address: json["address"],
    logoUrl: json["logo_url"],
    coordinates: Coordinates.fromJson(json["coordinates"]),
    details: Details.fromJson(json["details"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "address": address,
    "logo_url": logoUrl,
    "coordinates": coordinates.toJson(),
    "details": details.toJson(),
  };
}

class Coordinates {
  double latitude;
  double longitude;

  Coordinates({
    required this.latitude,
    required this.longitude,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
  };
}

class Details {
  String phone;
  String website;
  String principal;
  String type;
  String grades;

  Details({
    required this.phone,
    required this.website,
    required this.principal,
    required this.type,
    required this.grades,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    phone: json["phone"],
    website: json["website"],
    principal: json["principal"],
    type: json["type"],
    grades: json["grades"],
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "website": website,
    "principal": principal,
    "type": type,
    "grades": grades,
  };
}
