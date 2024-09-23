import 'package:dartz/dartz.dart';
import 'package:transittrack/core/error/failure.dart';
import 'package:transittrack/core/usecases/usecases.dart';
import 'package:transittrack/features/driver/domain/repository/driver_repository.dart';

class GetNextRouteUsecase extends UseCase<String, GetNextRouteUsecaseParams> {
  final DriverRepository repository;
  GetNextRouteUsecase({required this.repository});
  @override
  Future<Either<Failure, String>> call(params) {
    return repository.getNextRoute(
      busId: params.busId,
    );
  }
}

class GetNextRouteUsecaseParams {
  final int busId;

  GetNextRouteUsecaseParams({
    required this.busId,
  });
}
