import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:transittrack/features/authentication/data/model/user_credential_model.dart';

abstract class AuthenticationLocalDataSource {
  Future<void> saveToken(String token);

  Future<String?> getToken();

  Future<void> deleteToken();

  Future<void> storeUserCredential(UserCredentialModel userCredential);

  Future<UserCredentialModel?> getUserCredentials();
}

class AuthenticationLocalDataSourceImpl implements AuthenticationLocalDataSource {
  final FlutterSecureStorage secureStorage;

  AuthenticationLocalDataSourceImpl({required this.secureStorage});

  @override
  Future<void> saveToken(String token) async {
    await secureStorage.write(key: 'auth_token', value: token);
  }

  @override
  Future<String?> getToken() async {
    return await secureStorage.read(key: 'auth_token');
  }

  @override
  Future<void> deleteToken() async {
    await secureStorage.delete(key: 'auth_token');
  }

  @override
  Future<void> storeUserCredential(UserCredentialModel userCredential) async {
    final userJson = json.encode(userCredential.toJson());
    await secureStorage.write(key: 'user_credentials', value: userJson);
  }

  @override
  Future<UserCredentialModel?> getUserCredentials() async {
    final userJson = await secureStorage.read(key: 'user_credentials');
    if (userJson != null) {
      final Map<String, dynamic> userMap = json.decode(userJson);
      return UserCredentialModel.fromJson(userMap);
    }
    return null;
  }
}
