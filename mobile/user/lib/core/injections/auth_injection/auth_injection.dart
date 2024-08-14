import 'package:transittrack/core/injections/injection.dart';
import 'package:transittrack/features/authentication/data/datasource/auth_remote_datasource.dart';
import 'package:transittrack/features/authentication/data/repositories/auth_repositiries_impl.dart';
import 'package:transittrack/features/authentication/domain/repository/authentication_repository.dart';
import 'package:transittrack/features/authentication/domain/usecases/change_password_usecase.dart';
import 'package:transittrack/features/authentication/domain/usecases/login_usecase.dart';
import 'package:transittrack/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:transittrack/features/authentication/domain/usecases/signup_usecase.dart';
import 'package:transittrack/features/authentication/presentation/bloc/authentication_bloc.dart';

class AuthInjection {
  init() {
    //! Bloc
    sl.registerFactory(() => AuthenticationBloc(
          changePasswordUsecase: sl(),
          loginUsecase: sl(),
          logoutUsecase: sl(),
          signupUsecase: sl(),
        ));

    //! Data
    sl.registerLazySingleton<AuthenticationRemoteDatasource>(
        () => AuthenticationRemoteDataSourceImpl(client: sl()));

    //! Repository
    sl.registerLazySingleton<AuthenticationRepository>(() =>
        AuthenticationRepositoryImpl(networkInfo: sl(), remoteDatasource: sl()));

    //! usecase
    sl.registerLazySingleton(() => LoginUsecase(repository: sl()));
    sl.registerLazySingleton(() => SignupUsecase(repository: sl()));
    sl.registerLazySingleton(() => LogoutUsecase(repository: sl()));
    sl.registerLazySingleton(() => ChangePasswordUsecase(repository: sl()));
  }
}
