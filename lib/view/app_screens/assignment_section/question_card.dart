import 'package:flutter/material.dart';
import 'package:simap/view/widgets/app_custom_text.dart';

import '../../../res/app_colors.dart';

class QuestionCard extends StatefulWidget {
  final String question;
  final Map<String, String> options;
  final String correctAnswer;

  QuestionCard(
      {required this.question,
      required this.options,
      required this.correctAnswer});

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: "Question",
            color: Colors.green,
            weight: FontWeight.w400,
            size: 18,
          ),
          // Text(
          //   'Question',
          //   style: TextStyle(
          //     color: Colors.green,
          //     fontSize: 20.0,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          SizedBox(height: 5.0),
           CustomText(
            text: widget.question,
            color: AppColors.textColor,
            weight: FontWeight.w400,
            size: 16,
          ),
          SizedBox(height: 5.0),
          ...widget.options.keys.map((option) {
            return ListTile(
              leading: Radio<String>(
                value: option,
                groupValue: selectedOption,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value;
                  });
                },
                activeColor: Colors.green,
              ),
              title: CustomText(
               text:  '$option. ${widget.options[option]}',
                size: 16,
              ),
            );
          }).toList(),
          SizedBox(height: 5.0),
          Text(
            'Answer: ${selectedOption == widget.correctAnswer ? "Correct" : selectedOption != null ? "Incorrect" : ""}',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
