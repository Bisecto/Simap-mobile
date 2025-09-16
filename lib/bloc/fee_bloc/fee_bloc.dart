import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_repository/fee_repository.dart';
import '../../model/fee/fee_item.dart';
import '../../res/shared_preferenceKey.dart';
import '../../utills/shared_preferences.dart';
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
      String accessToken =
      await SharedPref.getString(SharedPreferenceKey().accessTokenKey);

      final feesResponse = await _repository.getFees(accessToken);

      // Handle case where API call succeeds but success is false
      if (!feesResponse.success) {
        emit(FeeError('Failed to load fees data'));
        return;
      }

      // Handle empty fees list
      if (feesResponse.fees.isEmpty) {
        emit(FeeLoaded(
          fees: [],
          paymentHistory: [], // You might need to get this from another endpoint
          totalPaid: feesResponse.financialSummary.totalPaid,
          totalDue: feesResponse.financialSummary.totalDue,
          financialSummary: feesResponse.financialSummary,
          student: feesResponse.student,
          activeTerm: feesResponse.activeTerm,
          activeSession: feesResponse.activeSession,
        ));
        return;
      }

      final paymentHistory = await _repository.getPaymentHistory(token: accessToken);

      final totalPaid = feesResponse.financialSummary.totalPaid;
      final totalDue = feesResponse.financialSummary.totalOutstanding;

      emit(FeeLoaded(
        fees: feesResponse.fees,
        paymentHistory: paymentHistory.paymentHistory,
        totalPaid: totalPaid,
        totalDue: totalDue,
        financialSummary: feesResponse.financialSummary,
        student: feesResponse.student,
        activeTerm: feesResponse.activeTerm,
        activeSession: feesResponse.activeSession,
      ));
    } catch (error) {
      print('Error in _onLoadFees: $error');
      emit(FeeError(error.toString()));
    }
  }

  Future<void> _onLoadPaymentHistory(LoadPaymentHistory event, Emitter<FeeState> emit) async {
    try {
      String accessToken =
      await SharedPref.getString(SharedPreferenceKey().accessTokenKey);
      final paymentHistory = await _repository.getPaymentHistory(token:accessToken );
      if (state is FeeLoaded) {
        final currentState = state as FeeLoaded;
        emit(FeeLoaded(
          fees: currentState.fees,
          paymentHistory: paymentHistory.paymentHistory,
          totalPaid: currentState.totalPaid,
          totalDue: currentState.totalDue, financialSummary: currentState.financialSummary, student: currentState.student, activeTerm: currentState.activeTerm, activeSession: currentState.activeSession,
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
      final transaction =null;
      emit(PaymentVerified(transaction));
    } catch (error) {
      emit(FeeError(error.toString()));
    }
  }
}