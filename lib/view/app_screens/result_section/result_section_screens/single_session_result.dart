import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simap/model/session_model.dart';
import 'package:simap/utills/app_navigator.dart';
import 'package:simap/view/app_screens/auth/sign_page.dart';
import 'package:simap/view/app_screens/result_section/result_section_screens/term_list/full_result.dart';
import 'package:simap/view/app_screens/result_section/result_section_screens/term_list/result_table.dart';
import 'package:simap/view/app_screens/result_section/result_section_screens/term_list/term_list.dart';
import 'package:simap/view/widgets/form_button.dart';

import '../../../../bloc/result_bloc/result_bloc.dart';
import '../../../../model/class_model.dart';
import '../../../../model/result_model/result_data/result_data_annual.dart';
import '../../../../model/result_model/result_data/result_data_term.dart';
import '../../../../model/student_profile.dart';
import '../../../../res/app_colors.dart';
import '../../../../utills/app_utils.dart';
import '../../../widgets/appBar_widget.dart';
import '../../../widgets/app_custom_text.dart';
import '../../../widgets/app_loading_bar.dart';
import '../../../widgets/dialog_box.dart';

class SingleSessionResult extends StatefulWidget {
  final CurrentSessionModel currentSessionModel;
  final bool isBackKey;
  StudentProfile studentProfile;

  ClassModel classModel;

  SingleSessionResult(
      {super.key,
      required this.currentSessionModel,
      required this.isBackKey,
      required this.studentProfile,
      required this.classModel});

  @override
  State<SingleSessionResult> createState() => _SingleSessionResultState();
}

class _SingleSessionResultState extends State<SingleSessionResult> {
  String selectedTerm = 'First';
  ResultBloc resultBloc = ResultBloc();
  late ResultDataTerm selectedResultTerm;
  late List<ResultDataTerm> terms;
  @override
  void initState() {
    super.initState();
    resultBloc.add(FetchSessionResult(widget.currentSessionModel.session,widget.currentSessionModel.id.toString()));
  }

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
                isBackKey: widget.isBackKey,
                studentProfile: widget.studentProfile,
                classModel: widget.classModel,
              ),
              BlocConsumer<ResultBloc, ResultState>(
                bloc: resultBloc,
                listenWhen: (previous, current) => current is! ResultInitial,
                buildWhen: (previous, current) => current is! ResultInitial,
                listener: (context, state) {
                  if (state is InitialSuccessState) {
                    // Handle state
                  } else if (state is AccessTokenExpireState) {
                    AppNavigator.pushAndRemovePreviousPages(context,
                        page: const SignPage());
                  } else if (state is ErrorState) {
                    MSG.warningSnackBar(context, state.error);
                  }
                },
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case InitialSuccessState:
                      final initialSuccessState = state as InitialSuccessState;
                      terms=initialSuccessState.resultModel.resultData.terms;
                      for(int i=0;i<terms.length;i++){
                        print(terms[i]);
                        if(terms[i].term.toLowerCase()==selectedTerm){
                          selectedResultTerm=terms[i];
                        }
                      }

                      ResultDataAnnual resultDataAnnual=initialSuccessState.resultModel.resultData.annual;
                      return Padding(
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
                                text:
                                    "${widget.currentSessionModel.session} Result",
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      scoreContainer(
                                        term: 'Total',
                                        isTitle: true,
                                      ),
                                       CustomText(
                                        text: selectedResultTerm.totalScore,
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
                                       CustomText(
                                        text: selectedResultTerm.averageScore,
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
                              GradesTable(
                                subjectResults: selectedResultTerm.subjectResults,
                              ),
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
                                remarkContainer("Punctuality", selectedResultTerm.behaviour.data.punctuality),
                                remarkContainer(
                                    "Class Attendance", selectedResultTerm.behaviour.data.classAttendance),
                                remarkContainer("Honesty", selectedResultTerm.behaviour.data.honesty),
                                remarkContainer(
                                    "Relationship With Peers", selectedResultTerm.behaviour.data.relationshipWithPeers),
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
                                remarkContainer("Reading", selectedResultTerm.psychomotor.data.reading),
                                remarkContainer("Creative Arts", selectedResultTerm.psychomotor.data.creativeArts),
                                remarkContainer("Public Speaking", selectedResultTerm.psychomotor.data.publicSpeaking),
                                remarkContainer("Sports", selectedResultTerm.psychomotor.data.sports),
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
                                 CustomText(
                                  text:
                                  selectedResultTerm.comments.classTeacher,
                                  size: 14,
                                  color: AppColors.black,
                                  weight: FontWeight.w400,
                                  maxLines: 10,
                                ),
                                remarkContainer("Principals", ""),
                                 CustomText(
                                  text:
                                  selectedResultTerm.comments.principal,
                                  size: 14,
                                  color: AppColors.black,
                                  weight: FontWeight.w400,
                                  maxLines: 10,
                                ),
                              ]
                            ],
                          ),
                        ),
                      );

                    case LoadingState:
                      return const Center(
                          child: AppLoadingPage(
                              "Your results are getting ready..."));

                    default:
                      return const Center(
                          child: AppLoadingPage(
                              "Your results are getting ready..."));
                  }
                },
              ),
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
