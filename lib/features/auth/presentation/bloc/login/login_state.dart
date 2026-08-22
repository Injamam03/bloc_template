import 'package:equatable/equatable.dart';
import 'package:bloc_template/features/auth/domain/entities/user_entity.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final UserEntity user;

  const LoginSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class LoginFailureState extends LoginState {
  final String message;

  const LoginFailureState(this.message);

  @override
  List<Object?> get props => [message];
}