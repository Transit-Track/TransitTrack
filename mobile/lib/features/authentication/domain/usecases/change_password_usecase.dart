import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:transittrack/core/error/failure.dart';
import 'package:transittrack/core/usecases/usecases.dart';
import 'package:transittrack/features/authentication/domain/repository/authentication_repository.dart';

class ChangePasswordUsecase extends UseCase<void, ChangePasswordParams> {
  final AuthenticationRepository repository;

  ChangePasswordUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(ChangePasswordParams params) async {
    return await repository.changePassword(
        newPassword: params.newPassword,
        confirmPassword: params.confirmPassword);
  }
}

class ChangePasswordParams extends Equatable {
  final String newPassword;
  final String confirmPassword;

  const ChangePasswordParams({required this.newPassword, required this.confirmPassword});
  @override
  List<Object?> get props => [newPassword, confirmPassword];
}
