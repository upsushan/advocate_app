import 'package:advocate_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle headingStyle = GoogleFonts.poppins(
    color: AppColors.textMainBlack,
    fontSize: 28,
    fontWeight: FontWeight.w600,
  );

  static TextStyle subHeadingStyle = GoogleFonts.poppins(
    color: AppColors.textMainBlack,
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static TextStyle tileHeading = GoogleFonts.poppins(
    color: AppColors.textMainBlack,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static TextStyle tileSubtitle = GoogleFonts.poppins(
    color: Colors.black.withOpacity(0.75),
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static TextStyle subtitleStyle = GoogleFonts.poppins(
    color: AppColors.textSecondaryBlack,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static TextStyle labelStyle = GoogleFonts.poppins(
    color: AppColors.textMainBlack,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
  // You can define more text styles as needed
}
