import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simap/model/class_model.dart';
import 'package:simap/model/school_model.dart';
import 'package:simap/model/session_model.dart';
import 'package:simap/model/student_profile.dart';
import 'package:simap/res/app_images.dart';
import 'package:simap/view/app_screens/auth/sign_page.dart';
import 'package:simap/view/app_screens/library_section/library_page.dart';
import 'package:simap/view/app_screens/more_section/child_pages/profile_page.dart';
import 'package:simap/view/app_screens/onbaording_screens/setup.dart';
import 'package:simap/view/app_screens/store_section/store_page.dart';

import '../../../app_repository/store_service.dart';
import '../../../bloc/store_bloc/store_bloc.dart';
import '../../../res/apis.dart';
import '../../../res/app_colors.dart';
import '../../../res/shared_preferenceKey.dart';
import '../../../utills/app_navigator.dart';
import '../../../utills/shared_preferences.dart';
import '../../widgets/app_custom_text.dart';
import '../result_section/result_page.dart';
import 'child_pages/performance/performance_page.dart';

class MorePage extends StatefulWidget {
  StudentProfile studentProfile;
  SchoolModel schoolModel;
  ClassModel classModel;
  final SessionModel currentSessionModel;
  final List<SessionModel> sessionsList;

  MorePage(
      {super.key,
      required this.studentProfile,
      required this.schoolModel,
      required this.classModel,
      required this.currentSessionModel,
      required this.sessionsList});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  String logo = '';

  @override
  void initState() {
    // TODO: implement initState
    getSavedData();
    super.initState();
  }

  getSavedData() async {
    String schoolIdKey =
        await SharedPref.getString(SharedPreferenceKey().schoolIdKey);
    setState(() {
      logo = AppApis.http +
          schoolIdKey +
          AppApis.appBaseUrl +
          widget.schoolModel.logo;
      print(logo);
    });
  }

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
                    Image.network(
                      logo,
                      height: 100,
                      width: 100,
                    ),
                    CustomText(
                      text: widget.schoolModel.name,
                      size: 18,
                      maxLines: 3,
                      weight: FontWeight.bold,
                      color: AppColors.black,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  AppNavigator.pushAndStackPage(context,
                      page: ProfilePage(
                        studentProfile: widget.studentProfile,
                        currentClass: widget.classModel,
                      ));
                },
                child: itemContainer(
                  Icons.perm_identity,
                  'Profile',
                ),
              ),
              InkWell(
                onTap: () {
                  AppNavigator.pushAndStackPage(context,
                      page: BlocProvider(
                        create: (context) => StoreBloc(
                          storeService: StoreService(),
                        ),
                        child: const StoreScreen(), // This was missing!
                      ));
                },
                child: itemContainer(
                  Icons.shopping_cart,
                  'Stores',
                ),
              ),
              InkWell(
                  onTap: () {
                    AppNavigator.pushAndStackPage(context,
                        page: PerformancePage(
                          studentProfile: widget.studentProfile,
                          classModel: widget.classModel,
                          schoolModel: widget.schoolModel,
                          currentSessionModel: widget.currentSessionModel,
                          sessionsList: widget.sessionsList,
                        )); //PerformancePage(studentProfile: widget.studentProfile, classModel: widget.classModel,));
                  },
                  child: itemContainer(
                    Icons.pie_chart_outline,
                    'My Performance',
                  )),
              InkWell(
                  onTap: () {
                    AppNavigator.pushAndStackPage(context,
                        page: ResultPage(
                          studentProfile: widget.studentProfile,
                          classModel: widget.classModel,
                          schoolModel: widget.schoolModel,
                        ));
                  },
                  child: itemContainer(
                    Icons.archive_outlined,
                    'Archive',
                  )),
              InkWell(
                onTap: () {
                  AppNavigator.pushAndStackPage(context,
                      page: LibraryPage(
                        studentProfile: widget.studentProfile,
                        classModel: widget.classModel,
                      ));
                },
                child: itemContainer(
                  Icons.menu_book_sharp,
                  'Library',
                ),
              ),
              // itemContainer(
              //   Icons.videogame_asset_rounded,
              //   'Games',
              // ),
              const SizedBox(
                height: 20,
              ),
              itemContainer(
                Icons.help,
                'Help',
              ),
              // InkWell(
              //   onTap: () {
              //     AppNavigator.pushAndRemovePreviousPages(context,
              //         page: const AppSetUp());
              //   },
              //   child: itemContainer(
              //     Icons.refresh,
              //     'Reset Setup',
              //   ),
              // ),
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
                height: 10,
              ),
              InkWell(
                  onTap: () {
                    AppNavigator.pushAndRemovePreviousPages(context,
                        page: const SignPage());
                  },
                  child: logOutContainer()),
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
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        height: 50,
        padding: const EdgeInsets.all(5),

        // decoration: BoxDecoration(
        //   boxShadow: [
        //     BoxShadow(
        //       color: Colors.black.withOpacity(0.15),
        //       spreadRadius: 0,
        //       blurRadius: 10,
        //       offset: const Offset(0, 4),
        //     ),
        //   ],
        //   color: AppColors.white,
        //   borderRadius: BorderRadius.circular(10),
        // ),
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
