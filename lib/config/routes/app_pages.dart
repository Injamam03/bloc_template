import 'package:flutter/material.dart';
import 'package:bloc_template/config/routes/app_routes.dart';
import 'package:bloc_template/features/auth/presentation/screens/login_screen.dart';

class AppPages {
  AppPages._();

  static Map<String, WidgetBuilder> routes = {
    AppRoutes.login: (context) => const LoginScreen(),


  };
}