

import 'package:simap/model/class_model.dart';
import 'package:simap/model/user.dart';

class StudentProfile {
  int id;
  String studentImage;
  String studentFullname;
  String parentGuardianName;
  String occupation;
  String guardianPhoneNumber;
  String fatherContact;
  String fathersName;
  String fathersOccupation;
  String fatherReligion;
  String fatherAddress;
  String motherContact;
  String mothersName;
  String mothersOccupation;
  String mothersReligion;
  String mothersAddress;
  dynamic mothersDayOfBirth;
  dynamic mothersMonthOfBirth;
  DateTime dateOfBirth;
  String gender;
  String religion;
  String bloodGroup;
  String genotype;
  dynamic weight;
  dynamic height;
  String primaryClassAndSchoolAttended;
  String address;
  String state;
  dynamic localGovernment;
  String lga;
  String town;
  bool viewAds;
  DateTime updated;
  User? user;
  //ClassModel currentClass;
  int currentSession;
  int branch;

  StudentProfile({
    required this.id,
    required this.studentImage,
    required this.studentFullname,
    required this.parentGuardianName,
    required this.occupation,
    required this.guardianPhoneNumber,
    required this.fatherContact,
    required this.fathersName,
    required this.fathersOccupation,
    required this.fatherReligion,
    required this.fatherAddress,
    required this.motherContact,
    required this.mothersName,
    required this.mothersOccupation,
    required this.mothersReligion,
    required this.mothersAddress,
    required this.mothersDayOfBirth,
    required this.mothersMonthOfBirth,
    required this.dateOfBirth,
    required this.gender,
    required this.religion,
    required this.bloodGroup,
    required this.genotype,
    required this.weight,
    required this.height,
    required this.primaryClassAndSchoolAttended,
    required this.address,
    required this.state,
    required this.localGovernment,
    required this.lga,
    required this.town,
    required this.viewAds,
    required this.updated,
    required this.user,
   // required this.currentClass,
    required this.currentSession,
    required this.branch,
  });

  factory StudentProfile.fromJson(Map<String, dynamic> json) => StudentProfile(
    id: json["id"]??"",
    studentImage: json["student_image"],
    studentFullname: json["student_fullname"],
    parentGuardianName: json["parent_guardian_name"]??'N/A',
    occupation: json["occupation"]??'N/A',
    guardianPhoneNumber: json["guardian_phone_number"]??'N/A',
    fatherContact: json["father_contact"]??'N/A',
    fathersName: json["fathers_name"]??'N/A',
    fathersOccupation: json["fathers_occupation"]??'N/A',
    fatherReligion: json["father_religion"]??'N/A',
    fatherAddress: json["father_address"]??'N/A',
    motherContact: json["mother_contact"]??'N/A',
    mothersName: json["mothers_name"]??'N/A',
    mothersOccupation: json["mothers_occupation"]??'N/A',
    mothersReligion: json["mothers_religion"]??'N/A',
    mothersAddress: json["mothers_address"]??'N/A',
    mothersDayOfBirth: json["mothers_day_of_birth"]??'N/A',
    mothersMonthOfBirth: json["mothers_month_of_birth"]??'N/A',
    dateOfBirth: DateTime.parse(json["date_of_birth"]),
    gender: json["gender"]??'N/A',
    religion: json["religion"]??'N/A',
    bloodGroup: json["blood_group"]??'N/A',
    genotype: json["genotype"]??'N/A',
    weight: json["weight"],
    height: json["height"],
    primaryClassAndSchoolAttended: json["primary_class_and_school_attended"]??'N/A',
    address: json["address"]??'N/A',
    state: json["state"]??'N/A',
    localGovernment: json["local_government"]??'N/A',
    lga: json["lga"]??'N/A',
    town: json["town"]??'N/A',
    viewAds: json["view_ads"],
    updated: DateTime.parse(json["updated"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
   // currentClass: json["current_class"],
    currentSession: json["current_session"],
    branch: json["branch"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "student_image": studentImage,
    "student_fullname": studentFullname,
    "parent_guardian_name": parentGuardianName,
    "occupation": occupation,
    "guardian_phone_number": guardianPhoneNumber,
    "father_contact": fatherContact,
    "fathers_name": fathersName,
    "fathers_occupation": fathersOccupation,
    "father_religion": fatherReligion,
    "father_address": fatherAddress,
    "mother_contact": motherContact,
    "mothers_name": mothersName,
    "mothers_occupation": mothersOccupation,
    "mothers_religion": mothersReligion,
    "mothers_address": mothersAddress,
    "mothers_day_of_birth": mothersDayOfBirth,
    "mothers_month_of_birth": mothersMonthOfBirth,
    "date_of_birth": "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "religion": religion,
    "blood_group": bloodGroup,
    "genotype": genotype,
    "weight": weight,
    "height": height,
    "primary_class_and_school_attended": primaryClassAndSchoolAttended,
    "address": address,
    "state": state,
    "local_government": localGovernment,
    "lga": lga,
    "town": town,
    "view_ads": viewAds,
    "updated": updated.toIso8601String(),
    "user": user!.toJson(),
   // "current_class": currentClass,
    "current_session": currentSession,
    "branch": branch,
  };
}
