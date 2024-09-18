import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:transittrack/core/error/failure.dart';
import 'package:transittrack/core/usecases/usecases.dart';
import 'package:transittrack/features/authentication/domain/entities/userCredential.dart';
import 'package:transittrack/features/authentication/domain/repository/authentication_repository.dart';

class SignupUsecase extends UseCase<UserCredential, SignupParams> {
  final AuthenticationRepository repository;

  SignupUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, UserCredential>> call(SignupParams params) async {
    return await repository.signup(
      fullName: params.fullName,
      phoneNumber: params.phoneNumber,
      email: params.email,
      password: params.password,
    );
  }
}

class SignupParams extends Equatable {
  final String fullName;
  final String phoneNumber;
  final String? email;
  final String password;

  const SignupParams({
    required this.fullName,
    this.email,
    required this.phoneNumber,
    required this.password,
  });

  @override
  List<Object?> get props => [phoneNumber, password];
}