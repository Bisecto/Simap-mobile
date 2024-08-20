import 'package:flutter/material.dart';
import 'package:simap/res/app_icons.dart';
import 'package:simap/utills/app_utils.dart';
import 'package:simap/view/widgets/app_custom_text.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_images.dart';

class WelcomeContainer extends StatelessWidget {
  const WelcomeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: AppUtils
          .deviceScreenSize(context)
          .width,
      decoration: BoxDecoration(
        color: AppColors.lightRed,
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
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: "Welcome 👋",
                  color: AppColors.white,
                  weight: FontWeight.w400,
                  size: 14,
                ),
                SizedBox(
                    //height: 100,
                    width: AppUtils
                        .deviceScreenSize(context)
                        .width/2,
                    child: const CustomText(
                      text: "Okafor \nPrecious Chiemerie",
                      color: AppColors.white,
                      weight: FontWeight.w800,
                      maxLines: 2,
                      size: 16,
                    ),
                ),
                const CustomText(
                  text: "You're in JSS 2C",
                  color: AppColors.white,
                  weight: FontWeight.w300,
                  size: 14,
                ),
              ],
            ),
            Image.asset(AppImages.Abacus)
          ],
        ),
      ),
    );
  }
}
