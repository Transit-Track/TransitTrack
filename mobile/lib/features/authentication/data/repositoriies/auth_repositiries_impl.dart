import 'package:dartz/dartz.dart';
import 'package:transittrack/core/error/exceptions.dart';
import 'package:transittrack/core/error/failure.dart';
import 'package:transittrack/core/network/network.dart';
import 'package:transittrack/features/authentication/data/data_sources/auth_local_datasource.dart';
import 'package:transittrack/features/authentication/data/data_sources/auth_remote_datasource.dart';
import 'package:transittrack/features/authentication/data/model/user_credential_model.dart';
import 'package:transittrack/features/authentication/domain/entities/userCredential.dart';
import 'package:transittrack/features/authentication/domain/repository/authentication_repository.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;
  final AuthenticationLocalDataSource localDataSource;

  AuthenticationRepositoryImpl({
    required this.remoteDatasource,
    required this.networkInfo,
    required this.localDataSource,
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
  Future<Either<Failure, UserCredential>> getUserCredential(
      String token) async {
    try {
      final UserCredentialModel userCredential =
          await remoteDatasource.getUserCredential(token: token);
          userCredential.token = token;
      await localDataSource.storeUserCredential(userCredential);
      return Right(userCredential);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserCredential>> login(
      {required String phoneNumber, required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        final token = await remoteDatasource.login(
          phoneNumber: phoneNumber,
          password: password,
        );

        await localDataSource.saveToken(token);
        try {
          final user = await getUserCredential(token);
          return user;
        } on UnauthorizedException {
          return Left(UnauthorizedFailure());
        } catch (e) {
          return Left(ServerFailure());
        }
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    if (await networkInfo.isConnected) {
      try {
        await localDataSource.deleteToken();
        return const Right(null);
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
        return Left(AuthenticationFailure(errorMessage: e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
