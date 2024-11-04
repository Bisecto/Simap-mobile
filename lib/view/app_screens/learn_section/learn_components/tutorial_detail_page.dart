import 'package:flutter/material.dart';
import 'package:simap/utills/app_navigator.dart';
import 'package:simap/utills/app_utils.dart';
import 'package:simap/view/app_screens/learn_section/learn_components/start_tutorial.dart';
import 'package:simap/view/widgets/form_button.dart';

import '../../../../model/student_profile.dart';
import '../../../../res/app_colors.dart';
import '../../../widgets/appBar_widget.dart';
import '../../../widgets/app_custom_text.dart';

class TutorialDetailPage extends StatefulWidget {
  StudentProfile studentProfile;
   TutorialDetailPage({super.key,required this.studentProfile});

  @override
  State<TutorialDetailPage> createState() => _TutorialDetailPageState();
}

class _TutorialDetailPageState extends State<TutorialDetailPage> {
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
                child: Container(
                  height: AppUtils.deviceScreenSize(context).height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: 'Arithmetic and Quantitative Reasoning',
                        size: 18,
                        weight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.network(
                          'https://www.ziprecruiter.com/svc/fotomat/public-ziprecruiter/cms/586046490OnlineMathTutor.jpg=ws1280x960',
                          width: double.infinity,
                          height: 180,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 16),
                      SizedBox(height: 8),
                      CustomText(
                        text:
                            'Simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s...',
                        size: 16,
                        color: AppColors.textColor,
                        maxLines: 10,
                      ),
                      SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CustomText(
                              text: '15 Slides',
                              size: 16,
                              color: AppColors.black,
                              weight: FontWeight.bold),
                          const SizedBox(width: 16),
                          Container(
                            width: 100,
                            height: 40,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 0,
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.timer_outlined,
                                    color: Colors.white, size: 20),
                                SizedBox(width: 8),
                                CustomText(
                                    text: '30 Mins',
                                    size: 16,
                                    color: Colors.white),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CustomText(
                                text: 'From:',
                                size: 16,
                                weight: FontWeight.bold,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Icon(Icons.person_pin,
                                  color: Colors.black54, size: 20),
                              SizedBox(width: 3),
                              CustomText(
                                text: 'Mr. Felix Nkantino',
                                size: 16,
                                color: Colors.black,
                                weight: FontWeight.w700,
                              ),
                            ],
                          ),
                        ],
                      ),
                      FormButton(
                        onPressed: () {
                          print(1234);
                          AppNavigator.pushAndStackPage(context, page: const StartTutorial());
                        },
                        text: "Start",
                        borderRadius: 10,
                        bgColor: Colors.green,
                      )
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
}
