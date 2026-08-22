import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_template/features/auth/domain/usecases/login_usecase.dart';
import 'package:bloc_template/features/auth/presentation/bloc/login/login_event.dart';
import 'package:bloc_template/features/auth/presentation/bloc/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase loginUsecase;

  LoginBloc(this.loginUsecase) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event,
      Emitter<LoginState> emit,
      ) async {
    emit(LoginLoading());

    final result = await loginUsecase(
      email: event.email,
      password: event.password,
    );

    result.fold(
          (failure) => emit(LoginFailureState(failure.message)),
          (user) => emit(LoginSuccess(user)),
    );
  }
}