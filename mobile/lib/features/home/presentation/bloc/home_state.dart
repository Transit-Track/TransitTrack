part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

//! location based search state

final class LocationLoadingState extends HomeState {}

final class LocationLoadedState extends HomeState {
  final List<LocationEntity> locationList;

  const LocationLoadedState({required this.locationList});
}

final class LocationErrorState extends HomeState {
  final String message;

  const LocationErrorState(this.message);
}

//! Nearby bus search state

final class NearByBusesForStartLoadingState extends HomeState {}

final class NearByBusesForStartLoadedState extends HomeState {
  final List<String> nearByBusesForStartList;

  const NearByBusesForStartLoadedState({required this.nearByBusesForStartList});
}

final class NearByBusesForStartErrorState extends HomeState {
  final String message;

  const NearByBusesForStartErrorState({required this.message});
}

final class NearByBusesForDestinationLoadingState extends HomeState {}

final class NearByBusesForDestinationLoadedState extends HomeState {
  final List<String> nearByBusesForDestinationList;

  const NearByBusesForDestinationLoadedState({required this.nearByBusesForDestinationList});
}

final class NearByBusesForDestinationErrorState extends HomeState {
  final String message;

  const NearByBusesForDestinationErrorState({required this.message});
}


//! Available buses search state

final class AvailableBusesLoadingState extends HomeState {}

final class AvailableBusesLoadedState extends HomeState {
  final List<BusEntity> availableBusesList;

  const AvailableBusesLoadedState({required this.availableBusesList});
}

final class AvailableBusesErrorState extends HomeState {
  final String errorMessage;

  const AvailableBusesErrorState({required this.errorMessage});
}


//! Arrival time prediction state

final class ArrivalTimePredictionLoadingState extends HomeState {}

final class ArrivalTimePredictionLoadedState extends HomeState {
  final String? arrivalTime;

  const ArrivalTimePredictionLoadedState({required this.arrivalTime});
}

final class ArrivalTimePredictionErrorState extends HomeState {
  final String errorMessage;

  const ArrivalTimePredictionErrorState({required this.errorMessage});
}

//! Get place id from coordinate state

final class GetPlaceIdFromCoordinateLoadingState extends HomeState {}

final class GetPlaceIdFromCoordinateLoadedState extends HomeState {
  final String? placeId;

  const GetPlaceIdFromCoordinateLoadedState({required this.placeId});
}

final class GetPlaceIdFromCoordinateErrorState extends HomeState {
  final String errorMessage;

  const GetPlaceIdFromCoordinateErrorState({required this.errorMessage});
}
