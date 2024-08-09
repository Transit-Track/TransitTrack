import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transittrack/features/authentication/domain/entities/userCredential.dart';
import 'package:transittrack/features/authentication/domain/repository/authentication_repository.dart';
import 'package:transittrack/features/authentication/domain/repository/firebase_auth_repositories.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  AuthenticationBloc(this._authenticationRepository)
      : super(AuthenticationInitial()) {
    on<SignUpEvent>(_onSignup);
    on<LogInEvent>(_login);
  }

  void _onSignup(SignUpEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    final result = await _authenticationRepository.signup(
      fullName: event.fullName,
      phoneNumber: event.phoneNumber,
      email: event.email,
      password: event.password,
    );

    result.fold(
      (failure) => emit(AuthenticationFailureState(message: failure.errorMessage)),
      (userCredential) => emit(AuthenticationSuccessState(user: userCredential)),
    );
    
  }

  void _login(LogInEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());

    final result = await _authenticationRepository.login(
      phoneNumber: event.phoneNumber,
      password: event.password,
    );

    result.fold(
      (failure) => emit(AuthenticationFailureState(message: failure.errorMessage)),
      (userCredential) => emit(AuthenticationSuccessState(user: userCredential)),
    );
  }
}
