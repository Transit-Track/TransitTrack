part of 'authentication_bloc.dart';

abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationSuccessState extends AuthenticationState {
  final UserCredential user;

  AuthenticationSuccessState({required this.user});
}

class AuthenticationFailureState extends AuthenticationState {
  final String message;

  AuthenticationFailureState({required this.message});
}


