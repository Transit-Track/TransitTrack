import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:transittrack/features/authentication/domain/entities/userCredential.dart';
import 'package:transittrack/features/authentication/domain/usecases/login_usecase.dart';

import '../../helper/auth_test_helper.mocks.dart';

void main() {
  late LoginUsecase loginUsecase;
  late MockAuthenticationRepository mockAuthenticationRepository;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    loginUsecase = LoginUsecase(repository: mockAuthenticationRepository);
  });

  const tPhoneNumber = '08123456789';
  const tPassword = 'password';

  const tUserCredential = {
    "full_name": 'John Doe',
    "phone_number": tPhoneNumber,
    "email": '',
    "password": tPassword,
  };

  UserCredential tUserCredentialResponse = UserCredential(
    id: '',
    fullName: 'John Doe',
    phoneNumber: '08123456789',
    email: '',
    password: 'password',
  );

  test('should return UserCredential when log in succesful', () async {
    // arrange
    when(mockAuthenticationRepository.login(
            phoneNumber: tPhoneNumber, password: tPassword))
        .thenAnswer((_) async => Right(tUserCredentialResponse));

    // act
    final result = await loginUsecase(const LoginParams(
      phoneNumber: tPhoneNumber,
      password: tPassword,
    ));

    // assert
    expect(result, Right(tUserCredentialResponse));
  });
}
