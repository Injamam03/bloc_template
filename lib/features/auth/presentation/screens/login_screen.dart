import 'package:bloc_template/core/utils/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'package:bloc_template/core/constants/app_colors.dart';
import 'package:bloc_template/core/constants/app_strings.dart';
import 'package:bloc_template/core/widgets/custom_text.dart';
import 'package:bloc_template/core/widgets/custom_text_field.dart';
import 'package:bloc_template/core/widgets/custom_button.dart';
import 'package:bloc_template/injection_container.dart';
import 'package:bloc_template/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:bloc_template/features/auth/presentation/bloc/login/login_event.dart';
import 'package:bloc_template/features/auth/presentation/bloc/login/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginBloc>(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Welcome ${state.user.name}")),
              );
              // 🔧 TODO: এখানে পরে Navigator দিয়ে Home Screen এ যাবে
            } else if (state is LoginFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.error,
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is LoginLoading;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(height: 60.h),

                    CustomText(
                      AppStrings.login,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),

                    Gap(height: 20.h),

                    CustomText(
                      "Welcome back, please login to continue",
                      fontSize: 14,
                      color: AppColors.grey,
                    ),

                    Gap(height: 40.h),

                    CustomText(
                      AppStrings.email,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    Gap(height: 8.h),
                    CustomTextField(
                      controller: emailController,
                      hintText: "Enter your email",
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email is required";
                        }
                        return null;
                      },
                    ),

                    Gap(height: 20.h),

                    CustomText(
                      AppStrings.password,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    Gap(height: 8.h),
                    CustomTextField(
                      controller: passwordController,
                      hintText: "Enter your password",
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        }
                        return null;
                      },
                    ),

                    Gap(height: 40.h),

                    CustomButton(
                      text: AppStrings.login,
                      isLoading: isLoading,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          context.read<LoginBloc>().add(
                            LoginSubmitted(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            ),
                          );
                        }
                      },
                    ),

                    Gap(height:20.h),

                    Center(
                      child: CustomText(
                        "${AppStrings.dontHaveAccount} ${AppStrings.signup}",
                        fontSize: 14,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}