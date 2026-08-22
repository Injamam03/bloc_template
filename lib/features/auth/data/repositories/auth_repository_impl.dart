import 'package:dartz/dartz.dart';
import 'package:bloc_template/core/error/failure.dart';
import 'package:bloc_template/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:bloc_template/features/auth/domain/entities/user_entity.dart';
import 'package:bloc_template/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await remoteDataSource.login(
        email: email,
        password: password,
      );
      return Right(result); // success হলে Right এ UserModel (যেটা UserEntity ও বটে)
    } catch (e) {
      return Left(ServerFailure(e.toString())); // fail হলে Left এ Failure
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final result = await remoteDataSource.signup(
        name: name,
        email: email,
        password: password,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}