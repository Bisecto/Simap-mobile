import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simap/res/app_colors.dart';
import 'package:simap/utills/app_navigator.dart';
import 'package:simap/view/app_screens/more_section/child_pages/profile_page.dart';
import 'package:simap/view/widgets/app_custom_text.dart';

import '../../res/app_icons.dart';
import '../../res/app_images.dart';

class MainAppBar extends StatelessWidget {
  final bool isBackKey;

  const MainAppBar({super.key, this.isBackKey = false});

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
        padding: const EdgeInsets.fromLTRB(10.0, 0, 10, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (isBackKey)
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.black,
                  )),
            if (!isBackKey) SvgPicture.asset(AppIcons.notification),
            Row(
              children: [
                const CustomText(text: "#UHS20220147"),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    AppNavigator.pushAndStackPage(context,
                        page: const ProfilePage());
                  },
                  child: const CircleAvatar(
                    backgroundColor: AppColors.mainAppColor,
                    backgroundImage: AssetImage(AppImages.person),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
