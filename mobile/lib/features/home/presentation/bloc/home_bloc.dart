import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transittrack/core/usecases/usecases.dart';
import 'package:transittrack/features/driver/domain/entity/driver_location_entity.dart';
import 'package:transittrack/features/home/domain/entities/bus_entity.dart';
import 'package:transittrack/features/home/domain/usecases/get_available_buses_usecase.dart';
import 'package:transittrack/features/home/domain/usecases/get_driver_location_usecase.dart';
import 'package:transittrack/features/home/domain/usecases/get_station_names_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  GetAvailableBusesUsecase getAvailableBusesUsecase;
  GetDriverLocationUsecase getDriverLocationUsecase;
  GetStationNamesUsecase getStationNamesUsecase;

  HomeBloc({
    required this.getAvailableBusesUsecase,
    required this.getDriverLocationUsecase,
    required this.getStationNamesUsecase,
  }) : super(HomeInitial()) {
    on<GetAvailableBusesEvent>(_getAvailableBuses);
    on<GetDriverLocation>(_getDriverLocation);
    on<GetStationNames>(_getStationNames);
  }
  _getAvailableBuses(
      GetAvailableBusesEvent event, Emitter<HomeState> emit) async {
    emit(AvailableBusesLoadingState());
    final availableBusesList =
        await getAvailableBusesUsecase(GetAvailableBusesParams(
      startStation: event.startStation,
      destinationStation: event.destinationStation,
    ));

    availableBusesList.fold(
      (failure) =>
          emit(AvailableBusesErrorState(errorMessage: failure.errorMessage)),
      (availableBusesList) => emit(
          AvailableBusesLoadedState(availableBusesList: availableBusesList)),
    );
  }

  _getDriverLocation(GetDriverLocation event, Emitter<HomeState> emit) async {
    final driverLocation = await getDriverLocationUsecase(
        GetDriverLocationParams(driverPhoneNumber: event.driverPhoneNumber));

    driverLocation.fold(
      (failure) =>
          emit(GetDriverLocationErrorState(errorMessage: failure.errorMessage)),
      (driveEntity) =>
          emit(GetDriverLocationLoadedState(driverLocationEntity: driveEntity)),
    );
  }

  _getStationNames(GetStationNames event, Emitter<HomeState> emit) async {
    emit(GetStationNamesLoadingState());
    final stationNames = await getStationNamesUsecase(NoParams());
    stationNames.fold(
      (failure) =>
          emit(GetStationNamesErrorState(errorMessage: failure.errorMessage)),
      (stationNames) =>
          emit(GetStationNamesLoadedState(stationNames: stationNames)),
    );
  }
}
