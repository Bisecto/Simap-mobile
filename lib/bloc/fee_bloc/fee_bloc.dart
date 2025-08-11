import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_repository/fee_repository.dart';
import '../../model/fee/fee_item.dart';
import 'fee_event.dart';
import 'fee_state.dart';

class FeeBloc extends Bloc<FeeEvent, FeeState> {
  final FeeRepository _repository;

  FeeBloc({required FeeRepository repository})
      : _repository = repository,
        super(FeeInitial()) {
    on<LoadFees>(_onLoadFees);
    on<LoadPaymentHistory>(_onLoadPaymentHistory);
    on<InitiatePayment>(_onInitiatePayment);
    on<VerifyPayment>(_onVerifyPayment);
  }

  Future<void> _onLoadFees(LoadFees event, Emitter<FeeState> emit) async {
    emit(FeeLoading());
    try {
      final fees = await _repository.getFees();
      final paymentHistory = await _repository.getPaymentHistory();

      final totalPaid = paymentHistory
          .where((t) => t.status == PaymentStatus.successful)
          .fold(0.0, (sum, t) => sum + t.amount);

      final totalDue = fees
          .where((f) => f.status == PaymentStatus.pending)
          .fold(0.0, (sum, f) => sum + f.amount);

      emit(FeeLoaded(
        fees: fees,
        paymentHistory: paymentHistory,
        totalPaid: totalPaid,
        totalDue: totalDue,
      ));
    } catch (error) {
      emit(FeeError(error.toString()));
    }
  }

  Future<void> _onLoadPaymentHistory(LoadPaymentHistory event, Emitter<FeeState> emit) async {
    try {
      final paymentHistory = await _repository.getPaymentHistory();
      if (state is FeeLoaded) {
        final currentState = state as FeeLoaded;
        emit(FeeLoaded(
          fees: currentState.fees,
          paymentHistory: paymentHistory,
          totalPaid: currentState.totalPaid,
          totalDue: currentState.totalDue,
        ));
      }
    } catch (error) {
      emit(FeeError(error.toString()));
    }
  }

  Future<void> _onInitiatePayment(InitiatePayment event, Emitter<FeeState> emit) async {
    emit(FeeLoading());
    try {
      final paymentUrl = await _repository.initiatePayment(event.fee);
      emit(PaymentInitiated(paymentUrl: paymentUrl, fee: event.fee));
    } catch (error) {
      emit(FeeError(error.toString()));
    }
  }

  Future<void> _onVerifyPayment(VerifyPayment event, Emitter<FeeState> emit) async {
    emit(FeeLoading());
    try {
      final transaction = await _repository.verifyPayment(event.reference);
      emit(PaymentVerified(transaction));
    } catch (error) {
      emit(FeeError(error.toString()));
    }
  }
}