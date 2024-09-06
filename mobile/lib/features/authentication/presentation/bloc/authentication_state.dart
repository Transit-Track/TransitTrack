part of 'authentication_bloc.dart';

abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

//! login

class LoginLoadingState extends AuthenticationState {}

class LoggedInState extends AuthenticationState {
  final UserCredential user;

  LoggedInState({required this.user});
}

class UnAuthenticatedState extends AuthenticationState {
  final String message;

  UnAuthenticatedState({required this.message});
}

//! sign up

class SignupLoadingState extends AuthenticationState {}

class SignUpSuccessState extends AuthenticationState {
  final UserCredential user;

  SignUpSuccessState({required this.user});
}

class SignupErrorState extends AuthenticationState {
  final String message;

  SignupErrorState({required this.message});
}

//! change password
class ChangePasswordLoadingState extends AuthenticationState {}

class ChangePasswordSuccessState extends AuthenticationState {}

class ChangePasswordErrorState extends AuthenticationState {
  final String message;

  ChangePasswordErrorState({required this.message});
}
