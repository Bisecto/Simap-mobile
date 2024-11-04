import 'package:flutter/material.dart';
import 'package:simap/utills/app_navigator.dart';
import 'package:simap/view/app_screens/learn_section/learn_components/tutorial_detail_page.dart';

import '../../../../model/student_profile.dart';
import '../../../../res/app_colors.dart';

class TutorialCard extends StatelessWidget {
  final String title;
  final String duration;
  final String image;


  StudentProfile studentProfile;

  TutorialCard(
      {required this.title, required this.duration, required this.image,required this.studentProfile});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.pushAndStackPage(context, page: TutorialDetailPage(studentProfile: studentProfile,));
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  image,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.timer, color: Colors.blueAccent, size: 20),
                        SizedBox(width: 8),
                        Text(
                          duration,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
