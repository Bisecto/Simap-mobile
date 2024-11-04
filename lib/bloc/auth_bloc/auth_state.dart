part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class OnClickedState extends AuthState {}

class LoadingState extends AuthState {}

class AccessTokenExpireState extends AuthState {}

class ErrorState extends AuthState {
  final String error;

  ErrorState(this.error);
}

class DeviceChange extends AuthState {
  final String msg;
  final String email;
  final String password;

  DeviceChange(this.msg, this.email, this.password);
}

class SuccessState extends AuthState {
  final String msg;
  final StudentProfile studentProfile;
  final SchoolModel schoolModel;
  final List<Subject> subjectList;
  final CurrentSessionModel sessionModel;
  final ClassModel classModel;

  SuccessState(this.msg, this.studentProfile, this.schoolModel,
      this.subjectList, this.sessionModel, this.classModel);
}

class ResetPasswordSuccessState extends AuthState {
  final String msg;

  ResetPasswordSuccessState(this.msg);
}

class OtpRequestSuccessState extends AuthState {
  final String msg;
  final String userData;

  OtpRequestSuccessState(this.msg, this.userData);
}

class OtpVerificationSuccessState extends AuthState {
  final String msg;

  OtpVerificationSuccessState(this.msg);
}
