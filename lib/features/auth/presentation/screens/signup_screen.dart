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
import 'package:bloc_template/features/auth/presentation/bloc/signup/signup_bloc.dart';
import 'package:bloc_template/features/auth/presentation/bloc/signup/signup_event.dart';
import 'package:bloc_template/features/auth/presentation/bloc/signup/signup_state.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SignupBloc>(),
      child: const _SignupView(),
    );
  }
}

class _SignupView extends StatefulWidget {
  const _SignupView();

  @override
  State<_SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<_SignupView> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final countryNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    countryNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<SignupBloc, SignupState>(
          listener: (context, state) {
            if (state is SignupSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Welcome ${state.user.name}")),
              );
              // 🔧 TODO: পরে Navigator দিয়ে Home Screen এ যাবে
            } else if (state is SignupFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.error,
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is SignupLoading;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(height: 60.h,),

                    CustomText(
                      AppStrings.signup,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),

                    Gap(height:8.h),

                    CustomText(
                      "Create an account to get started",
                      fontSize: 14,
                      color: AppColors.grey,
                    ),

                    Gap(height:40.h),

                    CustomText("Name", fontSize: 14, fontWeight: FontWeight.w500),
                    Gap(height:8.h),
                    CustomTextField(
                      controller: nameController,
                      hintText: AppStrings.enterYourName,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Name is required";
                        }
                        return null;
                      },
                    ),

                    Gap(height:20.h),

                    CustomText(AppStrings.email, fontSize: 14, fontWeight: FontWeight.w500),
                    Gap(height:8.h),
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

                    Gap(height:20.h),

                    CustomText(AppStrings.password, fontSize: 14, fontWeight: FontWeight.w500),
                    Gap(height:8.h),
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
                    Gap(height: 20,),
                    CustomTextField(
                        controller: countryNameController,
                        hintText: "Enter your Country Name"),

                    Gap(height:40.h),

                    CustomButton(
                      text: AppStrings.signup,
                      isLoading: isLoading,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          context.read<SignupBloc>().add(
                            SignupSubmitted(
                              name: nameController.text.trim(),
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              countryName : countryNameController.text.trim(),
                            ),
                          );
                        }
                      },
                    ),

                    Gap(height:20.h),

                    Center(
                      child: CustomText(
                        "${AppStrings.alreadyHaveAccount} ${AppStrings.login}",
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