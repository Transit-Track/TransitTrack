import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transittrack/features/home/domain/entities/location.dart';
import 'package:transittrack/features/home/domain/usecases/search_location_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  SearchLocationUsecase searchLocationUsecase;
  HomeBloc({required this.searchLocationUsecase}) : super(HomeInitial()) {
    on<GetLocationEvent>(_getLocation);
  }

  _getLocation(GetLocationEvent event, Emitter<HomeState> emit) async {
    emit(LocationLoadingState());
    final locationList = await searchLocationUsecase(SerachLocationParams(input: event.input));
    locationList.fold(
      (failure) => emit(LocationErrorState(failure.errorMessage)),
      (locationList) => emit(LocationLoadedState(locationList: locationList)),
    );    
  }
}
