import 'package:flutter/material.dart';
import 'package:simap/model/class_model.dart';
import 'package:simap/model/student_profile.dart';
import 'package:simap/res/app_images.dart';
import 'package:simap/utills/app_utils.dart';

import '../../../../res/apis.dart';
import '../../../../res/app_colors.dart';
import '../../../../res/shared_preferenceKey.dart';
import '../../../../utills/shared_preferences.dart';
import '../../../widgets/app_custom_text.dart';

class ProfilePage extends StatefulWidget {
  StudentProfile studentProfile;
  ClassModel currentClass;

  ProfilePage(
      {super.key, required this.studentProfile, required this.currentClass});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String studentImage = '';

  @override
  void initState() {
    // TODO: implement initState
    getSavedData();
    super.initState();
  }

  getSavedData() async {
    String schoolIdKey =
        await SharedPref.getString(SharedPreferenceKey().schoolIdKey);
    setState(() {
      studentImage = AppApis.http +
          schoolIdKey +
          AppApis.appBaseUrl +
          widget.studentProfile.studentImage;
      print(studentImage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Row(
                  children: [
                    Icon(Icons.arrow_back_ios),
                    CustomText(
                      text: 'Profile',
                      color: AppColors.black,
                      weight: FontWeight.bold,
                      size: 16,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(studentImage),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomText(
                text: widget.studentProfile.studentFullname.split(' ')[0],
                color: AppColors.black,
                weight: FontWeight.bold,
                size: 20,
              ),
              CustomText(
                text: widget.studentProfile.studentFullname.replaceAll(
                    widget.studentProfile.studentFullname.split(' ')[0], ''),
                color: AppColors.textColor,
                weight: FontWeight.w400,
                size: 16,
              ),
              const SizedBox(
                height: 20,
              ),
              profileDetailContainer(widget.studentProfile.gender, "Gender"),
              profileDetailContainer(
                  AppUtils.formateSimpleDate(dateTime: widget.studentProfile.dateOfBirth.toString()), "Date Of Birth"),
              profileDetailContainer(
                  widget.currentClass.className.className, "Class"),
              profileDetailContainer(widget.studentProfile.lga, "LGA"),
              profileDetailContainer(widget.studentProfile.town, "Town"),
              profileDetailContainer(widget.studentProfile.state, "State"),
              profileDetailContainer(widget.studentProfile.gender, "Gender"),
              profileDetailContainer(
                  widget.studentProfile.parentGuardianName, "Guardian Name"),
              profileDetailContainer(
                  widget.studentProfile.guardianPhoneNumber, "Guardian Phone"),
              profileDetailContainer(
                  widget.studentProfile.bloodGroup, "Blood group"),
              profileDetailContainer(widget.studentProfile.genotype, "Genotype"),
            ],
          ),
        ),
      )),
    );
  }

  Widget profileDetailContainer(title, sub) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        height: 40,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: sub,
              size: 14,
              color: AppColors.textColor,
              weight: FontWeight.w400,
            ),
            CustomText(
              text: title,
              size: 16,
              color: AppColors.black,
              weight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
