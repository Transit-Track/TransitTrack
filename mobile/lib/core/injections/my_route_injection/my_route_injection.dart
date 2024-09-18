import 'package:transittrack/core/injections/injection.dart';
import 'package:transittrack/features/my_route/data/datasources/my_route_remote_data_source.dart';
import 'package:transittrack/features/my_route/data/repository/my_route_repository_impl.dart';
import 'package:transittrack/features/my_route/domain/repository/my_route_repository.dart';
import 'package:transittrack/features/my_route/domain/usecases/add_bus_to_my_route_usecase.dart';
import 'package:transittrack/features/my_route/domain/usecases/get_my_route_usecase.dart';
import 'package:transittrack/features/my_route/domain/usecases/remove_bus_from_my_route_usecase.dart';
import 'package:transittrack/features/my_route/presentation/bloc/my_route_bloc.dart';

class MyRouteInjection {
  init() {
    //! Bloc
    sl.registerFactory(() => MyRouteBloc(
          addBusToMyRouteUsecase: sl(),
          removeBusFromMyRouteUsecase: sl(),
          getMyRouteUsecase: sl(),
        ));
        
//! Repository
    sl.registerLazySingleton<MyRouteRepository>(() => MyRouteRepositoryImpl(
        networkInfo: sl(), remoteDataSource: sl()));

    //! DataSource
    sl.registerLazySingleton<MyRouteRemoteDataSource>(() =>
        MyRouteRemoteDataSourceImpl(client: sl()));

    //! Usecase
    sl.registerLazySingleton(() => GetMyRouteUsecase(repository: sl()));
    sl.registerLazySingleton(() => AddBusToMyRouteUsecase(repository: sl()));
    sl.registerLazySingleton(() => RemoveBusFromMyRouteUsecase(repository: sl()));
  }
}
