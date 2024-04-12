import 'package:advocate_app/utils/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const GradientButton(
      {required Key key, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 65.h,
          alignment: Alignment.center,
          decoration: ShapeDecoration(
            gradient: LinearGradient(
              begin: Alignment(1.00, -0.04),
              end: Alignment(-1, 0.04),
              colors: [Color(0xFF1B32B8), Color(0xFF1A5BFF)],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          child: Text(
            text,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          )),
    );
  }
}

//medium button

class MidSizeButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const MidSizeButton(
      {required Key key, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 40.h,
          margin: EdgeInsets.symmetric(vertical: 5),
          alignment: Alignment.center,
          decoration: ShapeDecoration(
            gradient: LinearGradient(
              begin: Alignment(1.00, -0.04),
              end: Alignment(-1, 0.04),
              colors: [Color(0xFF1B32B8), Color(0xFF1A5BFF)],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          child: Text(
            text,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          )),
    );
  }
}


class M1SizeButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const M1SizeButton(
      {required Key key, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 40.h,
          margin: EdgeInsets.symmetric(vertical: 5),
          alignment: Alignment.center,
          decoration: ShapeDecoration(
            gradient: LinearGradient(
              begin: Alignment(1.00, -0.04),
              end: Alignment(-1, 0.04),
              colors: [Color(0xFF3C228A), Color(0xFF211AE3)],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          child: Text(
            text,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          )),
    );
  }
}


class GreenButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const GreenButton(
      {required Key key, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 48.h,
          margin: EdgeInsets.symmetric(vertical: 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.green,  // Set border color
              width: 2.0,          // Set border width
            ),
            borderRadius: BorderRadius.circular(8.0),  // Set border radius
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.file_open_rounded,color: Colors.black.withOpacity(0.7)),
              SizedBox(width: 5,),
              Text(
                text,
                style: GoogleFonts.poppins(
                  color: Colors.black.withOpacity(0.7),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
            ],
          )),
    );
  }
}

// back button

class Backbutton extends StatelessWidget {
  final VoidCallback onTap;

  const Backbutton({required Key key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 45.w,
        height: 45.h,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1.w, color: AppColors.secondaryColor),
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: SvgPicture.asset(
          AppIcons.back,
          color: AppColors.textMainBlack,
          width: 35.w,
          height: 35.h,
        ),
      ),
    );
  }
}
