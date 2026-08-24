import 'package:flutter/material.dart';
import 'package:bloc_template/config/routes/app_routes.dart';
import 'package:bloc_template/features/auth/presentation/screens/login_screen.dart';

import '../../features/auth/presentation/screens/signup_screen.dart';

class AppPages {
  AppPages._();

  static Map<String, WidgetBuilder> routes = {
    AppRoutes.login: (context) => const LoginScreen(),
    AppRoutes.signup: (context) => const SignupScreen(),


  };
}