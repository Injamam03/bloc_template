import 'package:dartz/dartz.dart';
import 'package:bloc_template/core/error/failure.dart';
import 'package:bloc_template/features/auth/domain/entities/user_entity.dart';
import 'package:bloc_template/features/auth/domain/repositories/auth_repository.dart';

class SignupUseCase {
  final AuthRepository repository;

  SignupUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call({
    required String name,
    required String email,
    required String password,
    required String countryName,

  }) {
    return repository.signup(name: name, email: email, password: password,countryName:countryName);
  }
}