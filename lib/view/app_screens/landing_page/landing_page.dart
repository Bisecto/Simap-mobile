import 'dart:io';

import 'package:animated_icon/animated_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'package:simap/view/app_screens/games_section/games_page.dart';
import 'package:simap/view/app_screens/home_section/home_page.dart';
import 'package:simap/view/app_screens/more_section/more_page.dart';
import 'package:simap/view/app_screens/result_section/result_page.dart';

import '../../../res/app_colors.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as modalSheet;

class LandingPage extends StatefulWidget {
  int selectedIndex;

  LandingPage({super.key, required this.selectedIndex});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  List<Widget> views = const [];

  int selectedIndex = 0;

  //int selectedIndex = 0;
  bool isNotification = false;

  @override
  void initState() {
    // TODO: implement initState
    selectedIndex = widget.selectedIndex;
    //topicInitialization();

    views = [
      const HomePage(),
      const ResultPage(),
      const GamesPage(),
      const MorePage(),
    ];
    super.initState();
  }

  final _androidAppRetain = const MethodChannel("android_app_retain");

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Platform.isAndroid) {
          if (Navigator.of(context).canPop()) {
            return Future.value(true);
          } else {
            _androidAppRetain.invokeMethod("sendToBackground");
            return Future.value(false);
          }
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xFFFCFCFC),
        body: IndexedStack(
          index: selectedIndex,
          children: views,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xFFFCFCFC),
          showUnselectedLabels: true,
          currentIndex: selectedIndex,
          selectedItemColor: AppColors.mainAppColor,
          unselectedItemColor: AppColors.lightDivider,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: AnimateIcon(
                key: UniqueKey(),
                onTap: () {},
                iconType: IconType.onlyIcon,
                height: 25,
                width: 25,
                color: selectedIndex == 0
                    ? AppColors.mainAppColor
                    : AppColors.lightDivider,
                animateIcon: AnimateIcons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(

              icon: AnimateIcon(

                key: UniqueKey(),
                onTap: () {},
                iconType: IconType.onlyIcon,
                height: 25,
                width: 25,
                color: selectedIndex == 1
                    ? AppColors.mainAppColor
                    : AppColors.lightDivider,
                animateIcon: AnimateIcons.file,
              ),
              label: 'Results',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.games_outlined,
                color: selectedIndex == 2
                    ? AppColors.mainAppColor
                    : AppColors.lightDivider,
              ), //Icon(Icons.home),
              label: 'Games',
            ),
            BottomNavigationBarItem(
              icon: AnimateIcon(
                key: UniqueKey(),
                onTap: () {},
                iconType: IconType.onlyIcon,
                height: 25,
                width: 25,
                color: selectedIndex == 3
                    ? AppColors.mainAppColor
                    : AppColors.lightDivider,
                animateIcon: AnimateIcons.settings,
              ), //Icon(Icons.home),
              label: 'More',
            ),
          ],
        ),
      ),
    );
  }
}
