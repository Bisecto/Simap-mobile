import 'fee_item.dart';

class PaymentHistoryResponse {
  final bool success;
  final List<PaymentTransaction> paymentHistory;
  final PaginationInfo pagination;

  PaymentHistoryResponse({
    required this.success,
    required this.paymentHistory,
    required this.pagination,
  });

  factory PaymentHistoryResponse.fromJson(Map<String, dynamic> json) {
    return PaymentHistoryResponse(
      success: json['success'] ?? false,
      paymentHistory: (json['payment_history'] as List<dynamic>?)
          ?.map((payment) => PaymentTransaction.fromJson(payment))
          .toList() ??
          [],
      pagination: PaginationInfo.fromJson(json['pagination'] ?? {}),
    );
  }
}

class PaginationInfo {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final bool hasNext;
  final bool hasPrevious;

  PaginationInfo({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.hasNext,
    required this.hasPrevious,
  });

  factory PaginationInfo.fromJson(Map<String, dynamic> json) {
    return PaginationInfo(
      page: json['page'] ?? 1,
      perPage: json['per_page'] ?? 20,
      total: json['total'] ?? 0,
      totalPages: json['total_pages'] ?? 1,
      hasNext: json['has_next'] ?? false,
      hasPrevious: json['has_previous'] ?? false,
    );
  }
}

class PaymentFeeInfo {
  final String id;
  final String fee;

  PaymentFeeInfo({
    required this.id,
    required this.fee,
  });

  factory PaymentFeeInfo.fromJson(Map<String, dynamic> json) {
    return PaymentFeeInfo(
      id: json['id']?.toString() ?? '',
      fee: json['Fee'] ?? '',
    );
  }
}

// Updated PaymentTransaction model to match API response
class PaymentTransaction {
  final String id;
  final String transactionId;
  final double amount;
  final List<PaymentFeeInfo> fees;
  final String paymentMethod;
  final String status;
  final DateTime? datePaid;
  final String reference;
  final String receiptUrl;

  PaymentTransaction({
    required this.id,
    required this.transactionId,
    required this.amount,
    required this.fees,
    required this.paymentMethod,
    required this.status,
    this.datePaid,
    required this.reference,
    required this.receiptUrl,
  });

  factory PaymentTransaction.fromJson(Map<String, dynamic> json) {
    return PaymentTransaction(
      id: json['id']?.toString() ?? '',
      transactionId: json['transaction_id'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      fees: (json['fees'] as List<dynamic>?)
          ?.map((fee) => PaymentFeeInfo.fromJson(fee))
          .toList() ??
          [],
      paymentMethod: json['payment_method'] ?? '',
      status: json['status'] ?? '',
      datePaid: json['date_paid'] != null
          ? DateTime.tryParse(json['date_paid'])
          : null,
      reference: json['reference'] ?? '',
      receiptUrl: json['receipt_url'] ?? '',
    );
  }

  // Helper getters for backward compatibility
  String get paymentId => transactionId;
  DateTime get date => datePaid ?? DateTime.now();
  String get description => fees.isNotEmpty ? fees.first.fee : 'Payment';

  // Helper getter to convert status to PaymentStatus enum
  PaymentStatus get paymentStatus {
    switch (status.toLowerCase()) {
      case 'successful and completed':
      case 'successful':
      case 'completed':
        return PaymentStatus.successful;
      case 'pending':
        return PaymentStatus.pending;
      case 'failed':
        return PaymentStatus.failed;
      default:
        return PaymentStatus.pending;
    }
  }
}
