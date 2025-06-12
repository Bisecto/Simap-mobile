import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simap/model/class_model.dart';
import 'package:simap/model/session_model.dart';
import 'package:simap/res/app_images.dart';
import 'package:simap/utills/app_navigator.dart';
import 'package:simap/utills/app_utils.dart';
import 'package:simap/view/app_screens/result_section/result_section_screens/single_session_result.dart';

import '../../../../bloc/result_bloc/result_bloc.dart';
import '../../../../model/school_model.dart';
import '../../../../model/student_profile.dart';
import '../../../../res/app_colors.dart';
import '../../../widgets/app_loading_bar.dart';
import '../../../widgets/dialog_box.dart';
import '../../auth/sign_page.dart';

class ListResultSession extends StatefulWidget {
  StudentProfile studentProfile;
  ClassModel classModel;
  final SchoolModel schoolModel;

//Session session;
  ListResultSession(
      {super.key,
      required this.studentProfile,
      required this.classModel,
      required this.schoolModel});

  @override
  State<ListResultSession> createState() => _ListResultSessionState();
}

class _ListResultSessionState extends State<ListResultSession> {
  // final List<String> sessions = [
  ResultBloc resultBloc = ResultBloc();

  late List<CurrentSessionModel> sessions = [];

  @override
  void initState() {
    // TODO: implement initState
    resultBloc.add(FetchSession());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResultBloc, ResultState>(
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
          case const (ArchivedSuccessState):
            final archivedSuccessState = state as ArchivedSuccessState;
            sessions = archivedSuccessState.sessionsList;
            return ListView.builder(
              itemCount: sessions.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      // AppNavigator.pushAndStackPage(context,
                      //     page: SingleSessionResult(
                      //       session: sessions[index],
                      //       isBackKey: true,
                      //       studentProfile: studentProfile, classModel:classModel, currentSessionModel: null,
                      //     ));
                    },
                    child: SessionContainer(
                        session: sessions[index], context: context));
              },
            );

          case LoadingState:
            return const Center(
                child: AppLoadingPage(
                    "Your archived sessions are getting ready..."));

          default:
            return const Center(
                child: AppLoadingPage("Your results are getting ready..."));
        }
      },
    );
  }

  Widget SessionContainer(
      {required CurrentSessionModel session, required context}) {
    return GestureDetector(
      onTap: () {
        AppNavigator.pushAndStackPage(context,
            page: SingleSessionResult(
              currentSessionModel: session,
              isBackKey: true,
              studentProfile: widget.studentProfile,
              classModel: widget.classModel,
              schoolModel: widget.schoolModel,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 300,
          padding: const EdgeInsets.all(15),
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 190,
                  width: AppUtils.deviceScreenSize(context).width,
                  decoration: BoxDecoration(
                    color: AppColors.quickAccessContainerColor,
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
                  child: Image.asset(
                    AppImages.testPassed,
                    height: 150,
                    width: 150,
                  ),
                ),
                Text(
                  session.session,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
