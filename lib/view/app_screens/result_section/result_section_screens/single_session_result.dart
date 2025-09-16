import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simap/model/school_model.dart';
import 'package:simap/model/session_model.dart';
import 'package:simap/utills/app_navigator.dart';
import 'package:simap/view/app_screens/auth/sign_page.dart';
import 'package:simap/view/app_screens/result_section/result_section_screens/result_pdf_generator.dart';
import 'package:simap/view/app_screens/result_section/result_section_screens/term_list/annual_grade_table.dart';
import 'package:simap/view/app_screens/result_section/result_section_screens/term_list/full_annual_result.dart';
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
  final SessionModel currentSessionModel;
  final SchoolModel schoolModel;
  final bool isBackKey;
  StudentProfile studentProfile;
  ClassModel classModel;

  SingleSessionResult(
      {super.key,
      required this.currentSessionModel,
      required this.isBackKey,
      required this.studentProfile,
      required this.schoolModel,
      required this.classModel});

  @override
  State<SingleSessionResult> createState() => _SingleSessionResultState();
}

class _SingleSessionResultState extends State<SingleSessionResult> {
  String selectedTerm = 'First';
  ResultBloc resultBloc = ResultBloc();

  late List<ResultDataTerm> terms = [];

  @override
  void initState() {
    super.initState();
    resultBloc.add(FetchSessionResult(widget.currentSessionModel.session,
        widget.currentSessionModel.id.toString()));
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
                  }
                  // else if (state is ErrorState) {
                  //   MSG.warningSnackBar(context, state.error);
                  // }
                },
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case const (InitialSuccessState):
                      final initialSuccessState = state as InitialSuccessState;
                      terms = initialSuccessState.resultModel.resultData.terms;

                      /// ResultDataTerm selectedResultTerm = terms[0];
                      ResultDataTerm? selectedResultTerm;
                      if (terms.isNotEmpty) {
                        selectedResultTerm = terms[0];
                      } else {
                        selectedResultTerm = null; // or handle empty case
                      }
                      for (int i = 0; i < terms.length; i++) {
                        print(terms[i]);
                        if (terms[i].term.toLowerCase() ==
                            selectedTerm.toLowerCase()) {
                          selectedResultTerm = terms[i];
                        }
                      }

                      ResultDataAnnual resultDataAnnual =
                          initialSuccessState.resultModel.resultData.annual;
                      return terms.isEmpty
                          ? _buildEmptyState()
                          : Padding(
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
                                        //setState(() {
                                        setState(() {
                                          selectedTerm = term;
                                          // for (int i = 0; i < terms.length; i++) {
                                          //   print(terms[i]);
                                          //   if (terms[i].term.toLowerCase() == selectedTerm.toLowerCase()) {
                                          //     selectedResultTerm = terms[i];
                                          //   }
                                          // }
                                        });
                                        // });
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    if (selectedTerm.toLowerCase() ==
                                        'annual') ...[
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
                                          GestureDetector(
                                            onTap: () async {
                                              if (selectedTerm.toLowerCase() ==
                                                  'annual') {
                                                await StudentResultPdfGenerator
                                                    .generatePdf(
                                                  studentProfile:
                                                      widget.studentProfile,
                                                  school: widget.schoolModel,
                                                  academicSession: widget
                                                      .currentSessionModel
                                                      .session,
                                                  className: widget.classModel
                                                      .className.className,
                                                  termName: selectedTerm,
                                                  annualData: resultDataAnnual,
                                                );
                                              } else {
                                                await StudentResultPdfGenerator
                                                    .generatePdf(
                                                  studentProfile:
                                                      widget.studentProfile,
                                                  school: widget.schoolModel,
                                                  academicSession: widget
                                                      .currentSessionModel
                                                      .session,
                                                  className: widget.classModel
                                                      .className.className,
                                                  termName: selectedTerm,
                                                  termData: selectedResultTerm,
                                                );
                                              }
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                color: AppColors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.15),
                                                    spreadRadius: 0,
                                                    blurRadius: 10,
                                                    offset: const Offset(0, 4),
                                                  ),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CustomText(
                                                    text: 'Download',
                                                    size: 16,
                                                    weight: FontWeight.w600,
                                                    color:
                                                        AppColors.mainAppColor,
                                                  ),
                                                  Icon(Icons.download)
                                                ],
                                              ),
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
                                                text: resultDataAnnual
                                                    .annualTotal,
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
                                                text: resultDataAnnual
                                                    .annualAverage,
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
                                      AnnualGradesTable(
                                          subjectResults:
                                              resultDataAnnual.subjectResults),
                                      FormButton(
                                        onPressed: () {
                                          AppNavigator.pushAndStackPage(context,
                                              page: AnnualFullResultPage(
                                                resultDataAnnual:
                                                    resultDataAnnual,
                                              ));
                                        },
                                        bgColor: AppColors.mainAppColor,
                                        text: "View full result",
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                    ] else ...[
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
                                          GestureDetector(
                                            onTap: () async {
                                              if (selectedTerm.toLowerCase() ==
                                                  'annual') {
                                                await StudentResultPdfGenerator
                                                    .generatePdf(
                                                  studentProfile:
                                                      widget.studentProfile,
                                                  school: widget.schoolModel,
                                                  academicSession: widget
                                                      .currentSessionModel
                                                      .session,
                                                  className: widget.classModel
                                                      .className.className,
                                                  termName: selectedTerm,
                                                  annualData: resultDataAnnual,
                                                );
                                              } else {
                                                await StudentResultPdfGenerator
                                                    .generatePdf(
                                                  studentProfile:
                                                      widget.studentProfile,
                                                  school: widget.schoolModel,
                                                  academicSession: widget
                                                      .currentSessionModel
                                                      .session,
                                                  className: widget.classModel
                                                      .className.className,
                                                  termName: selectedTerm,
                                                  termData: selectedResultTerm,
                                                );
                                              }
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                color: AppColors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.15),
                                                    spreadRadius: 0,
                                                    blurRadius: 10,
                                                    offset: const Offset(0, 4),
                                                  ),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CustomText(
                                                    text: 'Download',
                                                    size: 16,
                                                    weight: FontWeight.w600,
                                                    color:
                                                        AppColors.mainAppColor,
                                                  ),
                                                  Icon(Icons.download)
                                                ],
                                              ),
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
                                                text: selectedResultTerm!
                                                    .totalScore,
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
                                                text: selectedResultTerm
                                                    .averageScore,
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
                                        subjectResults:
                                            selectedResultTerm.subjectResults,
                                      ),
                                      FormButton(
                                        onPressed: () {
                                          AppNavigator.pushAndStackPage(context,
                                              page: FullResultPage(
                                                fullResults: selectedResultTerm!
                                                    .subjectResults,
                                              ));
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
                                        remarkContainer(
                                            "Punctuality",
                                            selectedResultTerm
                                                .behaviour.data.punctuality),
                                        remarkContainer(
                                            "Class Attendance",
                                            selectedResultTerm.behaviour.data
                                                .classAttendance),
                                        remarkContainer(
                                            "Honesty",
                                            selectedResultTerm
                                                .behaviour.data.honesty),
                                        remarkContainer(
                                            "Relationship With Peers",
                                            selectedResultTerm.behaviour.data
                                                .relationshipWithPeers),
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
                                        remarkContainer(
                                            "Reading",
                                            selectedResultTerm
                                                .psychomotor.data.reading),
                                        remarkContainer(
                                            "Creative Arts",
                                            selectedResultTerm
                                                .psychomotor.data.creativeArts),
                                        remarkContainer(
                                            "Public Speaking",
                                            selectedResultTerm.psychomotor.data
                                                .publicSpeaking),
                                        remarkContainer(
                                            "Sports",
                                            selectedResultTerm
                                                .psychomotor.data.sports),
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
                                          text: selectedResultTerm
                                              .comments.classTeacher,
                                          size: 14,
                                          color: AppColors.black,
                                          weight: FontWeight.w400,
                                          maxLines: 10,
                                        ),
                                        remarkContainer("Principals", ""),
                                        CustomText(
                                          text: selectedResultTerm
                                              .comments.principal,
                                          size: 14,
                                          color: AppColors.black,
                                          weight: FontWeight.w400,
                                          maxLines: 10,
                                        ),
                                      ]
                                    ]
                                  ],
                                ),
                              ),
                            );
                    case ErrorState:
                      final errorState = state as ErrorState;

                      return ErrorMessageWidget(
                        message: errorState.error,
                        onRetry: () {
                          resultBloc.add(FetchSessionResult(
                              widget.currentSessionModel.session,
                              widget.currentSessionModel.id.toString()));
                        },
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            'No result terms available',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Please try again later or contact support',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              resultBloc.add(FetchSessionResult(
                  widget.currentSessionModel.session,
                  widget.currentSessionModel.id.toString()));
            },
            child: Text('Retry'),
          ),
        ],
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

class ErrorMessageWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final IconData? icon;

  const ErrorMessageWidget({
    Key? key,
    required this.message,
    this.onRetry,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.error_outline,
              size: 64,
              color: Colors.red[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Oops! Something went wrong',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            if (onRetry != null)
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
