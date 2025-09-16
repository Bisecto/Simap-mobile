import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simap/res/app_icons.dart';
import 'package:simap/utills/app_navigator.dart';
import 'package:simap/utills/app_utils.dart';
import 'package:simap/view/app_screens/quiz_section/quiz_summary.dart';

import '../../../model/class_model.dart';
import '../../../model/student_profile.dart';
import '../../../model/subject.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_images.dart';
import '../../widgets/appBar_widget.dart';
import '../../widgets/app_custom_text.dart';
import '../home_section/home_page_components/welcome_container.dart';

class AvailableSubjects extends StatefulWidget {
  StudentProfile studentProfile;
  ClassModel classModel;
  final List<Subject> subjectList;

  AvailableSubjects(
      {super.key,
      required this.studentProfile,
      required this.classModel,
      required this.subjectList}) {
    // TODO: implement AvailableSubjects
    //throw UnimplementedError();
  }

  @override
  State<AvailableSubjects> createState() => _AvailableSubjectsState();
}

class _AvailableSubjectsState extends State<AvailableSubjects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFC),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MainAppBar(
                isBackKey: true,
                studentProfile: widget.studentProfile,
                classModel: widget.classModel,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  physics:const NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WelcomeContainer(
                        welcomeMsg: 'Hello Champ 👋',
                        mainText:
                            'Study Hard\n${widget.studentProfile.studentFullname}',
                        subText: '',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height:widget.subjectList.length* 110,
                        child: ListView.builder(
                          physics:const NeverScrollableScrollPhysics(),

                          itemCount: widget.subjectList.length,
                          itemBuilder: (context, index) {
                            return assignmentSubjectsContainer(
                                widget.subjectList[index].subject.name);
                          },
                        ),
                      ),

                      // assignmentSubjectsContainer("English Language"),
                      // assignmentSubjectsContainer("Mathematics"),
                      // assignmentSubjectsContainer("Physics"),
                      // assignmentSubjectsContainer("Chemistry"),
                      // assignmentSubjectsContainer("Biology"),
                      // assignmentSubjectsContainer("Agricultural science"),
                    ],
                  ),
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
          AppNavigator.pushAndStackPage(context,
              page: QuizSummary(
                subject: subject,
                studentProfile: widget.studentProfile,
                classModel: widget.classModel,
              ));
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
                radius: 25,
                child: SvgPicture.asset(AppIcons.book),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: AppUtils.deviceScreenSize(context).width/2,
                child: CustomText(
                  text: subject,
                  size: 14,
                  weight: FontWeight.w400,
                  color: AppColors.black,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
