import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:transittrack/features/authentication/domain/entities/userCredential.dart';
import 'package:transittrack/features/authentication/domain/usecases/signup_usecase.dart';

import '../../helper/auth_test_helper.mocks.dart';

void main() {
  late SignupUsecase signupUsecase;
  late MockAuthenticationRepository mockAuthenticationRepository;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    signupUsecase = SignupUsecase(repository: mockAuthenticationRepository);
  });

  const tUserCredential = {
    "full_name": 'John Doe',
    "phone_number": '08123456789',
    "email": '',
    "password": 'password',
  };

  const tUserCredentialResponse = UserCredential(
    id: '1',
    fullName: 'John Doe',
    phoneNumber: '08123456789',
  );

  test('should signup a user succesfuly', () async {
    // arrange
    when(mockAuthenticationRepository.signup(
            fullName: tUserCredential['full_name']!,
            phoneNumber: tUserCredential['phone_number'],
            email: tUserCredential['email'],
            password: tUserCredential['password']))
        .thenAnswer((_) async => const Right(tUserCredentialResponse));
    
    // act
    final result = await signupUsecase( SignupParams(
      fullName: tUserCredential['full_name'] as String,
      phoneNumber: tUserCredential['phone_number'] as String,
      email: tUserCredential['email'] as String,
      password: tUserCredential['password'] as String,
    ));

    // assert
    expect(result, const Right(tUserCredentialResponse));
  });
}
