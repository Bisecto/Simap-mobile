import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:simap/model/student_profile.dart';
import '../../../../../res/app_colors.dart';
import '../../../../widgets/appBar_widget.dart';
import '../../../home_section/home_page_components/welcome_container.dart';
import 'line_chart.dart';

class PerformancePage extends StatefulWidget {
  StudentProfile studentProfile;
   PerformancePage({super.key, required this.studentProfile});

  @override
  State<PerformancePage> createState() => _PerformancePageState();
}

class _PerformancePageState extends State<PerformancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFC),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
             MainAppBar(
              isBackKey: true,studentProfile: widget.studentProfile
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const WelcomeContainer(
                    welcomeMsg: 'Hello Champ 👋',
                    mainText: 'Here are your performance\nSo far',
                    subText: '',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 300,
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
                      padding: const EdgeInsets.all(0),
                      child: CustomChart(
                        isShowingMainData: false,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
