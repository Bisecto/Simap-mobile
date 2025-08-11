import 'package:equatable/equatable.dart';

enum PaymentStatus { pending, successful, failed }

class FeeItem extends Equatable {
  final String id;
  final String type;
  final double amount;
  final String session;
  final String term;
  final PaymentStatus status;
  final String reference;
  final DateTime? dueDate;
  final DateTime? paidDate;

  const FeeItem({
    required this.id,
    required this.type,
    required this.amount,
    required this.session,
    required this.term,
    required this.status,
    required this.reference,
    this.dueDate,
    this.paidDate,
  });

  @override
  List<Object?> get props => [
    id,
    type,
    amount,
    session,
    term,
    status,
    reference,
    dueDate,
    paidDate,
  ];

  FeeItem copyWith({
    String? id,
    String? type,
    double? amount,
    String? session,
    String? term,
    PaymentStatus? status,
    String? reference,
    DateTime? dueDate,
    DateTime? paidDate,
  }) {
    return FeeItem(
      id: id ?? this.id,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      session: session ?? this.session,
      term: term ?? this.term,
      status: status ?? this.status,
      reference: reference ?? this.reference,
      dueDate: dueDate ?? this.dueDate,
      paidDate: paidDate ?? this.paidDate,
    );
  }

  factory FeeItem.fromJson(Map<String, dynamic> json) {
    return FeeItem(
      id: json['id'],
      type: json['type'],
      amount: json['amount'].toDouble(),
      session: json['session'],
      term: json['term'],
      status: PaymentStatus.values.firstWhere(
            (e) => e.toString().split('.').last == json['status'],
        orElse: () => PaymentStatus.pending,
      ),
      reference: json['reference'],
      dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
      paidDate: json['paidDate'] != null ? DateTime.parse(json['paidDate']) : null,
    );
  }
}
