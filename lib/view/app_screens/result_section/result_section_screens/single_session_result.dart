import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simap/utills/app_navigator.dart';
import 'package:simap/view/app_screens/result_section/result_section_screens/term_list/full_result.dart';
import 'package:simap/view/app_screens/result_section/result_section_screens/term_list/result_table.dart';
import 'package:simap/view/app_screens/result_section/result_section_screens/term_list/term_list.dart';
import 'package:simap/view/widgets/form_button.dart';

import '../../../../model/student_profile.dart';
import '../../../../res/app_colors.dart';
import '../../../../utills/app_utils.dart';
import '../../../widgets/appBar_widget.dart';
import '../../../widgets/app_custom_text.dart';

class SingleSessionResult extends StatefulWidget {
  final String session;
  final bool isBackKey;
  StudentProfile studentProfile;


   SingleSessionResult({super.key, required this.session, required this.isBackKey,required this.studentProfile});

  @override
  State<SingleSessionResult> createState() => _SingleSessionResultState();
}

class _SingleSessionResultState extends State<SingleSessionResult> {
  String selectedTerm = 'First';

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
               MainAppBar(isBackKey: widget.isBackKey,studentProfile: widget.studentProfile),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.pop(context);
                      //   },
                      //   child: const Row(
                      //     children: [
                      //       Icon(Icons.arrow_back_ios),
                      //       CustomText(
                      //         text: 'Back',
                      //         color: AppColors.black,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomText(
                        text: "${widget.session} Result",
                        size: 18,
                        weight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                      const CustomText(
                        text: "Select term to view result",
                        size: 16,
                        weight: FontWeight.w400,
                        color: AppColors.textColor,
                      ),
                      TermList(
                        selectedTerm: (term) {
                          setState(() {
                            setState(() {
                              selectedTerm = term;
                            });
                          });
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "$selectedTerm Term Result",
                            size: 18,
                            weight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                          Container(
                            height: 40,
                            width: 120,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  spreadRadius: 0,
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  text: 'Download',
                                  size: 16,
                                  weight: FontWeight.w600,
                                  color: AppColors.mainAppColor,
                                ),
                                Icon(Icons.download)
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              scoreContainer(
                                term: 'Total',
                                isTitle: true,
                              ),
                              const CustomText(
                                text: "1239",
                                size: 18,
                                weight: FontWeight.w400,
                                color: AppColors.black,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              scoreContainer(
                                term: 'Average',
                                isTitle: true,
                              ),
                              const CustomText(
                                text: "75.90",
                                size: 18,
                                weight: FontWeight.w400,
                                color: AppColors.black,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GradesTable(),
                      FormButton(
                        onPressed: () {
                          AppNavigator.pushAndStackPage(context,
                              page: FullResultPage());
                        },
                        bgColor: AppColors.mainAppColor,
                        text: "View full result",
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Row(
                        children: [
                          CustomText(
                            text: "Student Behavior",
                            size: 16,
                            color: AppColors.mainAppColor,
                            weight: FontWeight.bold,
                          ),
                        ],
                      ),
                      ...[
                        remarkContainer("Punctuality", "VERY GOOD"),
                        remarkContainer("Class Attendance", "VERY GOOD"),
                        remarkContainer("Honesty", "VERY GOOD"),
                        remarkContainer("Relationship With Peers", "VERY GOOD"),
                      ],
                      const SizedBox(
                        height: 30,
                      ),
                      const Row(
                        children: [
                          CustomText(
                            text: "Student Psychomotor",
                            size: 16,
                            color: AppColors.mainAppColor,
                            weight: FontWeight.bold,
                          ),
                        ],
                      ),
                      ...[
                        remarkContainer("Reading", "VERY GOOD"),
                        remarkContainer("Creative Arts", "VERY GOOD"),
                        remarkContainer("Public Speaking", "VERY GOOD"),
                        remarkContainer("Sports", "VERY GOOD"),
                      ],
                      const SizedBox(
                        height: 30,
                      ),
                      const Row(
                        children: [
                          CustomText(
                            text: "Comments",
                            size: 16,
                            color: AppColors.mainAppColor,
                            weight: FontWeight.bold,
                          ),
                        ],
                      ),
                      ...[
                        remarkContainer("Class Teacher", ""),
                        const CustomText(
                          text:
                              "Serena needs to be hardworking and improve"
                                  " in his studies",
                          size: 14,
                          color: AppColors.black,
                          weight: FontWeight.w400,
                          maxLines: 10,
                        ),
                        remarkContainer("Principals", ""),
                        const CustomText(
                          text:
                              "This performance is just above average. Quality"
                                  " reading with determination is the key"
                                  " to good grades.",
                          size: 14,
                          color: AppColors.black,
                          weight: FontWeight.w400,
                          maxLines: 10,
                        ),
                      ]
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

  Widget scoreContainer({required String term, required bool isTitle}) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        height: 40,
        width: 80,
        decoration: BoxDecoration(
          color: isTitle ? AppColors.mainAppColor : AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: CustomText(
            text: term,
            size: 16,
            weight: FontWeight.w600,
            color: isTitle ? AppColors.white : AppColors.textColor,
          ),
        ),
      ),
    );
  }

  Widget remarkContainer(title, sub) {
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
              text: title,
              size: 16,
              color: AppColors.black,
              weight: FontWeight.bold,
            ),
            CustomText(
              text: sub,
              size: 14,
              color: AppColors.textColor,
              weight: FontWeight.w400,
            )
          ],
        ),
      ),
    );
  }
}
