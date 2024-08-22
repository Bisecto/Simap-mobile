import 'package:animated_icon/animated_icon.dart';
import 'package:flutter/material.dart';
import 'package:simap/res/app_images.dart';
import 'package:simap/view/app_screens/more_section/child_pages/profile_page.dart';
import 'package:simap/view/app_screens/onbaording_screens/setup.dart';

import '../../../res/app_colors.dart';
import '../../../utills/app_navigator.dart';
import '../../widgets/app_custom_text.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFC),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.logo,
                      height: 100,
                      width: 100,
                    ),
                    const CustomText(
                      text: 'Nnamdi Azikiwe High School',
                      size: 18,
                      weight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  AppNavigator.pushAndStackPage(context,
                      page: const ProfilePage());
                },
                child: itemContainer(
                  Icons.perm_identity,
                  'Profile',
                ),
              ),
              // itemContainer(Icons.shopping_cart,'Stores',),
              // itemContainer(Icons.pie_chart_outline,'My Performance',),
              // itemContainer(Icons.archive_outlined,'Archive',),
              // itemContainer(Icons.menu_book_sharp,'Profile',),
              // itemContainer(Icons.videogame_asset_rounded,'Games',),
              // const SizedBox(height: 20,),
              itemContainer(
                Icons.help,
                'Help',
              ),
              InkWell(onTap: (){
                AppNavigator.pushAndRemovePreviousPages(context, page: const AppSetUp());
              },
                child: itemContainer(
                  Icons.refresh,
                  'Reset Setup',
                ),
              ),
              itemContainer(
                Icons.settings,
                'Settings',
              ),
              const SizedBox(
                height: 20,
              ),
              itemContainer(
                Icons.settings,
                'About NSH',
              ),
              itemContainer(
                Icons.settings,
                'About SIMAP',
              ),
              const SizedBox(
                height: 20,
              ),
              logOutContainer(),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(
                      text: 'Powered by',
                      color: AppColors.textColor,
                      size: 12,
                    ),
                    Image.asset(
                      AppImages.appleadLogo,
                      height: 40,
                      width: 130,
                      //color: AppColors.darkModeBlack,
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  Widget itemContainer(
    IconData icon,
    String title,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Container(
        height: 50,
        padding: const EdgeInsets.all(5),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: AppColors.textColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                CustomText(
                  text: title,
                  size: 14,
                  weight: FontWeight.w600,
                  color: AppColors.textColor,
                )
              ],
            ),
            const Icon(
              Icons.navigate_next_outlined,
              color: AppColors.textColor,
            )
          ],
        ),
      ),
    );
  }

  Widget logOutContainer() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Container(
        height: 50,
        width: 100,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          color: AppColors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.logout,
              color: AppColors.white,
            ),
            SizedBox(
              width: 5,
            ),
            CustomText(
              text: 'Logout',
              size: 14,
              weight: FontWeight.w600,
              color: AppColors.white,
            )
          ],
        ),
      ),
    );
  }
}
