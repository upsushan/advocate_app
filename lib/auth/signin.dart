import 'dart:io' show Platform;

import 'package:advocate_app/apis/apis.dart';
import 'package:advocate_app/auth/otpVerification.dart';
import 'package:advocate_app/auth/signup.dart';
import 'package:advocate_app/utils/colors.dart';
import 'package:advocate_app/utils/images.dart';
import 'package:advocate_app/utils/textStyle.dart';
import 'package:advocate_app/widgets/buttons.dart';
import 'package:advocate_app/widgets/textField.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController phoneNumber = TextEditingController();
  String countryCode = "+91";
  String deviceName = "";
  late SharedPreferences prefs;
  String tokenVal = "";
  bool loggingIn = false;

  @override
  void initState() {
    super.initState();
    initializeState();
  }

  Future<void> initializeState() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      tokenVal = prefs.getString('token') ?? "null";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
            children: [
              ListView(
                children: [
                  SizedBox(
                    height: 8.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        Backbutton(
                          key: ValueKey('back_button'),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 70.h,
                  ),

                  // signin illustration

                  Image.asset(
                    'assets/images/signin.png',
                    height: 200.h,
                  ),
                  SizedBox(
                    height: 70.h,
                  ),

                  // Sign In text

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Log In'.tr(),
                          style: AppTextStyles.headingStyle,
                        ),
                        Text(
                          'Log in to continue using the app.'.tr(),
                          style: AppTextStyles.subtitleStyle,
                        )
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 25.h,
                  ),

                  // Login text field

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Container(
                        height: 65.h,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.w, color: AppColors.textSecondaryBlack),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                        ),
                        child: Row(
                          children: [
                            // CountryCodePicker widget
                            CountryCodePicker(
                              onChanged: (countryCode) {
                                setState(() {
                                  countryCode = countryCode;
                                });
                              },
                              flagDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1000.r)),
                              initialSelection: 'IN',
                              showCountryOnly: false,
                              showOnlyCountryWhenClosed: false,
                              favorite: ['+91', 'IN'],
                              textStyle: GoogleFonts.poppins(
                                color: AppColors.textMainBlack,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: phoneNumber,
                                style: GoogleFonts.poppins(
                                  color: AppColors.textMainBlack,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '93190116679'.tr(),
                                  hintStyle: GoogleFonts.poppins(
                                    color: AppColors.textSecondaryBlack,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500,
                                  ),

                                ),
                              ),
                            )
                          ],
                        )),
                  ),

                  // login butto
                  SizedBox(
                    height: 50.h,
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Opacity(
                          opacity: loggingIn ? 0.5 : 1,
                          child: GradientButton(
                              key: ValueKey('login'), text: loggingIn ? 'Please wait..'.tr() : 'Log In'.tr(), onTap: () async{
                            if(!loggingIn ) {
                              if(phoneNumber.text!="") {
                                if(phoneNumber.length==10) {
                                  if (tokenVal == "null") {
                                    tokenVal = (await FirebaseMessaging.instance
                                        .getToken())!;
                                  }
                                  String OS = Platform.isIOS
                                      ? "IOS"
                                      : "Android";
                                  String deviceName = "";
                                  if (Platform.isAndroid) {
                                    var androidInfo = await DeviceInfoPlugin()
                                        .androidInfo;
                                    deviceName =
                                    "${androidInfo.manufacturer} ${androidInfo
                                        .model}";
                                  } else if (Platform.isIOS) {
                                    var iosInfo = await DeviceInfoPlugin()
                                        .iosInfo;
                                    deviceName =
                                    "${iosInfo.utsname.sysname} ${iosInfo
                                        .systemVersion} ${iosInfo.name}";
                                  }

                                  setState(() {
                                    loggingIn = true;
                                  });
                                  bool success = await loginUser(
                                      phoneNumber.text, countryCode, deviceName,
                                      OS,
                                      tokenVal);
                                  setState(() {
                                    loggingIn = false;
                                  });
                                  if (success) {
                                    phoneNumber.text = "";
                                    setState(() {});

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            OtpVerificationScreen(
                                                fcmtoken: tokenVal),
                                      ),
                                    );
                                  }
                                }else{
                                  Fluttertoast.showToast(msg: "The number needs to have 10 digits, please enter again");
                                }
                              }else{
                                Fluttertoast.showToast(msg: "Please enter number to login");
                              }
                            }
                          }),
                        ),

                        SizedBox(
                          height: 20.h,
                        ),
                        // new to advocate assit

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'New to advocate assist? '.tr(),
                              style: GoogleFonts.poppins(
                                color: AppColors.textSecondaryBlack,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Sign Up'.tr(),
                                style: GoogleFonts.poppins(
                                  color: AppColors.mainBlueColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
