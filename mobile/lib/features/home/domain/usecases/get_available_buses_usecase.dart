import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:transittrack/core/error/failure.dart';
import 'package:transittrack/core/usecases/usecases.dart';
import 'package:transittrack/features/home/domain/entities/bus_entity.dart';
import 'package:transittrack/features/home/domain/repositories/home_repository.dart';

class GetAvailableBusesUsecase
    extends UseCase<List<BusEntity>, GetAvailableBusesParams> {
  final HomeRepository repository;
  GetAvailableBusesUsecase({required this.repository});

  @override
  Future<Either<Failure, List<BusEntity>>> call(params) {
    return repository.getAvailableBuses(
        params.startStation, params.destinationStation);
  }
}

class GetAvailableBusesParams extends Equatable {
  final String startStation;
  final String destinationStation;

  const GetAvailableBusesParams({
    required this.startStation,
    required this.destinationStation,
  });

  @override
  List<Object?> get props => [];
}
