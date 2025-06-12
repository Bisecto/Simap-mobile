import 'package:flutter/material.dart';
import '../../../model/class_model.dart';
import '../../../model/school_model.dart';
import '../../../model/student_profile.dart';
import '../../../res/app_colors.dart';
import '../../widgets/appBar_widget.dart';
import '../../widgets/app_custom_text.dart';
import 'result_section_screens/list_result_session.dart';

class ResultPage extends StatefulWidget {
  StudentProfile studentProfile;
  ClassModel classModel;
  final SchoolModel schoolModel;


  ResultPage({super.key,required this.studentProfile,required this.classModel, required this.schoolModel});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
               MainAppBar(isBackKey: true,studentProfile: widget.studentProfile, classModel: widget.classModel,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: 'Student\'s Results',
                        size: 18,
                        weight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                      const SizedBox(height: 10),
                      const CustomText(
                        text: 'Pick the Session you would like to View it\'s Result Report.',
                        size: 16,
                        weight: FontWeight.w400,
                        color: AppColors.textColor,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListResultSession(studentProfile: widget.studentProfile, classModel: widget.classModel, schoolModel: widget.schoolModel,),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
