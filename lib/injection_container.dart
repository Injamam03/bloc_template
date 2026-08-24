import 'package:get_it/get_it.dart';

import 'package:bloc_template/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:bloc_template/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:bloc_template/features/auth/domain/repositories/auth_repository.dart';
import 'package:bloc_template/features/auth/domain/usecases/login_usecase.dart';
import 'package:bloc_template/features/auth/domain/usecases/signup_usecase.dart';
import 'package:bloc_template/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:bloc_template/features/auth/presentation/bloc/signup/signup_bloc.dart'; // 👈 এই import আছে তো?

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // ---------------- Bloc ----------------
  sl.registerFactory(() => LoginBloc(sl()));
  sl.registerFactory(() => SignupBloc(sl()));

  // ---------------- Usecases ----------------
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => SignupUseCase(sl()));

  // ---------------- Repository ----------------
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  // ---------------- Data Source ----------------
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(),
  );
}