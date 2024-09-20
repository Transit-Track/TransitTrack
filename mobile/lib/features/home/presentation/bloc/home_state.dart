part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

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

//! Get station Names state
final class GetStationNamesLoadingState extends HomeState {}

final class GetStationNamesLoadedState extends HomeState {
  final List<String> stationNames;

  const GetStationNamesLoadedState({
    required this.stationNames,
  });
}

final class GetStationNamesErrorState extends HomeState {
  final String errorMessage;

  const GetStationNamesErrorState({
    required this.errorMessage,
  });
}
