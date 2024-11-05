part of 'result_bloc.dart';

@immutable
abstract class ResultState {}

final class ResultInitial extends ResultState {}
class LoadingState extends ResultState {}

class OnClickedState extends ResultState {}

class ErrorState extends ResultState {
  final String error;

  ErrorState(this.error);
}

class AccessTokenExpireState extends ResultState {}
class InitialSuccessState extends ResultState {
  final String msg;
  final ResultModel resultModel;

  InitialSuccessState(this.msg,this.resultModel);
}
