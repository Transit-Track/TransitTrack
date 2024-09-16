import 'package:dartz/dartz.dart';
import 'package:transittrack/core/error/failure.dart';
import 'package:transittrack/core/usecases/usecases.dart';
import 'package:transittrack/features/driver/domain/repository/driver_repository.dart';

class UpdateDriverLocationUsecase
    extends UseCase<String, UpdateDriverLocationParams> {
  final DriverRepository repository;

  UpdateDriverLocationUsecase({required this.repository});
  @override
  Future<Either<Failure, String>> call(params) {
    return repository.updateDriverLocation(
      latitude: params.latitude,
      longitude: params.longitude,
    );
  }
}

class UpdateDriverLocationParams {
  final double latitude;
  final double longitude;

  UpdateDriverLocationParams({
    required this.latitude,
    required this.longitude,
  });
}
