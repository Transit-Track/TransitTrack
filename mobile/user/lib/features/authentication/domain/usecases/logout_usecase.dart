import 'package:dartz/dartz.dart';
import 'package:transittrack/core/error/failure.dart';
import 'package:transittrack/core/usecases/usecases.dart';
import 'package:transittrack/features/authentication/domain/repository/authentication_repository.dart';

class LogoutUsecase extends UseCase<void, NoParams> {
  final AuthenticationRepository repository;

  LogoutUsecase({required this.repository});
  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repository.logout();
  }
}
