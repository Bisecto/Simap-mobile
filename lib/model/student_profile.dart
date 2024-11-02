class StudentProfile {
  String fullName;
  String studentClass;
  String registrationNumber;
  String profileImage;
  String gender;
  DateTime dob;
  String parentName;
  String parentPhoneNumber;
  String address;
  String bloodGroup;
  String genotype;
  String fatherName;
  String fatherOccupation;
  String fatherReligion;
  String fatherAddress;
  String motherName;
  String motherOccupation;
  String motherReligion;
  String motherAddress;
  String primarySchool;
  String state;
  String lga;
  String town;
  DateTime lastUpdated;

  StudentProfile({
    required this.fullName,
    required this.studentClass,
    required this.registrationNumber,
    required this.profileImage,
    required this.gender,
    required this.dob,
    required this.parentName,
    required this.parentPhoneNumber,
    required this.address,
    required this.bloodGroup,
    required this.genotype,
    required this.fatherName,
    required this.fatherOccupation,
    required this.fatherReligion,
    required this.fatherAddress,
    required this.motherName,
    required this.motherOccupation,
    required this.motherReligion,
    required this.motherAddress,
    required this.primarySchool,
    required this.state,
    required this.lga,
    required this.town,
    required this.lastUpdated,
  });

  factory StudentProfile.fromJson(Map<String, dynamic> json) {
    return StudentProfile(
      fullName: json['user']['student_fullname'],
      studentClass: json['user']['current_class'].toString(),
      registrationNumber: json['user']['id'].toString(),
      profileImage: json['user']['student_image'],
      gender: json['user']['gender'],
      dob: DateTime.parse(json['user']['date_of_birth']),
      parentName: json['user']['parent_guardian_name'],
      parentPhoneNumber: json['user']['guardian_phone_number'],
      address: json['user']['address'],
      bloodGroup: json['user']['blood_group'],
      genotype: json['user']['genotype'],
      fatherName: json['user']['fathers_name'],
      fatherOccupation: json['user']['fathers_occupation'],
      fatherReligion: json['user']['father_religion'],
      fatherAddress: json['user']['father_address'],
      motherName: json['user']['mothers_name'],
      motherOccupation: json['user']['mothers_occupation'],
      motherReligion: json['user']['mothers_religion'],
      motherAddress: json['user']['mothers_address'],
      primarySchool: json['user']['primary_class_and_school_attended'],
      state: json['user']['state'],
      lga: json['user']['lga'],
      town: json['user']['town'],
      lastUpdated: DateTime.parse(json['user']['updated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'studentClass': studentClass,
      'registrationNumber': registrationNumber,
      'profileImage': profileImage,
      'gender': gender,
      'dob': dob.toIso8601String(),
      'parentName': parentName,
      'parentPhoneNumber': parentPhoneNumber,
      'address': address,
      'bloodGroup': bloodGroup,
      'genotype': genotype,
      'fatherName': fatherName,
      'fatherOccupation': fatherOccupation,
      'fatherReligion': fatherReligion,
      'fatherAddress': fatherAddress,
      'motherName': motherName,
      'motherOccupation': motherOccupation,
      'motherReligion': motherReligion,
      'motherAddress': motherAddress,
      'primarySchool': primarySchool,
      'state': state,
      'lga': lga,
      'town': town,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}
