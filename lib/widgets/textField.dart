import 'package:advocate_app/utils/colors.dart';
import 'package:advocate_app/utils/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextFieldStyle {
  static InputDecoration textFieldStyle(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: AppTextStyles.subtitleStyle,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.mainBlueColor,
            width: 1.w,
          ),
          borderRadius: BorderRadius.circular(16.r)),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.w,
          color: AppColors.textSecondaryBlack,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      filled: true,
      fillColor: Color.fromARGB(255, 249, 250, 251),
    );
  }
}
