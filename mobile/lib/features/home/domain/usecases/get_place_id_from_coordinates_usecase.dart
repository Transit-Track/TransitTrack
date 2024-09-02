import 'package:dartz/dartz.dart';
import 'package:transittrack/core/error/failure.dart';
import 'package:transittrack/core/usecases/usecases.dart';
import 'package:transittrack/features/home/domain/repositories/home_repository.dart';

class GetPlaceIdFromCoordinatesUsecase
    extends UseCase<String?, GetPlaceIdFromCoordinatesParams> {
  final HomeRepository repository;
  GetPlaceIdFromCoordinatesUsecase(this.repository);
  @override
  Future<Either<Failure, String?>> call(GetPlaceIdFromCoordinatesParams params) async {
    return await repository.getPlaceIdFromCoordinates(
        params.longitude, params.latitude);
  }
}

class GetPlaceIdFromCoordinatesParams {
  final double longitude;
  final double latitude;

  GetPlaceIdFromCoordinatesParams(
      {required this.longitude, required this.latitude});
}
