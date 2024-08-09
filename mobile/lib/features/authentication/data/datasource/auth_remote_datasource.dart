import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:transittrack/core/error/failure.dart';

abstract class AuthRemoteDatasource {
  Future<UserCredential> login(String email, String password);
  Future<void> logout();
  Future<UserCredential> register(String email, String password);
  Future<void> changePassword({
    required String phoneNumber,
    required String newPassword,
    required String confirmPassword,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDatasource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});
  
  @override
  Future<Either<Failure, Unit>> changePassword({required String phoneNumber, required String newPassword, required String confirmPassword}) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }
  
  @override
  Future<UserCredential> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }
  
  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
  
  @override
  Future<UserCredential> register(String email, String password) {
    // TODO: implement register
    throw UnimplementedError();
  }

}