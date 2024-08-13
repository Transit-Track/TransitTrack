part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

// location based search state
final class LocationLoadingState extends HomeState {}

final class LocationLoadedState extends HomeState {
  final List<LocationEntity> locationList;

  const LocationLoadedState({required this.locationList});
}

final class LocationErrorState extends HomeState {
  final String message;

  const LocationErrorState(this.message);
}

// nearby bus search state

final class NearByBusesLoadingState extends HomeState {}

final class NearByBusesLoadedState extends HomeState {
  final List<NearByEntity> nearByBusesList;

  const NearByBusesLoadedState({required this.nearByBusesList});
}

final class NearByBusesErrorState extends HomeState {
  final String message;

  const NearByBusesErrorState(this.message);
}
