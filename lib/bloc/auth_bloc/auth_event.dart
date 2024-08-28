part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class InitialEvent extends AuthEvent {}

class SignInEventClick extends AuthEvent {
  final String userData;
  final String password;

  SignInEventClick(this.userData, this.password);
}

class RequestResetPasswordEventClick extends AuthEvent {
  final String userData;

  RequestResetPasswordEventClick(
    this.userData,
  );
}

class OnVerifyOtpEvent extends AuthEvent {
  final String otp;
  final String userData;

  OnVerifyOtpEvent(this.otp, this.userData);
}

class ResetPasswordEventClick extends AuthEvent {
  final String userData;
  final String password;

  ResetPasswordEventClick(this.userData, this.password);
}
