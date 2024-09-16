import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:transittrack/features/authentication/data/model/user_credential_model.dart';

import '../../helper/json_reader.dart';

void main() {
  const testUserCredentialModel = UserCredentialModel(
      id: '66d8a5266227691b61f6da08',
      fullName: 'string',
      phoneNumber: 'striyyyyyyyyyyng',
      password:
          r"$2b$12$2Rt9OrRUIUY4p9MiBBkNVexOCrhmkbfSp0j6CMsYCLLnXTKv0r2su");

  test('should be a subclass of userCredential entity', () async {
    // assert
    expect(testUserCredentialModel, isA<UserCredentialModel>());
  });

  test('should return a valid model from json', () async {
    // arrange
    final Map<String, dynamic> jsonMap = json.decode(
      readJson(
        'helper/dummy_data/dummy_user_response.json',
      ),
    );

    // act
    final result = UserCredentialModel.fromJson(jsonMap);

    // assert
    expect(result, equals(testUserCredentialModel));
  });

  const tUserJson = {
    'full_name': 'string',
    'phone_number': 'striyyyyyyyyyyng',
    'email': null,
    'password': r'$2b$12$2Rt9OrRUIUY4p9MiBBkNVexOCrhmkbfSp0j6CMsYCLLnXTKv0r2su',
    'token': null
  };

  test('should return a valid json containing proper data', () async {
    // act
    final result = testUserCredentialModel.toJson();

    // assert
    expect(result, equals(tUserJson));
  });
}
