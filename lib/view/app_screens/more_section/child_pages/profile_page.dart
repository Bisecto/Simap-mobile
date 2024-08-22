import 'package:flutter/material.dart';
import 'package:simap/res/app_images.dart';

import '../../../../res/app_colors.dart';
import '../../../widgets/app_custom_text.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Row(
                children: [
                  Icon(Icons.arrow_back_ios),
                  CustomText(
                    text: 'Profile',
                    color: AppColors.black,
                    weight: FontWeight.bold,
                    size: 16,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage(AppImages.studentImage),
            ),
            const SizedBox(
              height: 10,
            ),
            const CustomText(
              text: 'Okafor',
              color: AppColors.black,
              weight: FontWeight.bold,
              size: 20,
            ),
            const CustomText(
              text: 'Precious Chiemerie',
              color: AppColors.textColor,
              weight: FontWeight.w400,
              size: 16,
            ),
            const SizedBox(
              height: 20,
            ),
            profileDetailContainer('Female',"Gender"),
            profileDetailContainer('10th June, 2018',"Date Of Birth"),
            profileDetailContainer('Class',"Primary 6A"),
          ],
        ),
      )),
    );
  }
  Widget profileDetailContainer(title, sub) {
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
              text: sub,
              size: 14,
              color: AppColors.textColor,
              weight: FontWeight.w400,
            ),
            CustomText(
              text: title,
              size: 16,
              color: AppColors.black,
              weight: FontWeight.bold,
            ),

          ],
        ),
      ),
    );
  }

}
