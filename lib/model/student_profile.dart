class StudentProfile {
  String surname;
  String otherNames;
  String studentClass; // Nigerian secondary school class
  String registrationNumber;
  String profileImage;
  String gender;
  DateTime dob; // Date of Birth

  StudentProfile({
    required this.surname,
    required this.otherNames,
    required this.studentClass,
    required this.registrationNumber,
    required this.profileImage,
    required this.gender,
    required this.dob,
  });

  factory StudentProfile.fromJson(Map<String, dynamic> json) {
    return StudentProfile(
      surname: json['surname'],
      otherNames: json['otherNames'],
      studentClass: json['studentClass'],
      registrationNumber: json['registrationNumber'],
      profileImage: json['profileImage'],
      gender: json['gender'],
      dob: DateTime.parse(json['dob']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'surname': surname,
      'otherNames': otherNames,
      'studentClass': studentClass,
      'registrationNumber': registrationNumber,
      'profileImage': profileImage,
      'gender': gender,
      'dob': dob.toIso8601String(),
    };
  }
}
