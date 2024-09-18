import 'package:transittrack/core/injections/injection.dart';
import 'package:transittrack/features/home/data/datasource/remote/google_map_datasource.dart';
import 'package:transittrack/features/home/data/datasource/remote/remote_datasource.dart';
import 'package:transittrack/features/home/data/repository/home_repository_impl.dart';
import 'package:transittrack/features/home/domain/repositories/home_repository.dart';
import 'package:transittrack/features/home/domain/usecases/get_available_buses_usecase.dart';
import 'package:transittrack/features/home/domain/usecases/get_driver_location_usecase.dart';
import 'package:transittrack/features/home/domain/usecases/search_location_usecase.dart';
import 'package:transittrack/features/home/domain/usecases/search_nearby_buses_for_destination_useecase.dart';
import 'package:transittrack/features/home/domain/usecases/search_nearby_buses_for_start_usecase.dart';
import 'package:transittrack/features/home/presentation/bloc/home_bloc.dart';

class HomeInjection {
  init() {
    //! Bloc
    sl.registerFactory(() => HomeBloc(
        searchLocationUsecase: sl(),
        searchNearbyBusesForStartUsecase: sl(),
        searchNearbyBusesForDestinationUsecase: sl(),
        getAvailableBusesUsecase: sl(),
        getDriverLocationUsecase: sl()));

    //! Repository
    sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(
        networkInfo: sl(), remoteDataSource: sl(), googleMapDatasource: sl()));

    //! DataSource
    sl.registerLazySingleton<GoogleMapDatasource>(
        () => GoogleMapDataSourceImpl(client: sl()));
    sl.registerLazySingleton<HomeRemoteDataSource>(() =>
        HomeRemoteDataSourceImpl(client: sl(), googleMapDatasource: sl()));

    //! Usecase
    sl.registerLazySingleton(() => SearchLocationUsecase(repository: sl()));
    sl.registerLazySingleton(
        () => SearchNearbyBusesForStartUsecase(repository: sl()));
    sl.registerLazySingleton(
        () => SearchNearbyBusesForDestinationUsecase(repository: sl()));
    sl.registerLazySingleton(() => GetAvailableBusesUsecase(repository: sl()));
    sl.registerLazySingleton(() => GetDriverLocationUsecase(repository: sl()));
  }
}
