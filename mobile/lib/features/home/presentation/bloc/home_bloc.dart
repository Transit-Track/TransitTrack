import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transittrack/features/home/domain/entities/bus.dart';
import 'package:transittrack/features/home/domain/entities/location.dart';
import 'package:transittrack/features/home/domain/entities/nearby.dart';
import 'package:transittrack/features/home/domain/usecases/get_arrival_time_usecase.dart';
import 'package:transittrack/features/home/domain/usecases/get_available_buses_usecase.dart';
import 'package:transittrack/features/home/domain/usecases/get_place_id_from_coordinates_usecase.dart';
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
  GetArrivalTimeUsecase getArrivalTimeUsecase;
  GetPlaceIdFromCoordinatesUsecase getPlaceIdFromCoordinatesUsecase;

  HomeBloc({
    required this.searchLocationUsecase,
    required this.searchNearbyBusesForDestinationUsecase,
    required this.searchNearbyBusesForStartUsecase,
    required this.getAvailableBusesUsecase,
    required this.getArrivalTimeUsecase,
    required this.getPlaceIdFromCoordinatesUsecase,
  }) : super(HomeInitial()) {
    on<GetLocationEvent>(_getLocation);
    on<GetNearbyBusesForStartEvent>(_getNearbyBusesForStart);
    on<GetNearbyBusesForDestinationEvent>(_getNearbyBusesForDestination);
    on<GetAvailableBusesEvent>(_getAvailableBusesEvent);
    on<GetArrivalTime>(_getArrivalTime);
    on<GetPlaceIdFromCoordinates>(_getPlaceIdFromCoordinates);
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

  _getNearbyBusesForStart(GetNearbyBusesForStartEvent event, Emitter<HomeState> emit) async {
    emit(NearByBusesForStartLoadingState());
    final nearByBusesForStartList =
        await searchNearbyBusesForStartUsecase(SearchNearbyBusesForStartParams(
      input: event.input,
    ));

    nearByBusesForStartList.fold(
      (failure) => emit(NearByBusesForStartErrorState(message: failure.errorMessage)),
      (nearByBusesForStartList) =>
          emit(NearByBusesForStartLoadedState(nearByBusesForStartList: nearByBusesForStartList)),
    );
  }

  _getNearbyBusesForDestination(GetNearbyBusesForDestinationEvent event, Emitter<HomeState> emit) async {
    emit(NearByBusesForDestinationLoadingState());
    final nearByBusesForDestinationList =
        await searchNearbyBusesForDestinationUsecase(SearchNearbyBusesForDestinationParams(
      input: event.input,
    ));

    nearByBusesForDestinationList.fold(
      (failure) => emit(NearByBusesForDestinationErrorState(message: failure.errorMessage)),
      (nearByBusesForDestinationList) =>
          emit(NearByBusesForDestinationLoadedState(nearByBusesForDestinationList: nearByBusesForDestinationList)),
    );
  }

  _getAvailableBusesEvent(
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

  _getArrivalTime(GetArrivalTime event, Emitter<HomeState> emit) async {
    emit(ArrivalTimePredictionLoadingState());
    final arrivalTime = await getArrivalTimeUsecase(GetArrivalTimeParams(
      startPlaceId: event.startPlaceId,
      destinationPlaceId: event.destinationPlaceId,
    ));

    arrivalTime.fold(
      (failure) => emit(ArrivalTimePredictionErrorState(errorMessage: failure.errorMessage)),
      (arrivalTime) =>
          emit(ArrivalTimePredictionLoadedState(arrivalTime: arrivalTime)),
    );
  }

  _getPlaceIdFromCoordinates(GetPlaceIdFromCoordinates event, Emitter<HomeState> emit) async {
    emit(GetPlaceIdFromCoordinateLoadingState());
    final placeId = await getPlaceIdFromCoordinatesUsecase(GetPlaceIdFromCoordinatesParams(
      longitude: event.longitude,
      latitude: event.latitude,
    ));

    placeId.fold(
      (failure) => emit(GetPlaceIdFromCoordinateErrorState(errorMessage: failure.errorMessage)),
      (placeId) => emit(GetPlaceIdFromCoordinateLoadedState(placeId: placeId)),
    );
  }
}
