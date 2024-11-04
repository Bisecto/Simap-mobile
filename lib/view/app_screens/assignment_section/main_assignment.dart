import 'package:flutter/material.dart';
import 'package:simap/res/app_colors.dart';
import 'package:simap/utills/app_utils.dart';
import 'package:simap/view/app_screens/assignment_section/question_card.dart';
import 'package:simap/view/widgets/form_button.dart';

import '../../../model/student_profile.dart';
import '../../widgets/appBar_widget.dart';
import '../home_section/home_page_components/welcome_container.dart';

class MainAssignmentPage extends StatefulWidget {
  StudentProfile studentProfile;
  MainAssignmentPage({required this.studentProfile});

  @override
  State<MainAssignmentPage> createState() => _MainAssignmentPageState();
}

class _MainAssignmentPageState extends State<MainAssignmentPage> {
  final List<Map<String, dynamic>> quizData = [
    {
      "question": "What is the value of 2^3 + 5?",
      "options": {"A": "13", "B": "11", "C": "16", "D": "15"},
      "correct_answer": "A"
    },
    {
      "question": "Solve for x in the equation: 5x - 3 = 2x + 9.",
      "options": {"A": "x = 2", "B": "x = 4", "C": "x = 3", "D": "x = 5"},
      "correct_answer": "B"
    },
    {
      "question":
          "What is the area of a triangle with a base of 10 cm and a height of 6 cm?",
      "options": {"A": "30 cm²", "B": "60 cm²", "C": "40 cm²", "D": "20 cm²"},
      "correct_answer": "A"
    },
    {
      "question": "If 3x + 2 = 11, what is the value of x?",
      "options": {"A": "3", "B": "2", "C": "5", "D": "4"},
      "correct_answer": "A"
    },
    {
      "question": "What is the square root of 144?",
      "options": {"A": "12", "B": "14", "C": "16", "D": "10"},
      "correct_answer": "A"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCFCFC),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MainAppBar(
                isBackKey: true, studentProfile: widget.studentProfile,
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WelcomeContainer(
                      welcomeMsg: 'Hello Champ 👋',
                      mainText: 'Study Hard\nOkafor Precious',
                      subText: '',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: quizData.length * 365,
                      child: ListView.builder(
                        itemCount: quizData.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return QuestionCard(
                            question: quizData[index]['question'],
                            options: quizData[index]['options'],
                            correctAnswer: quizData[index]['correct_answer'],
                          );
                        },
                      ),
                    ),
                    FormButton(
                      onPressed: () {},
                      text: "Submit",
                      bgColor: AppColors.mainAppColor,
                      borderRadius: 15,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Quiz App'),
    //   ),
    //   body: ListView.builder(
    //     itemCount: quizData.length,
    //     itemBuilder: (context, index) {
    //       return QuestionCard(
    //         question: quizData[index]['question'],
    //         options: quizData[index]['options'],
    //         correctAnswer: quizData[index]['correct_answer'],
    //       );
    //     },
    //   ),
    // );
  }
}
