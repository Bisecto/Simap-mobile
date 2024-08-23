import 'package:flutter/material.dart';

class QuizModal extends StatefulWidget {
  @override
  _QuizModalState createState() => _QuizModalState();
}

class _QuizModalState extends State<QuizModal> {
  final List<Map<String, dynamic>> quizData = [
    {
      "question": "What is the value of 2^3 + 5?",
      "options": ["13", "11", "16", "15"],
      "correct_answer": "13"
    },
    {
      "question": "Solve for x in the equation: 5x - 3 = 2x + 9.",
      "options": ["x = 2", "x = 4", "x = 3", "x = 5"],
      "correct_answer": "x = 4"
    },
    {
      "question":
      "What is the area of a triangle with a base of 10 cm and a height of 6 cm?",
      "options": ["30 cm²", "60 cm²", "40 cm²", "20 cm²"],
      "correct_answer": "30 cm²"
    },
    {
      "question": "If 3x + 2 = 11, what is the value of x?",
      "options": ["3", "2", "5", "4"],
      "correct_answer": "3"
    },
    {
      "question": "What is the square root of 144?",
      "options": ["12", "14", "16", "10"],
      "correct_answer": "12"
    },
    {
      "question": "What is the value of π (pi) to two decimal places?",
      "options": ["3.14", "3.15", "3.16", "3.13"],
      "correct_answer": "3.14"
    },
    {
      "question": "What is the derivative of x^2?",
      "options": ["2x", "x", "x^2", "2"],
      "correct_answer": "2x"
    },
    {
      "question": "What is the sum of angles in a triangle?",
      "options": ["180°", "360°", "90°", "120°"],
      "correct_answer": "180°"
    },
    {
      "question": "What is the next prime number after 7?",
      "options": ["9", "11", "10", "13"],
      "correct_answer": "11"
    },
    {
      "question": "What is 15% of 200?",
      "options": ["30", "25", "20", "35"],
      "correct_answer": "30"
    },
    {
      "question": "What is the value of 7 * 8?",
      "options": ["54", "56", "49", "64"],
      "correct_answer": "56"
    },
    {
      "question": "Simplify: 8/2(2+2)",
      "options": ["8", "16", "1", "24"],
      "correct_answer": "16"
    },
    {
      "question": "What is the least common multiple (LCM) of 4 and 6?",
      "options": ["12", "24", "18", "6"],
      "correct_answer": "12"
    },
    {
      "question": "What is the value of x if 2x = 10?",
      "options": ["2", "3", "4", "5"],
      "correct_answer": "5"
    },
    {
      "question": "What is the factorial of 5?",
      "options": ["120", "60", "20", "24"],
      "correct_answer": "120"
    },
  ];

  int currentQuestionIndex = 0;
  String? selectedOption;
  List<bool> answeredQuestions = [];

  @override
  void initState() {
    super.initState();
    // Initialize the answeredQuestions list to be the same length as quizData with all values set to false
    answeredQuestions = List<bool>.filled(quizData.length, false);
  }

  void nextQuestion() {
    if (currentQuestionIndex < quizData.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedOption = null;
      });
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
        selectedOption = null;
      });
    }
  }

  void selectOption(String value) {
    setState(() {
      selectedOption = value;
      // Mark the current question as answered
      answeredQuestions[currentQuestionIndex] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                const BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6.0,
                  spreadRadius: 1.0,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${currentQuestionIndex + 1}) ${quizData[currentQuestionIndex]["question"]}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),
                ...quizData[currentQuestionIndex]["options"]
                    .map<Widget>((option) {
                  return ListTile(
                    leading: Radio<String>(
                      value: option,
                      groupValue: selectedOption,
                      onChanged: (value) {
                        if (value != null) selectOption(value);
                      },
                      activeColor: Colors.green,
                    ),
                    title: Text(
                      option,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 4.0,
            runSpacing: 4.0,
            children: List.generate(quizData.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    currentQuestionIndex = index;
                    selectedOption = null;
                  });
                },
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: answeredQuestions[index]
                        ? Colors.green
                        : Colors.white,
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: answeredQuestions[index]
                          ? Colors.white
                          : Colors.green,
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: previousQuestion,
                icon: const Icon(Icons.arrow_back),
                label: const Text('Previous'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200], // Use backgroundColor instead of primary
                  foregroundColor: Colors.black,
                ),
              ),
              ElevatedButton.icon(
                onPressed: nextQuestion,
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Next'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Use backgroundColor instead of primary
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
