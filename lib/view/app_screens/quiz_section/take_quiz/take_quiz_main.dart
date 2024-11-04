import 'package:flutter/material.dart';
import 'package:simap/utills/app_utils.dart';
import 'package:simap/view/app_screens/quiz_section/take_quiz/quiz_modal.dart';

import '../../../../model/class_model.dart';
import '../../../../model/student_profile.dart';
import '../../../../res/app_colors.dart';
import '../../../../res/app_images.dart';
import '../../../widgets/appBar_widget.dart';
import '../../../widgets/app_custom_text.dart';

class TakeQuizMain extends StatefulWidget {
  final String subject;
  StudentProfile studentProfile;
  ClassModel classModel;


   TakeQuizMain({super.key, required this.subject,required this.studentProfile,required this.classModel});

  @override
  State<TakeQuizMain> createState() => _TakeQuizMainState();
}

class _TakeQuizMainState extends State<TakeQuizMain> {
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
                isBackKey: true,studentProfile: widget.studentProfile, classModel: widget.classModel,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "Instruction:",
                                weight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                              CustomText(
                                text: "Answer all Questions",
                                weight: FontWeight.w400,
                                color: AppColors.textColor,
                              ),
                            ],
                          ),
                          Container(
                            height: 35,
                            width: 120,
                            decoration: BoxDecoration(
                                color: AppColors.mainAppColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: const CustomText(
                                text: "Submit",
                                weight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(height:530,child: QuizModal())
                    ]),
              )
            ],
          ),
        ),
      )),
    );
  }
}
