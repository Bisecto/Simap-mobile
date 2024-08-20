import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simap/res/app_colors.dart';
import 'package:simap/view/widgets/app_custom_text.dart';

import '../../res/app_icons.dart';
import '../../res/app_images.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0,0,10,0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(AppIcons.notification),
            const Row(children: [
              CustomText(text:"#UHS20220147"),
              SizedBox(width: 5,),
              CircleAvatar(
                backgroundColor: AppColors.mainAppColor,
                backgroundImage: AssetImage(AppImages.person),
              )
            ],)
          ],
        ),
      ),
    );
  }
}
