import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:transittrack/core/usecases/usecases.dart';
import 'package:transittrack/features/authentication/domain/usecases/logout_usecase.dart';

import '../../helper/auth_test_helper.mocks.dart';

void main() {
  late LogoutUsecase logoutUsecase;
  late MockAuthenticationRepository mockAuthenticationRepository;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    logoutUsecase = LogoutUsecase(repository: mockAuthenticationRepository);
  });

  test('should return UserCredential when log in succesful', () async {
    // arrange
    when(mockAuthenticationRepository.logout())
        .thenAnswer((_) async => Right(Void));

    // act
    final result = await logoutUsecase(NoParams());

    // assert
    expect(result, Right(Void));
  });
}
