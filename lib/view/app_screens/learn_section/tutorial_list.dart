import 'package:flutter/material.dart';
import 'package:simap/view/app_screens/learn_section/tutorial_card.dart';

class TutorialListPage extends StatelessWidget {
  final List<Map<String, dynamic>> tutorials = [
    {
      "title": "Arithmetic and Quantitative Reasoning",
      "duration": "12 min",
      "image":
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbXppf_m05MPhqJoZbGx7H3nsANU9vzlW47A&s',
      // Replace with your image asset
    },
    {
      "title": "Arithmetic and Quantitative Reasoning",
      "duration": "12 min",
      "image":
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJYKQsIgZyZfouM-mZzCVBGqh_qyn_pulsSAOf8F4ZL231jyhN1oZ8RUTYXmE-OMDpS7Q&usqp=CAU',
      // Replace with your image asset
    },
    {
      "title": "Arithmetic and Quantitative Reasoning",
      "duration": "12 min",
      "image":
          'https://www.ziprecruiter.com/svc/fotomat/public-ziprecruiter/cms/586046490OnlineMathTutor.jpg=ws1280x960',
      // Replace with your image asset
    },
  ];

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: tutorials.length*150,
      child: ListView.builder(
        itemCount: tutorials.length,
        physics: const NeverScrollableScrollPhysics(
        ),
        itemBuilder: (context, index) {
          final tutorial = tutorials[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TutorialCard(
              title: tutorial["title"],
              duration: tutorial["duration"],
              image: tutorial["image"],
            ),
          );
        },
      ),
    );
  }
}

