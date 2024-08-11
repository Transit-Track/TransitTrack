part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class LocationLoadingState extends HomeState {}

final class LocationLoadedState extends HomeState {
  final List<LocationEntity> locationList;

  const LocationLoadedState({required this.locationList});
}

final class LocationErrorState extends HomeState {
  final String message;

  const LocationErrorState(this.message);
}

// final class HomeInitial extends HomeState {}
