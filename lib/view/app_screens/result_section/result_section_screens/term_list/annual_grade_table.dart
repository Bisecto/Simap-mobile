import 'package:flutter/material.dart';
import 'package:simap/view/widgets/app_custom_text.dart';
import '../../../../../model/result_model/result_data/annual_subject_result.dart';
import '../../../../../model/result_model/result_data/term_subject_result.dart';
import '../../../../../res/app_colors.dart';

// grades_table.dart

class AnnualGradesTable extends StatelessWidget {
  List<AnnualSubjectResult> subjectResults;

  AnnualGradesTable({required this.subjectResults});

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
        ),
        for (var result in subjectResults)
          _buildTableRow(
            [result.subject, result.annual.totalScore, result.annual.grade],
            isHeader: false,
          ),
      ],
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
                      : Colors.white,
                  borderRadius: BorderRadius.circular(isHeader ? 0 : 10),
                ),
                child: CustomText(
                  text: cellData,
                  maxLines: 2,
                  color: isHeader ? Colors.white : AppColors.black,
                  weight: isHeader ? FontWeight.bold : FontWeight.normal,
                  size: 14,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
