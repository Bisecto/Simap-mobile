import 'package:flutter/material.dart';
import 'package:simap/res/app_images.dart';
import 'package:simap/utills/app_utils.dart';
import 'package:simap/view/widgets/app_custom_text.dart';

import '../../../res/app_colors.dart';

class QuickAccessContainer extends StatelessWidget {
  final String img;
  final String text;
  const QuickAccessContainer({super.key,required this.text,required this.img});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: AppUtils.deviceScreenSize(context).width / 5.5,
        height: 80,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(img,height: 40,width: 40,),
            CustomText(text: text,)
          ],
        ),
      ),
    );
  }
}
