import 'package:equatable/equatable.dart';

import '../../model/fee/fee_item.dart';
import '../../model/fee/payment_transaction.dart';

abstract class FeeState extends Equatable {
  const FeeState();

  @override
  List<Object> get props => [];
}

class FeeInitial extends FeeState {}

class FeeLoading extends FeeState {}

class FeeLoaded extends FeeState {
  final List<FeeItem> fees;
  final List<PaymentTransaction> paymentHistory;
  final double totalPaid;
  final double totalDue;

  const FeeLoaded({
    required this.fees,
    required this.paymentHistory,
    required this.totalPaid,
    required this.totalDue,
  });

  @override
  List<Object> get props => [fees, paymentHistory, totalPaid, totalDue];
}

class PaymentInitiated extends FeeState {
  final String paymentUrl;
  final FeeItem fee;

  const PaymentInitiated({
    required this.paymentUrl,
    required this.fee,
  });

  @override
  List<Object> get props => [paymentUrl, fee];
}

class PaymentVerified extends FeeState {
  final PaymentTransaction transaction;

  const PaymentVerified(this.transaction);

  @override
  List<Object> get props => [transaction];
}

class FeeError extends FeeState {
  final String message;

  const FeeError(this.message);

  @override
  List<Object> get props => [message];
}
