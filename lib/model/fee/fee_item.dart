import 'package:equatable/equatable.dart';

enum PaymentStatus { pending, successful, failed }
class FeeItem {
  final String id;
  final String fee; // Changed from 'type' to 'fee' to match API
  final double amount;
  final double paid;
  final double outstanding;
  final String status;
  final DateTime? dateAssigned;
  final DateTime? dueDate;
  final bool isOverdue;
  final bool isMandatory;
  final String description;
  final String session;
  final String term;
  final String feeType;

  FeeItem({
    required this.id,
    required this.fee,
    required this.amount,
    required this.paid,
    required this.outstanding,
    required this.status,
    this.dateAssigned,
    this.dueDate,
    required this.isOverdue,
    required this.isMandatory,
    required this.description,
    required this.session,
    required this.term,
    required this.feeType,
  });

  factory FeeItem.fromJson(Map<String, dynamic> json) {
    return FeeItem(
      id: json['id']?.toString() ?? '',
      fee: json['Fee'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      paid: (json['paid'] ?? 0).toDouble(),
      outstanding: (json['outstanding'] ?? 0).toDouble(),
      status: json['status'] ?? 'pending',
      dateAssigned: json['date_assigned'] != null
          ? DateTime.tryParse(json['date_assigned'])
          : null,
      dueDate: json['due_date'] != null
          ? DateTime.tryParse(json['due_date'])
          : null,
      isOverdue: json['is_overdue'] ?? false,
      isMandatory: json['is_mandatory'] ?? true,
      description: json['description'] ?? '',
      session: json['session'] ?? '',
      term: json['term'] ?? '',
      feeType: json['fee_type'] ?? '',
    );
  }

  // Helper getter for backward compatibility
  String get type => fee;

  // Helper getter to convert status to PaymentStatus enum if you have one
  PaymentStatus get paymentStatus {
    switch (status.toLowerCase()) {
      case 'pending':
        return PaymentStatus.pending;
      case 'successful':
      case 'paid':
        return PaymentStatus.successful;
      case 'failed':
        return PaymentStatus.failed;
      default:
        return PaymentStatus.pending;
    }
  }
}
