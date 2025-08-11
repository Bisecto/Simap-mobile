import 'package:equatable/equatable.dart';

import 'fee_item.dart';

class PaymentTransaction extends Equatable {
  final String id;
  final String reference;
  final double amount;
  final PaymentStatus status;
  final DateTime date;
  final String description;
  final String paymentId;

  const PaymentTransaction({
    required this.id,
    required this.reference,
    required this.amount,
    required this.status,
    required this.date,
    required this.description,
    required this.paymentId,
  });

  @override
  List<Object> get props => [id, reference, amount, status, date, description, paymentId];

  factory PaymentTransaction.fromJson(Map<String, dynamic> json) {
    return PaymentTransaction(
      id: json['id'],
      reference: json['reference'],
      amount: json['amount'].toDouble(),
      status: PaymentStatus.values.firstWhere(
            (e) => e.toString().split('.').last == json['status'],
      ),
      date: DateTime.parse(json['date']),
      description: json['description'],
      paymentId: json['paymentId'],
    );
  }
}
