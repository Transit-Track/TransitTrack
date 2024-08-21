import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:transittrack/core/error/failure.dart';
import 'package:transittrack/features/authentication/data/model/user_credential_model.dart';

abstract class AuthenticationRemoteDatasource {
  Future<String> login({
    required String phoneNumber,
    required String password,
  });

  Future<UserCredentialModel> getUserDetail({required String token});

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

  final String baseUrl = 'http://192.168.0.128:8000/auth';
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
  Future<String> login(
      {required String phoneNumber, required String password}) async {
    final Map<String, dynamic> user = {
      'username': phoneNumber,
      'password': password,
    };

    final response = await client.post(
      Uri.parse('$baseUrl/token'),
      body: user,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    );

    print('userrrrrrrrrrr $user');

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final token = responseBody['access_token'];
      print(token);
      await secureStorage.write(key: 'auth_token', value: token);
      return token;
    } else if (response.statusCode == 401) {
      throw Exception(json.decode(response.body)['detail']);
    } else {
      throw Exception('Failed to login');
    }
  }

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
    };

    print(json.encode(user));
    final response = await client.post(
      Uri.parse('$baseUrl/signup'),
      body: json.encode(user),
      headers: {'Content-Type': 'application/json'},
    );

    print(response.body);

    if (response.statusCode == 200) {
      print("responseeeeeeeeeeee ${response.body}");
      return UserCredentialModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 400) {
      throw Exception(json.decode(response.body)['detail']);
    } else {
      throw Exception();
    }
  }

  @override
  Future<UserCredentialModel> getUserDetail({required String token}) async {
    final reponse = await client.get(Uri.parse('$baseUrl/users/me'),
        headers: {'Authorization': 'Bearer $token'});

    if (reponse.statusCode == 200) {
      final responseBody = json.decode(reponse.body);
      final user = UserCredentialModel.fromJson(responseBody);
      await storeUserCredentials(user);
      return user;
    } else {
      throw Exception('Failed to fetch user details');
    }
  }

  Future<void> storeUserCredentials(UserCredentialModel user) async {
    final userJson = json.encode(user.toJson());
    await secureStorage.write(key: 'user_credentials', value: userJson);
  }

  Future<UserCredentialModel?> getUserCredentials() async {
    final userJson = await secureStorage.read(key: 'user_credentials');
    if (userJson != null) {
      final Map<String, dynamic> userMap = json.decode(userJson);
      return UserCredentialModel.fromJson(userMap);
    }
    return null;
  }
}
