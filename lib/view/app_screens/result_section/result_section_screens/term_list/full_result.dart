import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simap/view/widgets/app_custom_text.dart';
import '../../../../../model/result_model/result_data/term_subject_result.dart';
import '../../../../../res/app_colors.dart';

class FullResultPage extends StatefulWidget {
  List<TermSubjectResult> fullResults;
  FullResultPage({required this.fullResults});
  @override
  _FullResultPageState createState() => _FullResultPageState();
}

class _FullResultPageState extends State<FullResultPage> {

  @override
  void initState() {
    super.initState();
    // Lock orientation to landscape
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  @override
  void dispose() {
    // Reset orientation to default when leaving the page
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(text: 'Full Result', color: AppColors.black),
        iconTheme: const IconThemeData(color: AppColors.black),
        backgroundColor: AppColors.white,
      ),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(1.5), // Subject
              1: FlexColumnWidth(1),   // 1st CA
              2: FlexColumnWidth(1),   // 2nd CA
              3: FlexColumnWidth(1),   // Assignment
              4: FlexColumnWidth(1),   // Project
              5: FlexColumnWidth(1),   // Exam
              6: FlexColumnWidth(1),   // Total Score
              7: FlexColumnWidth(1),   // Grade
              8: FlexColumnWidth(1),   // Position
              9: FlexColumnWidth(1.5), // Remark
            },
            border: TableBorder.all(color: Colors.grey),
            children: [
              _buildTableRow(
                ['Subject', '1st CA', '2nd CA', 'Assignment', 'Project', 'Exam', 'Total Score', 'Grade', 'Position', 'Remark'],
                isHeader: true,
              ),
              for (var result in widget.fullResults)
                _buildTableRow(
                  [
                    result.subject,
                    result.scores.the1StCat,
                    result.scores.the2NdCat,
                    result.scores.assignment,
                    result.scores.project,
                    result.scores.exam,
                    result.totalScore,
                    result.grade,
                    result.position,
                    result.remark
                  ],
                  isHeader: false,
                ),
            ],
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(List<String> rowData, {required bool isHeader}) {
    return TableRow(
      decoration: BoxDecoration(
        color: isHeader ? AppColors.mainAppColor : null,
        borderRadius: BorderRadius.circular(20),
      ),
      children: [
        for (var cellData in rowData)
          TableCell(
            child: Material(
              elevation: isHeader ? 10.0 : 0.0,
              child: Container(
                height: 40,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: isHeader
                      ? AppColors.mainAppColor
                      : (rowData.indexOf(cellData) == 7 ? Colors.grey[200] : Colors.white),
                  borderRadius: isHeader ? BorderRadius.circular(0) : BorderRadius.circular(10),
                ),
                child: CustomText(
                  text: cellData,
                  maxLines: 2,
                  color: isHeader ? Colors.white : rowData.indexOf(cellData) == 7 ? _getGradeColor(cellData) : AppColors.black,
                  weight: isHeader ? FontWeight.bold : FontWeight.normal,
                  size: 14,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Color _getGradeColor(String grade) {
    switch (grade) {
      case 'A':
        return Colors.green;
      case 'B':
        return Colors.blue;
      case 'C':
        return Colors.orange;
      case 'D':
        return Colors.black;
      default:
        return Colors.red;
    }
  }
}

