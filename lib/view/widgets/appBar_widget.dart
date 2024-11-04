import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simap/model/student_profile.dart';
import 'package:simap/res/app_colors.dart';
import 'package:simap/res/shared_preferenceKey.dart';
import 'package:simap/utills/app_navigator.dart';
import 'package:simap/utills/shared_preferences.dart';
import 'package:simap/view/app_screens/more_section/child_pages/profile_page.dart';
import 'package:simap/view/widgets/app_custom_text.dart';

import '../../res/apis.dart';
import '../../res/app_icons.dart';
import '../../res/app_images.dart';

class MainAppBar extends StatefulWidget {
  StudentProfile studentProfile;
  final bool isBackKey;

   MainAppBar({super.key, this.isBackKey = false,required this.studentProfile});

  @override
  State<MainAppBar> createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  String studentImage='';
  @override
  void initState() {
    // TODO: implement initState
    getSavedData();
    super.initState();
  }
  getSavedData() async {
   String schoolIdKey=await SharedPref.getString(SharedPreferenceKey().schoolIdKey);
   setState(() {
     studentImage="${AppApis.http + schoolIdKey +widget.studentProfile.studentImage}";
     print(studentImage);
   });
   
  }
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
            if (widget.isBackKey)
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.black,
                  )),
            if (!widget.isBackKey) SvgPicture.asset(AppIcons.notification),
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
                  child:  CircleAvatar(
                    backgroundColor: AppColors.mainAppColor,
                    backgroundImage: NetworkImage(widget.studentProfile.studentImage)//AssetImage(AppImages.person),
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
