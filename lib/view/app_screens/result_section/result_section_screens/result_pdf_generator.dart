import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart';

import '../../../../model/result_model/result_data/result_data_annual.dart';
import '../../../../model/result_model/result_data/subject_result_term.dart';
import '../../../../model/school_model.dart';
import '../../../../model/student_profile.dart';

class StudentResultPdfGenerator {
  static Future<void> generatePdf({
    required StudentProfile studentProfile,
    required SchoolModel school,
    required String academicSession,
    required String className,
    required String termName,
    ResultDataAnnual? annualData,
    dynamic termData,
  }) async {
    final pdf = pw.Document();
    final isAnnual = termName.toLowerCase() == 'annual';

    // Load school logo
    pw.ImageProvider? logoProvider;
    try {
      if (school.logo.isNotEmpty) {
        final logoBytes = await rootBundle.load(school.logo);
        logoProvider = pw.MemoryImage(logoBytes.buffer.asUint8List());
      }
    } catch (e) {
      print('Error loading logo: $e');
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(20),
        build: (pw.Context context) => [
          _buildHeader(school, logoProvider, termName),
          pw.SizedBox(height: 20),
          _buildStudentInfo(studentProfile, academicSession, className),
          pw.SizedBox(height: 20),
          if (isAnnual) ...[
            _buildAnnualResultsTable(annualData!),
            pw.SizedBox(height: 20),
            _buildAnnualSummary(annualData),
          ] else ...[
            _buildTermResultsTable(termData),
            pw.SizedBox(height: 20),
            _buildTermSummary(termData),
            pw.SizedBox(height: 20),
            _buildBehaviorSection(termData),
            pw.SizedBox(height: 20),
            _buildPsychomotorSection(termData),
            pw.SizedBox(height: 20),
            _buildCommentsSection(termData),
          ],
          pw.SizedBox(height: 30),
          _buildFooter(),
        ],
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: '${studentProfile.studentFullname}_${termName}_Result_${academicSession.replaceAll('/', '-')}.pdf',
    );
  }

  static pw.Widget _buildHeader(SchoolModel school, pw.ImageProvider? logoProvider, String termName) {
    final title = termName.toLowerCase() == 'annual' ? 'ANNUAL RESULT SHEET' : '${termName.toUpperCase()} RESULT SHEET';

    return pw.Container(
      padding: const pw.EdgeInsets.all(15),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.blue800, width: 2),
        borderRadius: pw.BorderRadius.circular(10),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          _buildLogo(logoProvider),
          pw.Expanded(
            child: pw.Column(
              children: [
                pw.Text(
                  school.name.toUpperCase(),
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.blue800,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
                pw.SizedBox(height: 5),
                pw.Text(
                  title,
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.red800,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
              ],
            ),
          ),
          pw.Container(width: 80),
        ],
      ),
    );
  }

  static pw.Widget _buildLogo(pw.ImageProvider? logoProvider) {
    return logoProvider != null
        ? pw.Container(width: 80, height: 80, child: pw.Image(logoProvider))
        : pw.Container(
      width: 80,
      height: 80,
      decoration: pw.BoxDecoration(
        color: PdfColors.blue50,
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Center(
        child: pw.Text(
          'LOGO',
          style: pw.TextStyle(
            color: PdfColors.blue800,
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ),
    );
  }

  static pw.Widget _buildStudentInfo(StudentProfile student, String academicSession, String className) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(15),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey100,
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Row(
        children: [
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _buildInfoRow('STUDENT NAME:', student.studentFullname),
                _buildInfoRow('CLASS:', className),
                _buildInfoRow('SESSION:', academicSession),
                _buildInfoRow('GENDER:', student.gender),
              ],
            ),
          ),
          pw.SizedBox(width: 20),
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _buildInfoRow('STUDENT ID:', student.id.toString()),
                _buildInfoRow('DATE OF BIRTH:', _formatDate(student.dateOfBirth)),
                _buildInfoRow('BLOOD GROUP:', student.bloodGroup),
                _buildInfoRow('GENOTYPE:', student.genotype),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildInfoRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 3),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 120,
            child: pw.Text(
              label,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
            ),
          ),
          pw.Expanded(
            child: pw.Text(value, style: const pw.TextStyle(fontSize: 10)),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildAnnualResultsTable(ResultDataAnnual resultData) {
    final headers = ['SUBJECT', 'FIRST TERM', 'SECOND TERM', 'THIRD TERM', 'TOTAL', 'AVERAGE', 'GRADE', 'POSITION', 'REMARK'];

    return _buildTable(
      headers: headers,
      rows: resultData.subjectResults.map((subject) => [
        subject.subject,
        _getTermScore(subject.terms, 'First Term'),
        _getTermScore(subject.terms, 'Second Term'),
        _getTermScore(subject.terms, 'Third Term'),
        subject.annual.totalScore,
        subject.annual.averageScore,
        subject.annual.grade,
        subject.annual.position,
        subject.annual.remark,
      ]).toList(),
    );
  }

  static pw.Widget _buildTermResultsTable(dynamic termData) {
    final headers = ['SUBJECT', 'TOTAL', 'GRADE', 'POSITION', 'REMARK'];

    return _buildTable(
      headers: headers,
      rows: termData.subjectResults.map<List<String>>((subject) => [
        subject.subject?.toString() ?? '',
       // subject.ca?.toString() ?? 'N/A',
       // subject.exam?.toString() ?? 'N/A',
        subject.totalScore?.toString() ?? 'N/A',
        subject.grade?.toString() ?? 'N/A',
        subject.position?.toString() ?? 'N/A',
        subject.remark?.toString() ?? 'N/A',
      ]).toList(),
    );
  }

  static pw.Widget _buildTable({required List<String> headers, required List<List<String>> rows}) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey400),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Table(
        border: pw.TableBorder.all(color: PdfColors.grey300),
        children: [
          // Header row
          pw.TableRow(
            decoration: const pw.BoxDecoration(color: PdfColors.blue800),
            children: headers.map((header) => _buildTableHeader(header)).toList(),
          ),
          // Data rows
          ...rows.asMap().entries.map((entry) => pw.TableRow(
            decoration: pw.BoxDecoration(
              color: entry.key % 2 == 0 ? PdfColors.grey50 : PdfColors.white,
            ),
            children: entry.value.asMap().entries.map((cellEntry) =>
                _buildTableCell(cellEntry.value, isSubject: cellEntry.key == 0)
            ).toList(),
          )),
        ],
      ),
    );
  }

  static pw.Widget _buildTableHeader(String text) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          color: PdfColors.white,
          fontWeight: pw.FontWeight.bold,
          fontSize: 9,
        ),
        textAlign: pw.TextAlign.center,
      ),
    );
  }

  static pw.Widget _buildTableCell(String text, {bool isSubject = false}) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(6),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 8,
          fontWeight: isSubject ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
        textAlign: isSubject ? pw.TextAlign.left : pw.TextAlign.center,
      ),
    );
  }

  static pw.Widget _buildAnnualSummary(ResultDataAnnual resultData) {
    return _buildSummaryContainer([
      _buildSummaryItem('TOTAL SCORE', resultData.annualTotal),
      _buildSummaryItem('AVERAGE SCORE', resultData.annualAverage),
      _buildSummaryItem('POSITION', resultData.annualPosition),
    ]);
  }

  static pw.Widget _buildTermSummary(dynamic termData) {
    return _buildSummaryContainer([
      _buildSummaryItem('TOTAL SCORE', termData.totalScore?.toString() ?? 'N/A'),
      _buildSummaryItem('AVERAGE SCORE', termData.averageScore?.toString() ?? 'N/A'),
      _buildSummaryItem('POSITION', termData.position?.toString() ?? 'N/A'),
    ]);
  }

  static pw.Widget _buildSummaryContainer(List<pw.Widget> items) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(15),
      decoration: pw.BoxDecoration(
        color: PdfColors.blue50,
        border: pw.Border.all(color: PdfColors.blue200),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
        children: items,
      ),
    );
  }

  static pw.Widget _buildSummaryItem(String label, String value) {
    return pw.Column(
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            fontSize: 10,
            color: PdfColors.blue800,
          ),
        ),
        pw.SizedBox(height: 5),
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: pw.BoxDecoration(
            color: PdfColors.white,
            borderRadius: pw.BorderRadius.circular(4),
            border: pw.Border.all(color: PdfColors.blue300),
          ),
          child: pw.Text(
            value,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 12,
              color: PdfColors.blue800,
            ),
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildBehaviorSection(dynamic termData) {
    return _buildSection(
      'STUDENT BEHAVIOR',
      [
        _buildDetailRow('Punctuality', termData.behaviour?.data?.punctuality),
        _buildDetailRow('Class Attendance', termData.behaviour?.data?.classAttendance),
        _buildDetailRow('Honesty', termData.behaviour?.data?.honesty),
        _buildDetailRow('Relationship With Peers', termData.behaviour?.data?.relationshipWithPeers),
      ],
    );
  }

  static pw.Widget _buildPsychomotorSection(dynamic termData) {
    return _buildSection(
      'STUDENT PSYCHOMOTOR',
      [
        _buildDetailRow('Reading', termData.psychomotor?.data?.reading),
        _buildDetailRow('Creative Arts', termData.psychomotor?.data?.creativeArts),
        _buildDetailRow('Public Speaking', termData.psychomotor?.data?.publicSpeaking),
        _buildDetailRow('Sports', termData.psychomotor?.data?.sports),
      ],
    );
  }

  static pw.Widget _buildCommentsSection(dynamic termData) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(15),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey50,
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'COMMENTS',
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.blue800,
            ),
          ),
          pw.SizedBox(height: 10),
          _buildCommentBlock('Class Teacher', termData.comments?.classTeacher),
          pw.SizedBox(height: 10),
          _buildCommentBlock('Principal', termData.comments?.principal),
        ],
      ),
    );
  }

  static pw.Widget _buildSection(String title, List<pw.Widget> children) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(15),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey50,
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.blue800,
            ),
          ),
          pw.SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }

  static pw.Widget _buildDetailRow(String label, dynamic value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        children: [
          pw.SizedBox(
            width: 150,
            child: pw.Text(
              '$label:',
              style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              value?.toString() ?? 'N/A',
              style: const pw.TextStyle(fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildCommentBlock(String title, dynamic comment) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          '$title:',
          style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
        ),
        pw.Text(
          comment?.toString() ?? 'No comment provided.',
          style: const pw.TextStyle(fontSize: 11),
        ),
      ],
    );
  }

  static pw.Widget _buildFooter() {
    return pw.Column(
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            _buildSignatureBlock('Class Teacher\'s Signature', 'Date'),
            _buildSignatureBlock('Principal\'s Signature', 'School Stamp'),
          ],
        ),
        pw.SizedBox(height: 20),
        pw.Container(
          padding: const pw.EdgeInsets.all(10),
          decoration: pw.BoxDecoration(
            color: PdfColors.grey100,
            borderRadius: pw.BorderRadius.circular(5),
          ),
          child: pw.Center(
            child: pw.Text(
              'This is a computer-generated result sheet.',
              style: pw.TextStyle(fontSize: 8, fontStyle: pw.FontStyle.italic),
            ),
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildSignatureBlock(String title, String subtitle) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('$title: ________________', style: const pw.TextStyle(fontSize: 10)),
        pw.SizedBox(height: 20),
        pw.Text(subtitle, style: const pw.TextStyle(fontSize: 10)),
      ],
    );
  }

  static String _getTermScore(List<SubjectResultTerm> terms, String termName) {
    try {
      final term = terms.firstWhere((t) => t.term.toLowerCase().contains(termName.toLowerCase()));
      return term.totalScore;
    } catch (e) {
      return 'N/A';
    }
  }

  static String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

