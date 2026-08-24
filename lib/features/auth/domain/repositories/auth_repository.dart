import 'package:dartz/dartz.dart';
import 'package:bloc_template/core/error/failure.dart';
import 'package:bloc_template/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> signup({
    required String name,
    required String email,
    required String password,
    required String countryName,
  });
}