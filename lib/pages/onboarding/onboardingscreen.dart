import 'package:advocate_app/auth/signin.dart';
import 'package:advocate_app/pages/home.dart';
import 'package:advocate_app/utils/colors.dart';
import 'package:advocate_app/utils/textStyle.dart';
import 'package:advocate_app/widgets/buttons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController();
  int _currentPageIndex = 0;
  int _numPages = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: List.generate(
                  _numPages,
                  (index) => _buildDotIndicator(index),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
                itemCount: _numPages,
                itemBuilder: (BuildContext context, int index) {
                  switch (index) {
                    case 0:
                      return OnboardingPage1();
                    case 1:
                      return OnboardingPage2();
                    case 2:
                      return OnboardingPage3();
                    default:
                      return Container();
                  }
                },
              ),
            ),

            //  visible: _currentPageIndex < _numPages - 1,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: GradientButton(
                key: ValueKey('Next'),
                onTap: () {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                  if (_currentPageIndex == 2)
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignInScreen()));
                },
                text: _currentPageIndex == _numPages - 1 ? 'Continue'.tr() : 'Next'.tr(),
              ),
            ),

//
            SizedBox(
              height: 20.h,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Visibility(
                visible: _currentPageIndex < _numPages - 1,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignInScreen()));
                  },
                  child: Container(
                    height: 65.h,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 1.w, color: AppColors.mainBlueColor),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Skip'.tr(),
                        style: GoogleFonts.poppins(
                          color: AppColors.mainBlueColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDotIndicator(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      width: index == _currentPageIndex ? 20.w : 10.w,
      height: 10.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1000.r),
          color: index == _currentPageIndex
              ? AppColors.mainBlueColor
              : AppColors.secondaryColor),
    );
  }
}

class OnboardingPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 80.h,
        ),
        Image.asset(
          "assets/images/onboarding1.png",
          height: 280.h,
        ),
        SizedBox(
          height: 50.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            "Empower Your Legal Journey".tr(),
            style: AppTextStyles.headingStyle,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            "Navigate the complexities of law with our advocate service app, providing expert guidance tailored to your needs.".tr(),
            style: AppTextStyles.subtitleStyle,
          ),
        )
      ],
    );
  }
}

class OnboardingPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 80.h,
        ),
        Image.asset(
          "assets/images/otp.png",
          height: 280.h,
        ),
        SizedBox(
          height: 50.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            "Empower Your Legal Journey",
            style: AppTextStyles.headingStyle,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            "Navigate the complexities of law with our advocate service app, providing expert guidance tailored to your needs.",
            style: AppTextStyles.subtitleStyle,
          ),
        )
      ],
    );
  }
}

class OnboardingPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 80.h,
        ),
        Image.asset(
          "assets/images/signup.png",
          height: 280.h,
        ),
        SizedBox(
          height: 50.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            "Empower Your Legal Journey",
            style: AppTextStyles.headingStyle,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            "Navigate the complexities of law with our advocate service app, providing expert guidance tailored to your needs.",
            style: AppTextStyles.subtitleStyle,
          ),
        )
      ],
    );
  }
}
