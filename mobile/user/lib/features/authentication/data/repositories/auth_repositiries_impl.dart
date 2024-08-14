import 'package:dartz/dartz.dart';
import 'package:transittrack/core/error/failure.dart';
import 'package:transittrack/core/network/network.dart';
import 'package:transittrack/features/authentication/data/datasource/auth_remote_datasource.dart';
import 'package:transittrack/features/authentication/domain/entities/userCredential.dart';
import 'package:transittrack/features/authentication/domain/repository/authentication_repository.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  AuthenticationRepositoryImpl({
    required this.remoteDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, void>> changePassword(
      {required String newPassword, required String confirmPassword}) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.changePassword(
          newPassword: newPassword,
          confirmPassword: confirmPassword,
        );
        return Right(response);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, UserCredential>> getUserCredential() {
    // TODO: implement getUserCredential
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserCredential>> login(
      {required String phoneNumber, required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.login(
          phoneNumber: phoneNumber,
          password: password,
        );
        return Right(response);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async{
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.logout(
          
        );
        return Right(response);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signup(
      {required String fullName,
      required String phoneNumber,
      required String? email,
      required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.signup(
          fullName: fullName,
          phoneNumber: phoneNumber,
          email: email,
          password: password,

        );
        return Right(response);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
