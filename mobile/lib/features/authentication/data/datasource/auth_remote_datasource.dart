import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:transittrack/core/error/failure.dart';
import 'package:transittrack/features/authentication/data/model/user_credential_model.dart';

abstract class AuthenticationRemoteDatasource {
  Future<UserCredentialModel> login({
    required String phoneNumber,
    required String password,
  });

  Future<void> logout();

  Future<UserCredentialModel> signup({
    required String fullName,
    required String? email,
    required String phoneNumber,
    required String password,
  });

  Future<void> changePassword({
    required String newPassword,
    required String confirmPassword,
  });
}

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDatasource {
  final http.Client client;

  AuthenticationRemoteDataSourceImpl({required this.client});

  @override
  Future<Either<Failure, Unit>> changePassword(
      {required String newPassword, required String confirmPassword}) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
  
  @override
  Future<UserCredentialModel> login({required String phoneNumber, required String password}) {
    // TODO: implement login
    throw UnimplementedError();
  }
  
  @override
  Future<UserCredentialModel> signup({required String fullName, required String? email, required String phoneNumber, required String password}) {
    // TODO: implement register
    throw UnimplementedError();
  }


}
