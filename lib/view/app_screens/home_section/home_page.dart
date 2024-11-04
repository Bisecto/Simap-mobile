import 'package:flutter/material.dart';
import 'package:simap/model/class_model.dart';
import 'package:simap/model/student_profile.dart';
import 'package:simap/res/app_images.dart';
import 'package:simap/utills/app_navigator.dart';
import 'package:simap/view/app_screens/home_section/home_page_components/quick_access_container.dart';
import 'package:simap/view/app_screens/library_section/library_page.dart';
import 'package:simap/view/app_screens/quiz_section/available_quiz_subject.dart';
import 'package:simap/view/widgets/app_custom_text.dart';

import '../../../res/app_colors.dart';
import '../../widgets/appBar_widget.dart';
import '../assignment_section/assignment_page.dart';
import '../learn_section/learn_page.dart';
import '../store_section/store_page.dart';
import 'home_page_components/billboard.dart';
import 'home_page_components/welcome_container.dart';

class HomePage extends StatefulWidget {
  StudentProfile studentProfile;
  ClassModel classModel;
  HomePage({super.key,required this.studentProfile,required this.classModel});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
               MainAppBar( studentProfile: widget.studentProfile,),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     WelcomeContainer(
                      welcomeMsg: 'Welcome 👋',
                      mainText: '${widget.studentProfile.studentFullname.split(' ')[0]}\n${widget.studentProfile.studentFullname.replaceAll(widget.studentProfile.studentFullname.split(' ')[0], '')}'.trim(),
                      subText: 'You\'re in ${widget.classModel.className.className}',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const CustomText(
                      text: 'Quick Access',
                      size: 18,
                      weight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap:(){
                            AppNavigator.pushAndStackPage(context, page:  LearnPage(studentProfile: widget.studentProfile,));
                          },
                          child: const QuickAccessContainer(
                            text: 'Learn',
                            img: AppImages.learn,
                          ),
                        ),
                        const QuickAccessContainer(
                          text: 'Fees',
                          img: AppImages.fees,
                        ),
                        GestureDetector(
                          onTap: (){
                            AppNavigator.pushAndStackPage(context, page: StorePage(studentProfile: widget.studentProfile,));
                          },
                          child: const QuickAccessContainer(
                            text: 'Store',
                            img: AppImages.store,
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            AppNavigator.pushAndStackPage(context, page:  LibraryPage(studentProfile: widget.studentProfile,));

                          },
                          child: const QuickAccessContainer(
                            text: 'Library',
                            img: AppImages.library,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const CustomText(
                      text: 'Billboard',
                      size: 18,
                      weight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                    const Billboard(),
                    const SizedBox(
                      height: 20,
                    ),
                    ...[
                      //moreActionsContainer(AppImages.book, "Library", '40'),
                      InkWell(onTap:(){AppNavigator.pushAndStackPage(context, page:  AvailableSubjects(studentProfile: widget.studentProfile,));},child: moreActionsContainer(AppImages.quiz, "Quiz", '5')),
                      InkWell(
                        onTap: (){
                          AppNavigator.pushAndStackPage(context, page:  AssignmentPage(studentProfile: widget.studentProfile,));
                        },
                        child: moreActionsContainer(
                            AppImages.assignment, "Assignment", '2'),
                      ),
                    ],
                    const SizedBox(
                      height: 20,
                    ),
                    ...[
                      topPerformerContainer(),
                      const SizedBox(
                        height: 5,
                      ),
                      topPerformerChildContainer("Okafor precious","95",AppImages.goldMedal),
                      topPerformerChildContainer("Okafor precious","85",AppImages.silverMedal),
                      topPerformerChildContainer("Okafor precious","75",AppImages.bronzeMedal),
                    ]
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

  Widget topPerformerContainer() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        height: 60,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          color: const Color(0xFFB2EBF2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Image.asset(
              AppImages.topPerformer,
              height: 25,
              width: 25,
            ),
            const SizedBox(
              width: 10,
            ),
            const CustomText(
              text: "Top Performers in JSS 2C",
              size: 18,
              weight: FontWeight.bold,
              color: AppColors.black,
            ),
          ],
        ),
      ),
    );
  }
  Widget topPerformerChildContainer( String text, String score,String medal) {
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.textColor.withOpacity(0.3),
                  backgroundImage: const AssetImage(AppImages.studentImage,),
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
                      text: score,
                      size: 14,
                      weight: FontWeight.w500,
                      color: AppColors.textColor,
                    )
                  ],
                )
              ],
            ),
            Image.asset(medal)
          ],
        ),
      ),
    );
  }

}
