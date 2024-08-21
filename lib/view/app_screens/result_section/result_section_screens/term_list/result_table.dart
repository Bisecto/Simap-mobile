import 'package:flutter/material.dart';
import 'package:simap/view/widgets/app_custom_text.dart';
import '../../../../../res/app_colors.dart';

class GradesTable extends StatelessWidget {
  final List<List<String>> subjectsGradesAndScores = [
    ['Mathematics', '95', 'A'],
    ['English', '85', 'B'],
    ['Physics', '92', 'A'],
    ['Chemistry', '75', 'C'],
    ['Biology', '88', 'B'],
    ['History', '90', 'A'],
    ['Geography', '10', 'F'],
  ];

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
      },
      border: TableBorder.all(color: Colors.grey),
      children: [
        _buildTableRow(
          ['Subject', 'Total Score', 'Grade'],
          isHeader: true,
          isPurple: false,
        ),
        for (var subjectGradeScore in subjectsGradesAndScores)
          _buildTableRow(
            subjectGradeScore,
            isHeader: false,
            isPurple: false,
          ),
      ],
    );
  }

  TableRow _buildTableRow(
      List<String> rowData, {
        required bool isHeader,
        required bool isPurple,
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
                      : (rowData.indexOf(cellData) == 2
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
                      : rowData.indexOf(cellData) == 2
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
