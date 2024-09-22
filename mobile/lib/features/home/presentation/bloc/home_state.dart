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
  final List<PlaceEntity> locationList;

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

//! Get driver location state
final class GetDriverLocationLoadingState extends HomeState {}

final class GetDriverLocationLoadedState extends HomeState {
  final LocationEntity driverLocationEntity;

  const GetDriverLocationLoadedState({required this.driverLocationEntity});
}

final class GetDriverLocationErrorState extends HomeState {
  final String errorMessage;

  const GetDriverLocationErrorState({required this.errorMessage});
}