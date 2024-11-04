import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:simap/model/school_model.dart';
import 'package:simap/model/session_model.dart';
import 'package:simap/model/student_profile.dart';
import 'package:simap/model/subject.dart';

import 'package:simap/view/app_screens/games_section/games_page.dart';
import 'package:simap/view/app_screens/home_section/home_page.dart';
import 'package:simap/view/app_screens/more_section/more_page.dart';
import 'package:simap/view/app_screens/result_section/result_page.dart';

import '../../../model/class_model.dart';
import '../../../res/app_colors.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as modalSheet;

import '../result_section/result_section_screens/single_session_result.dart';

class LandingPage extends StatefulWidget {
  int selectedIndex;
  StudentProfile studentProfile;
  CurrentSessionModel sessionModel;
  List<Subject> subjectList;
  SchoolModel schoolModel;
  ClassModel classModel;

  LandingPage(
      {super.key,
      required this.selectedIndex,
      required this.subjectList,
      required this.schoolModel,
      required this.sessionModel,
      required this.studentProfile,
      required this.classModel});

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
      HomePage(
        studentProfile: widget.studentProfile,
        classModel: widget.classModel,
      ),
      SingleSessionResult(
        session: '2024/2024',
        isBackKey: false,
        studentProfile: widget.studentProfile, classModel: widget.classModel,
      ),
      const GamesPage(),
      MorePage(
        studentProfile: widget.studentProfile, schoolModel: widget.schoolModel, classModel: widget.classModel,
      ),
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
        backgroundColor: const Color(0xFFFFFFFF),
        body: IndexedStack(
          index: selectedIndex,
          children: views,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xFFFFFFFF),
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
              icon: Icon(
                Icons.home_outlined,
                color: selectedIndex == 0
                    ? AppColors.mainAppColor
                    : AppColors.lightDivider,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.menu_book_outlined,
                color: selectedIndex == 1
                    ? AppColors.mainAppColor
                    : AppColors.lightDivider,
              ),
              label: 'Results',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.videogame_asset,
                color: selectedIndex == 2
                    ? AppColors.mainAppColor
                    : AppColors.lightDivider,
              ), //Icon(Icons.home),
              label: 'Games',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.more_horiz,
                color: selectedIndex == 3
                    ? AppColors.mainAppColor
                    : AppColors.lightDivider,
              ), //Icon(Icons.home),
              label: 'More',
            ),
          ],
        ),
      ),
    );
  }
}
