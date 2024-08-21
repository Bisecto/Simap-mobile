import 'package:flutter/material.dart';
import 'package:simap/res/app_images.dart';
import 'package:simap/utills/app_utils.dart';

import '../../../res/app_colors.dart';

class ListResultSession extends StatelessWidget {
  ListResultSession({super.key});

  final List<String> sessions = [
    '2024/2025',
    '2023/2024',
    '2022/2023',
    '2021/2022',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: sessions.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return SessionContainer(session: sessions[index], context: context);
      },
    );
  }

  Widget SessionContainer({required String session,required context}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 300,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.white,
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 190,
                width: AppUtils.deviceScreenSize(context).width,
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
                child: Image.asset(AppImages.testPassed,height: 150,width: 150,),
              ),
              Text(
                session,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
