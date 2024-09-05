import 'package:dartz/dartz.dart';
import 'package:transittrack/core/error/failure.dart';
import 'package:transittrack/features/authentication/domain/entities/userCredential.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, UserCredential>> signup({
    required String fullName,
    required String phoneNumber,
    required String? email,
    required String password,
  });

  Future<Either<Failure, UserCredential>> login({
    required String phoneNumber,
    required String password,
  });

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, UserCredential>> getUserCredential(String token);

  Future<Either<Failure, void>> changePassword({
    required String newPassword,
    required String confirmPassword,
  });
}
