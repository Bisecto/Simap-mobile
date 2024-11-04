import 'package:flutter/material.dart';
import 'package:simap/res/app_colors.dart';
import 'package:simap/res/app_images.dart';
import 'package:simap/utills/app_navigator.dart';
import 'package:simap/view/app_screens/quiz_section/take_quiz/take_quiz_main.dart';
import 'package:simap/view/widgets/app_custom_text.dart';
import 'package:simap/view/widgets/form_button.dart';

import '../../../model/student_profile.dart';
import '../../widgets/appBar_widget.dart';

class QuizSummary extends StatefulWidget {
  final String subject;
  StudentProfile studentProfile;


   QuizSummary({super.key, required this.subject,required this.studentProfile});

  @override
  State<QuizSummary> createState() => _QuizSummaryState();
}

class _QuizSummaryState extends State<QuizSummary> {
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
                isBackKey: true,studentProfile: widget.studentProfile
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: widget.subject,
                            weight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                          Container(
                            height: 40,
                            width: 110,
                            decoration: BoxDecoration(
                                color: const Color(0xFF4DC959),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(AppImages.trophy),
                                  const CustomText(
                                    text: " 0 Points",
                                    weight: FontWeight.bold,
                                    color: AppColors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const CustomText(
                        text: "Quiz Summary",
                        weight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
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
                        child: Column(
                          children: [
                            summaryContainer(
                                Icons.person, "Student", "Okafor Precious"),
                            summaryContainer(
                                Icons.menu_book, "Subject", widget.subject),
                            summaryContainer(
                                Icons.all_inbox, "Total Questions", "10"),
                            summaryContainer(Icons.timer_rounded,
                                "Estimated Duration", "1:00 mins")
                          ],
                        ),
                      ),
                      FormButton(
                        onPressed: () {
                          AppNavigator.pushAndStackPage(context, page: TakeQuizMain(subject: widget.subject, studentProfile: widget.studentProfile,));
                        },
                        text: "Take Quiz",
                        bgColor: AppColors.mainAppColor,
                        borderRadius: 10,
                      )
                    ]),
              )
            ],
          ),
        ),
      )),
    );
  }

  Widget summaryContainer(IconData icondata, String header, String desc) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.green.withOpacity(0.1),
                  child: Icon(
                    icondata,
                    color:Colors.green,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                CustomText(
                  text: header,
                  weight: FontWeight.w600,
                  color: AppColors.black,
                  size: 14,
                ),
              ],
            ),
            CustomText(
              text: desc,
              weight: FontWeight.w400,
              color: AppColors.black,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
