import 'package:bloc_template/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<UserModel> signup({
    required String name,
    required String email,
    required String password,
    required String countryName,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // পরে এখানে Dio instance বসবে, যেমন:
  // final Dio dio;
  // AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    // 🔧 TODO: এখানে পরে আসল Dio API call বসবে
    await Future.delayed(const Duration(seconds: 2)); // fake network delay

    // Dummy success response (পরে বাদ যাবে)
    return UserModel(
      id: "1",
      name: "Test User",
      email: email,
      token: "dummy_token_123",
    );
  }

  @override
  Future<UserModel> signup({
    required String name,
    required String email,
    required String password,
    required String countryName,

  }) async {
    // 🔧 TODO: এখানে পরে আসল Dio API call বসবে
    await Future.delayed(const Duration(seconds: 2));

    return UserModel(
      id: "1",
      name: name,
      email: email,
      token: "dummy_token_123",
    );
  }
}