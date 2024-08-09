part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {}

class SignUpEvent extends AuthenticationEvent {
  final String fullName;
  final String? email;
  final String phoneNumber;
  final String password;

  SignUpEvent({
    this.email,
    required this.fullName,
    required this.password,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}

class LogInEvent extends AuthenticationEvent {
  final String phoneNumber;
  final String password;

  LogInEvent({
    required this.phoneNumber,
    required this.password,
  });

  @override
  List<Object> get props => [phoneNumber, password];
}

class SendOtpVerificationEvent extends AuthenticationEvent {
  final String phoneNumber;

  SendOtpVerificationEvent(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class ResendOtpVerificationEvent extends AuthenticationEvent {
  final String phoneNumber;

  ResendOtpVerificationEvent(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class SignOutEvent extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}
