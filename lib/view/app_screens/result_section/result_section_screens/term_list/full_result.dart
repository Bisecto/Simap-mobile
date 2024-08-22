import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simap/view/widgets/app_custom_text.dart';
import '../../../../../res/app_colors.dart';

class FullResultPage extends StatefulWidget {
  @override
  _FullResultPageState createState() => _FullResultPageState();
}

class _FullResultPageState extends State<FullResultPage> {
  final List<List<String>> fullResults = [
    ['Mathematics', '15', '12', '10', '8', '50', '95', 'A', '1st', 'Excellent'],
    ['Mathematics', '15', '12', '10', '8', '50', '95', 'A', '1st', 'Excellent'],
    ['Mathematics', '15', '12', '10', '8', '50', '95', 'A', '1st', 'Excellent'],
    ['English', '13', '10', '12', '7', '48', '85', 'B', '3rd', 'Good'],
    ['Physics', '14', '14', '9', '9', '50', '92', 'A', '2nd', 'Very Good'],
    ['Chemistry', '12', '9', '10', '6', '45', '75', 'C', '5th', 'Fair'],
    ['Biology', '15', '13', '11', '8', '47', '88', 'B', '4th', 'Good'],
    ['History', '14', '12', '12', '10', '50', '90', 'A', '1st', 'Excellent'],
    ['Geography', '13', '11', '9', '7', '46', '82', 'B', '3rd', 'Good'],
    ['Geography', '13', '11', '9', '7', '46', '82', 'B', '3rd', 'Good'],
    ['', '', '', '', '', '', '', '', '', ''],
  ];
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

        title: const CustomText(text:'Full Result',color: AppColors.black,),
        iconTheme: const IconThemeData(color: AppColors.black,),
        backgroundColor: AppColors.white,
      ),
      body: SingleChildScrollView(
        //scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(1.5), // Subject
              1: FlexColumnWidth(1), // 1st CA
              2: FlexColumnWidth(1), // 2nd CA
              3: FlexColumnWidth(1), // Assignment
              4: FlexColumnWidth(1), // Project
              5: FlexColumnWidth(1), // Exam
              6: FlexColumnWidth(1), // Total Score
              7: FlexColumnWidth(1), // Grade
              8: FlexColumnWidth(1), // Position
              9: FlexColumnWidth(1.5), // Remark
              //10: FlexColumnWidth(), // Remark
            },
            border: TableBorder.all(color: Colors.grey),
            children: [
              _buildTableRow(
                [
                  'Subject',
                  '1st CA',
                  '2nd CA',
                  'Assignment',
                  'Project',
                  'Exam',
                  'Total Score',
                  'Grade',
                  'Position',
                  'Remark'
                ],
                isHeader: true,
              ),
              for (var result in fullResults)
                _buildTableRow(result, isHeader: false),
            ],
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(
    List<String> rowData, {
    required bool isHeader,
  }) {
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
                      : (rowData.indexOf(cellData) == 7
                          ? Colors.grey[200]
                          : Colors.white),
                  borderRadius: isHeader
                      ? BorderRadius.circular(0)
                      : BorderRadius.circular(10),
                ),
                child: CustomText(
                  text: cellData,
                  maxLines: 2,
                  color: isHeader
                      ? Colors.white
                      : rowData.indexOf(cellData) == 7
                          ? _getGradeColor(cellData)
                          : AppColors.black,
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
