part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class GetLocationEvent extends HomeEvent {
  final String input;

  const GetLocationEvent({required this.input});
}
