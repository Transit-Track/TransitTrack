import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:transittrack/core/error/exceptions.dart';
import 'package:transittrack/core/error/failure.dart';
import 'package:transittrack/features/authentication/data/model/user_credential_model.dart';

abstract class AuthenticationRemoteDatasource {
  Future<String> login({
    required String phoneNumber,
    required String password,
  });

  Future<UserCredentialModel> getUserCredential({required String token});

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
  final FlutterSecureStorage secureStorage;

  AuthenticationRemoteDataSourceImpl(
      {required this.client, required this.secureStorage});

  final String baseUrl = 'http://192.168.132.143:8000';

  @override
  Future<UserCredentialModel> signup({
    required String fullName,
    required String? email,
    required String phoneNumber,
    required String password,
  }) async {
    final Map<String, dynamic> user = {
      'full_name': fullName,
      'email': email != '' ? email : null,
      'phone_number': phoneNumber,
      'password': password,
      'role': 'driver'
    };

    final response = await client.post(
      Uri.parse('$baseUrl/signup'),
      body: json.encode(user),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return UserCredentialModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 400) {
      throw Exception(json.decode(response.body)['detail']);
    } else {
      throw AuthenticationException();
    }
  }

  @override
  Future<String> login(
      {required String phoneNumber, required String password}) async {
    final Map<String, dynamic> user = {
      'phone_number': phoneNumber,
      'password': password,
    };

    final response = await client.post(
      Uri.parse('$baseUrl/login'),
      body: json.encode(user),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final token = responseBody['access_token'];
      return token;
    } else {
      throw UnauthorizedException();
    }
  }

  @override
  Future<UserCredentialModel> getUserCredential({required String token}) async {
    final reponse = await client.get(Uri.parse('$baseUrl/users/me'),
        headers: {'Authorization': 'Bearer $token'});

    if (reponse.statusCode == 200) {
      final responseBody = json.decode(reponse.body);
      final user = UserCredentialModel.fromJson(responseBody);
      return user;
    } else {
      throw Exception('Failed to fetch user details');
    }
  }

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
}
