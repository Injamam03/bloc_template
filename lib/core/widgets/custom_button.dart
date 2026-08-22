import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bloc_template/core/constants/app_colors.dart';
import 'package:bloc_template/core/widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;
  final double height;
  final double borderRadius;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.backgroundColor = AppColors.primary,
    this.textColor = AppColors.white,
    this.height = 50,
    this.borderRadius = 8,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      borderRadius: BorderRadius.circular(borderRadius.r),
      child: Container(
        height: height.h,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
        child: isLoading
            ? SizedBox(
          height: 20.h,
          width: 20.w,
          child: const CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
        )
            : CustomText(
          text,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}