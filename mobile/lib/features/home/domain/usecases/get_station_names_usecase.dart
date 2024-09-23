import 'package:dartz/dartz.dart';
import 'package:transittrack/core/error/failure.dart';
import 'package:transittrack/core/usecases/usecases.dart';
import 'package:transittrack/features/home/domain/repositories/home_repository.dart';

class GetStationNamesUsecase extends UseCase<List<String>, NoParams> {
  final HomeRepository repository;
  GetStationNamesUsecase({required this.repository});
  @override
  Future<Either<Failure, List<String>>> call(NoParams params) {
    return repository.getStationNames();
  }
}
