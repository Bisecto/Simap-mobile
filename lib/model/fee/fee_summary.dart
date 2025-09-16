import 'fee_item.dart';

class FeesResponse {
  final bool success;
  final List<FeeItem> fees;
  final FinancialSummary financialSummary;
  final StudentInfo student;
  final String activeTerm;
  final String activeSession;

  FeesResponse({
    required this.success,
    required this.fees,
    required this.financialSummary,
    required this.student,
    required this.activeTerm,
    required this.activeSession,
  });

  factory FeesResponse.fromJson(Map<String, dynamic> json) {
    return FeesResponse(
      success: json['success'] ?? false,
      fees: (json['fees'] as List<dynamic>?)
          ?.map((fee) => FeeItem.fromJson(fee))
          .toList() ??
          [],
      financialSummary: FinancialSummary.fromJson(json['financial_summary'] ?? {}),
      student: StudentInfo.fromJson(json['student'] ?? {}),
      activeTerm: json['active_term'] ?? '',
      activeSession: json['active_session'] ?? '',
    );
  }
}

class FinancialSummary {
  final double totalDue;
  final double totalPaid;
  final double totalOutstanding;
  final double paymentProgress;

  FinancialSummary({
    required this.totalDue,
    required this.totalPaid,
    required this.totalOutstanding,
    required this.paymentProgress,
  });

  factory FinancialSummary.fromJson(Map<String, dynamic> json) {
    return FinancialSummary(
      totalDue: (json['total_due'] ?? 0).toDouble(),
      totalPaid: (json['total_paid'] ?? 0).toDouble(),
      totalOutstanding: (json['total_outstanding'] ?? 0).toDouble(),
      paymentProgress: (json['payment_progress'] ?? 0).toDouble(),
    );
  }
}

class StudentInfo {
  final String name;
  final String username;
  final String studentClass;
  final String session;
  final String id;

  StudentInfo({
    required this.name,
    required this.username,
    required this.studentClass,
    required this.session,
    required this.id,
  });

  factory StudentInfo.fromJson(Map<String, dynamic> json) {
    return StudentInfo(
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      studentClass: json['class'] ?? '',
      session: json['session'] ?? '',
      id: json['id']?.toString() ?? '',
    );
  }
}