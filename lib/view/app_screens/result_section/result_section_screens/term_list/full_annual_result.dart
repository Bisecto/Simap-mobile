import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../model/result_model/result_data/annual_subject_result.dart';
import '../../../../../model/result_model/result_data/result_data_annual.dart';
import '../../../../../model/result_model/result_data/subject_annual_result.dart';
import '../../../../../model/result_model/result_data/subject_result_term.dart';



// Main Page Widget
class AnnualFullResultPage extends StatefulWidget {
  final ResultDataAnnual resultDataAnnual;

  AnnualFullResultPage({required this.resultDataAnnual});

  @override
  _AnnualFullResultPageState createState() => _AnnualFullResultPageState();
}

class _AnnualFullResultPageState extends State<AnnualFullResultPage> {
  @override
  void initState() {
    super.initState();
    print(widget.resultDataAnnual.annualPosition);
    print("widget.resultDataAnnual.annualPosition");
    print("widget.resultDataAnnual.annualPosition");
    print("widget.resultDataAnnual.annualPosition");
    print("widget.resultDataAnnual.annualPosition");
    print(widget.resultDataAnnual.annualPosition);
    print(widget.resultDataAnnual.annualPosition);
    print(widget.resultDataAnnual.annualPosition);
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Full Annual Result'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            _buildTableHeader(),
            for (var subjectResult in widget.resultDataAnnual.subjectResults)
              _buildSubjectResultRow(subjectResult),
            _buildAnnualSummaryRow(widget.resultDataAnnual),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      color: Colors.blueAccent,
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
          3: FlexColumnWidth(1),
          4: FlexColumnWidth(1),
          5: FlexColumnWidth(1),
          6: FlexColumnWidth(1),
          7: FlexColumnWidth(1),
          8: FlexColumnWidth(2),
        },
        border: TableBorder.all(color: Colors.grey),
        children: [
          TableRow(
            children: [
              for (var header in [
                'Subject', 'Term 1', 'Term 2', 'Term 3',
                'Total Score', 'Average Score', 'Grade', 'Position', 'Remark'
              ])
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      header,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectResultRow(AnnualSubjectResult subjectResult) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),
        4: FlexColumnWidth(1),
        5: FlexColumnWidth(1),
        6: FlexColumnWidth(1),
        7: FlexColumnWidth(1),
        8: FlexColumnWidth(2),
      },
      border: TableBorder.all(color: Colors.grey),
      children: [
        TableRow(
          children: [
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(subjectResult.subject, textAlign: TextAlign.center),
              ),
            ),
            for (var term in subjectResult.terms)
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(term.totalScore, textAlign: TextAlign.center),
                ),
              ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(subjectResult.annual.totalScore, textAlign: TextAlign.center),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(subjectResult.annual.averageScore, textAlign: TextAlign.center),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  subjectResult.annual.grade,
                  style: TextStyle(color: _getGradeColor(subjectResult.annual.grade)),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(subjectResult.annual.position, textAlign: TextAlign.center),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(subjectResult.annual.remark, textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAnnualSummaryRow(ResultDataAnnual resultDataAnnual) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(6),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
          3: FlexColumnWidth(1),
        },
        border: TableBorder.all(color: Colors.grey),
        children: [
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Annual Summary', textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              TableCell(
                child: Text(resultDataAnnual.annualTotal, textAlign: TextAlign.center),
              ),
              TableCell(
                child: Text(resultDataAnnual.annualAverage, textAlign: TextAlign.center),
              ),
              TableCell(
                child: Text(resultDataAnnual.annualPosition, textAlign: TextAlign.center),
              ),
            ],
          ),
        ],
      ),
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
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

// Mock data for testing
void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnnualFullResultPage(
        resultDataAnnual: ResultDataAnnual(
          subjectResults: [
            AnnualSubjectResult(
              subject: 'Mathematics',
              terms: [
                SubjectResultTerm(term: 'Term 1', totalScore: '80'),
                SubjectResultTerm(term: 'Term 2', totalScore: '85'),
                SubjectResultTerm(term: 'Term 3', totalScore: '90'),
              ],
              annual: SubjectResultAnnual(
                totalScore: '255',
                averageScore: '85',
                grade: 'A',
                remark: 'Excellent',
                position: '1',
              ),
            ),
          ],
          annualTotal: '255',
          annualAverage: '85',
          annualPosition: '1',
        ),
      ),
    ),
  );
}
