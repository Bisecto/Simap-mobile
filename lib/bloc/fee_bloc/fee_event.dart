import 'package:equatable/equatable.dart';

import '../../model/fee/fee_item.dart';

abstract class FeeEvent extends Equatable {
  const FeeEvent();

  @override
  List<Object> get props => [];
}

class LoadFees extends FeeEvent {}

class LoadPaymentHistory extends FeeEvent {}

class InitiatePayment extends FeeEvent {
  final FeeItem fee;

  const InitiatePayment(this.fee);

  @override
  List<Object> get props => [fee];
}

class VerifyPayment extends FeeEvent {
  final String reference;

  const VerifyPayment(this.reference);

  @override
  List<Object> get props => [reference];
}
