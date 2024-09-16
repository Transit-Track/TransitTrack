import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  abstract final String errorMessage;
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  @override
  final String errorMessage;
  ServerFailure({this.errorMessage = 'Server failure'});
}

class CacheFailure extends Failure {
  @override
  final String errorMessage;
  CacheFailure({this.errorMessage = 'Cache failure'});
}

class NetworkFailure extends Failure {
  @override
  final String errorMessage;
  NetworkFailure({this.errorMessage = 'No internet connection'});
}

class UnauthorizedFailure extends Failure {
  @override
  final String errorMessage;

  UnauthorizedFailure({this.errorMessage = 'Incorrect phone number or password'});
}

class AuthenticationFailure extends Failure {
  @override
  final String errorMessage;

  AuthenticationFailure({this.errorMessage = 'Authentication failed'});
}


class AnonymousFailure extends Failure {
  @override
  final String errorMessage;
  AnonymousFailure({this.errorMessage = 'Unknown error happened'});
}
