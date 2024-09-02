import 'package:dartz/dartz.dart';
import 'package:transittrack/core/error/failure.dart';
import 'package:transittrack/core/usecases/usecases.dart';
import 'package:transittrack/features/home/domain/repositories/home_repository.dart';

class GetArrivalTimeUsecase extends UseCase<String?, GetArrivalTimeParams> {
  final HomeRepository repository;
  GetArrivalTimeUsecase({required this.repository});
  @override
  Future<Either<Failure, String?>> call(GetArrivalTimeParams params) async {
    return await repository.arrivalTimePrediction(
      params.startPlaceId,
      params.destinationPlaceId,
    );
  }
}

class GetArrivalTimeParams {
  final String? startPlaceId;
  final String? destinationPlaceId;

  GetArrivalTimeParams(
      {required this.startPlaceId, required this.destinationPlaceId});
}
