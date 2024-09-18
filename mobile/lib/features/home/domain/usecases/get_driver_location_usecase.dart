import 'package:dartz/dartz.dart';
import 'package:transittrack/core/error/failure.dart';
import 'package:transittrack/core/usecases/usecases.dart';
import 'package:transittrack/features/driver/domain/entity/driver_location_entity.dart';
import 'package:transittrack/features/home/domain/repositories/home_repository.dart';

class GetDriverLocationUsecase extends UseCase<LocationEntity, GetDriverLocationParams> { 
  final HomeRepository repository;
  GetDriverLocationUsecase({required this.repository});
   @override
  Future<Either<Failure, LocationEntity>> call(params) {
    return repository.getDriverLocation(params.driverPhoneNumber);
  }
}

class GetDriverLocationParams {
  final String driverPhoneNumber;

  GetDriverLocationParams({required this.driverPhoneNumber});
}
