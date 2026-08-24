import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_template/features/auth/domain/usecases/signup_usecase.dart';
import 'package:bloc_template/features/auth/presentation/bloc/signup/signup_event.dart';
import 'package:bloc_template/features/auth/presentation/bloc/signup/signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupUsecase signupUsecase;

  SignupBloc(this.signupUsecase) : super(SignupInitial()) {
    on<SignupSubmitted>(_onSignupSubmitted);
  }

  Future<void> _onSignupSubmitted(
      SignupSubmitted event,
      Emitter<SignupState> emit,
      ) async {
    emit(SignupLoading());

    final result = await signupUsecase(
      name: event.name,
      email: event.email,
      password: event.password,
    );

    result.fold(
          (failure) => emit(SignupFailureState(failure.message)),
          (user) => emit(SignupSuccess(user)),
    );
  }
}