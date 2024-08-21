import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transittrack/features/authentication/domain/entities/userCredential.dart';
import 'package:transittrack/features/authentication/domain/usecases/change_password_usecase.dart';
import 'package:transittrack/features/authentication/domain/usecases/login_usecase.dart';
import 'package:transittrack/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:transittrack/features/authentication/domain/usecases/signup_usecase.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final SignupUsecase signupUsecase;
  final LoginUsecase loginUsecase;
  final ChangePasswordUsecase changePasswordUsecase;
  final LogoutUsecase logoutUsecase;

  AuthenticationBloc({
    required this.changePasswordUsecase,
    required this.loginUsecase,
    required this.logoutUsecase,
    required this.signupUsecase,
  }) : super(AuthenticationInitial()) {
    on<SignUpEvent>(_onSignup);
    on<LogInEvent>(_login);
    on<ChangePasswordEvent>(_changePassword);
  }

  void _onSignup(SignUpEvent event, Emitter<AuthenticationState> emit) async {
    emit(SignupLoadingState());
    final result = await signupUsecase(
      SignupParams(
        fullName: event.fullName,
        phoneNumber: event.phoneNumber,
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(SignupErrorState(message: failure.errorMessage)),
      (user) => emit(SignUpSuccessState(user: user)),
    );
  }

  void _login(LogInEvent event, Emitter<AuthenticationState> emit) async {
    emit(LoginLoadingState());

    final result = await loginUsecase(LoginParams(
      phoneNumber: event.phoneNumber,
      password: event.password,
    ));

    print('resulttttttttttttttttttttttttttt $result');

    result.fold(
      (failure) => emit(LoginErrorState(message: failure.errorMessage)),
      (user) => emit(LoggedInState(user: user)),
    );
  }

  void _changePassword(
      ChangePasswordEvent event, Emitter<AuthenticationState> emit) async {
    emit(ChangePasswordLoadingState());

    final result = await changePasswordUsecase(ChangePasswordParams(
      newPassword: event.newPassword,
      confirmPassword: event.confirmPassword,
    ));

    result.fold(
      (failure) =>
          emit(ChangePasswordErrorState(message: failure.errorMessage)),
      (user) => emit(ChangePasswordSuccessState()),
    );
  }
}
