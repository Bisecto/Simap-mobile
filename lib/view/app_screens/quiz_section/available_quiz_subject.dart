import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simap/res/app_icons.dart';
import 'package:simap/utills/app_navigator.dart';
import 'package:simap/view/app_screens/quiz_section/quiz_summary.dart';

import '../../../model/class_model.dart';
import '../../../model/student_profile.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_images.dart';
import '../../widgets/appBar_widget.dart';
import '../../widgets/app_custom_text.dart';
import '../home_section/home_page_components/welcome_container.dart';

class AvailableSubjects extends StatefulWidget {
  StudentProfile studentProfile;
  ClassModel classModel;

   AvailableSubjects({super.key,required this.studentProfile,required this.classModel});

  @override
  State<AvailableSubjects> createState() => _AvailableSubjectsState();
}

class _AvailableSubjectsState extends State<AvailableSubjects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCFCFC),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MainAppBar(
                isBackKey: true,studentProfile: widget.studentProfile, classModel: widget.classModel,
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WelcomeContainer(
                      welcomeMsg: 'Hello Champ 👋',
                      mainText: 'Study Hard\nOkafor Precious',
                      subText: '',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    assignmentSubjectsContainer("English Language"),
                    assignmentSubjectsContainer("Mathematics"),
                    assignmentSubjectsContainer("Physics"),
                    assignmentSubjectsContainer("Chemistry"),
                    assignmentSubjectsContainer("Biology"),
                    assignmentSubjectsContainer("Agricultural science"),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  Widget assignmentSubjectsContainer(String subject) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: GestureDetector(
        onTap: () {
          AppNavigator.pushAndStackPage(context, page: QuizSummary(subject: subject, studentProfile: widget.studentProfile, classModel: widget.classModel,));
        },
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                child: SvgPicture.asset(AppIcons.book),
              ),
              const SizedBox(
                width: 10,
              ),
              CustomText(
                text: subject,
                size: 16,
                weight: FontWeight.w400,
                color: AppColors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
