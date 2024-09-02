import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:transittrack/features/authentication/data/model/user_credential_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);

  Future<String?> getToken();

  Future<void> deleteToken();

  Future<void> storeUserCredential(UserCredentialModel userCredential);

  Future<UserCredentialModel?> getUserCredentials();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  Future<void> saveToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);
  }

  @override
  Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  @override
  Future<void> deleteToken() async {
    await _storage.delete(key: 'auth_token');
  }

  @override
  Future<void> storeUserCredential(UserCredentialModel userCredential) async {
    final userJson = json.encode(userCredential.toJson());
    await _storage.write(key: 'user_credentials', value: userJson);
  }

  @override
  Future<UserCredentialModel?> getUserCredentials() async {
    final userJson = await _storage.read(key: 'user_credentials');
    if (userJson != null) {
      final Map<String, dynamic> userMap = json.decode(userJson);
      return UserCredentialModel.fromJson(userMap);
    }
    return null;
  }
}
