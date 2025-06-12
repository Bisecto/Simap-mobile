class User {
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.isActive,
  });

  final int? id;
  final String? username;
  final dynamic email;
  final bool? isActive;

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json["id"],
      username: json["username"],
      email: json["email"],
      isActive: json["is_active"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "is_active": isActive,
  };

}
