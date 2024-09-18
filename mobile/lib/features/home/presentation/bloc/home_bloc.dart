import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transittrack/features/driver/domain/entity/driver_location_entity.dart';
import 'package:transittrack/features/home/domain/entities/bus_entity.dart';
import 'package:transittrack/features/home/domain/entities/place_entity.dart';
import 'package:transittrack/features/home/domain/usecases/get_available_buses_usecase.dart';
import 'package:transittrack/features/home/domain/usecases/get_driver_location_usecase.dart';
import 'package:transittrack/features/home/domain/usecases/search_location_usecase.dart';
import 'package:transittrack/features/home/domain/usecases/search_nearby_buses_for_destination_useecase.dart';
import 'package:transittrack/features/home/domain/usecases/search_nearby_buses_for_start_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  SearchLocationUsecase searchLocationUsecase;
  SearchNearbyBusesForStartUsecase searchNearbyBusesForStartUsecase;
  SearchNearbyBusesForDestinationUsecase searchNearbyBusesForDestinationUsecase;
  GetAvailableBusesUsecase getAvailableBusesUsecase;
  GetDriverLocationUsecase getDriverLocationUsecase;

  HomeBloc({
    required this.searchLocationUsecase,
    required this.searchNearbyBusesForDestinationUsecase,
    required this.searchNearbyBusesForStartUsecase,
    required this.getAvailableBusesUsecase,
    required this.getDriverLocationUsecase,
  }) : super(HomeInitial()) {
    on<GetLocationEvent>(_getLocation);
    on<GetNearbyBusesForStartEvent>(_getNearbyBusesForStart);
    on<GetNearbyBusesForDestinationEvent>(_getNearbyBusesForDestination);
    on<GetAvailableBusesEvent>(_getAvailableBuses);
    on<GetDriverLocation>(_getDriverLocation);
  }

  _getLocation(GetLocationEvent event, Emitter<HomeState> emit) async {
    emit(LocationLoadingState());
    final locationList =
        await searchLocationUsecase(SerachLocationParams(input: event.input));
    locationList.fold(
      (failure) => emit(LocationErrorState(failure.errorMessage)),
      (locationList) => emit(LocationLoadedState(locationList: locationList)),
    );
  }

  _getNearbyBusesForStart(
      GetNearbyBusesForStartEvent event, Emitter<HomeState> emit) async {
    emit(NearByBusesForStartLoadingState());
    final nearByBusesForStartList =
        await searchNearbyBusesForStartUsecase(SearchNearbyBusesForStartParams(
      input: event.input,
    ));

    nearByBusesForStartList.fold(
      (failure) =>
          emit(NearByBusesForStartErrorState(message: failure.errorMessage)),
      (nearByBusesForStartList) => emit(NearByBusesForStartLoadedState(
          nearByBusesForStartList: nearByBusesForStartList)),
    );
  }

  _getNearbyBusesForDestination(
      GetNearbyBusesForDestinationEvent event, Emitter<HomeState> emit) async {
    emit(NearByBusesForDestinationLoadingState());
    final nearByBusesForDestinationList =
        await searchNearbyBusesForDestinationUsecase(
            SearchNearbyBusesForDestinationParams(
      input: event.input,
    ));

    nearByBusesForDestinationList.fold(
      (failure) => emit(
          NearByBusesForDestinationErrorState(message: failure.errorMessage)),
      (nearByBusesForDestinationList) => emit(
          NearByBusesForDestinationLoadedState(
              nearByBusesForDestinationList: nearByBusesForDestinationList)),
    );
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
      (failure) => emit(GetDriverLocationErrorState(errorMessage: failure.errorMessage)),
      (driveEntity) => emit(GetDriverLocationLoadedState(driverLocationEntity: driveEntity)),
    );
  }

 
}
