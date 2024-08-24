import 'package:flutter/material.dart';
import 'package:simap/view/app_screens/learn_section/tutorial_list.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_images.dart';
import '../../../utills/app_navigator.dart';
import '../../widgets/appBar_widget.dart';
import '../../widgets/app_custom_text.dart';
import '../assignment_section/assignment_page.dart';
import '../home_section/home_page_components/welcome_container.dart';
import '../quiz_section/available_quiz_subject.dart';

class LearnPage extends StatefulWidget {
  const LearnPage({super.key});

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  @override
  Widget build(BuildContext context) {
    return       Scaffold(
      backgroundColor: const Color(0xFFFCFCFC),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const MainAppBar(isBackKey: true,),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const WelcomeContainer(
                          welcomeMsg: 'Hello Champ 👋',
                          mainText: 'Okafor\nPrecious Chiemerie', subText: '',
                        ),
                        const SizedBox(
                          height: 20,
                        ),


                        ...[
                          moreActionsContainer(AppImages.book, "Library", '40'),
                          InkWell(onTap:(){AppNavigator.pushAndStackPage(context, page: const AvailableSubjects());},child: moreActionsContainer(AppImages.quiz, "Quiz", '5')),
                          InkWell(
                            onTap: (){
                              AppNavigator.pushAndStackPage(context, page: const AssignmentPage());
                            },
                            child: moreActionsContainer(
                                AppImages.assignment, "Assignment", '2'),
                          ),
                        ],
                        const SizedBox(
                          height: 20,
                        ),
                        TutorialListPage()

                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
  Widget moreActionsContainer(String img, String text, String num) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        height: 60,
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
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.textColor.withOpacity(0.3),
              //backgroundImage: AssetImage(img,),
              child: Image.asset(
                img,
                height: 25,
                width: 25,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: text,
                  size: 16,
                  weight: FontWeight.bold,
                  color: AppColors.black,
                ),
                CustomText(
                  text: num,
                  size: 14,
                  weight: FontWeight.w500,
                  color: AppColors.textColor,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

}
