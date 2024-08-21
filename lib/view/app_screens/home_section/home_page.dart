import 'package:flutter/material.dart';
import 'package:simap/res/app_images.dart';
import 'package:simap/view/app_screens/home_section/home_page_components/quick_access_container.dart';
import 'package:simap/view/widgets/app_custom_text.dart';

import '../../../res/app_colors.dart';
import '../../widgets/appBar_widget.dart';
import 'home_page_components/billboard.dart';
import 'home_page_components/welcome_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFFCFCFC),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            MainAppBar(),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WelcomeContainer(),
                  SizedBox(
                    height: 20,
                  ),
                  CustomText(
                    text: 'Quick Access',
                    size: 18,
                    weight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      QuickAccessContainer(
                        text: 'Learn',
                        img: AppImages.learn,
                      ),
                      QuickAccessContainer(
                        text: 'Fees',
                        img: AppImages.fees,
                      ),
                      QuickAccessContainer(
                        text: 'Store',
                        img: AppImages.store,
                      ),
                      QuickAccessContainer(
                        text: 'Library',
                        img: AppImages.library,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomText(
                    text: 'Billboard',
                    size: 18,
                    weight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                  Billboard(),
                  //moreActionsContainer(AppImages.appleadLogo,"Library")
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  Widget moreActionsContainer(String icon,String text, String num) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        height: 50,
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
        child: const Row(
          children: [],
        ),
      ),
    );
  }
}
