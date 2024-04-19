import 'dart:io';

import 'package:advocate_app/apis/apis.dart';
import 'package:advocate_app/auth/otpVerification.dart';
import 'package:advocate_app/auth/signin.dart';
import 'package:advocate_app/pages/register/register.dart';
import 'package:advocate_app/utils/colors.dart';
import 'package:advocate_app/utils/images.dart';
import 'package:advocate_app/utils/textStyle.dart';
import 'package:advocate_app/widgets/buttons.dart';
import 'package:advocate_app/widgets/textField.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController name = TextEditingController();
  String countryCode = "+91";
  String deviceName = "";
  late SharedPreferences prefs;
  String tokenVal = "";
  bool loading = false;
  bool _yesChecked = false;
  bool _noChecked = false;

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
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),

                // signin illustration

                Image.asset(
                  'assets/images/signup.png',
                  height: 200.h,
                ),
                SizedBox(
                  height: 30.h,
                ),

                // Sign In text

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign Up'.tr(),
                        style: AppTextStyles.headingStyle,
                      ),
                      Text(
                        'Enter your information.'.tr(),
                        style: AppTextStyles.subtitleStyle,
                      )
                    ],
                  ),
                ),

                SizedBox(
                  height: 25.h,
                ),

                // Login text field

                // name

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name'.tr(),
                        style: AppTextStyles.labelStyle,
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Container(
                        height: 65.h,
                        alignment: Alignment.center,
                        child: TextField(
                          controller: name,
                          decoration: AppTextFieldStyle.textFieldStyle('Enter your name'.tr()),
                        ),
                      )
                    ],
                  ),
                ),

                SizedBox(
                  height: 25.h,
                ),

                // mobile number

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    height: 65.h,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1.w, color: AppColors.textSecondaryBlack),
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
                            borderRadius: BorderRadius.circular(1000.r),
                          ),
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
                        ),
                      ],
                    ),
                  ),
                ),

                // login butto
                SizedBox(
                  height: 35.h,
                ),

// Are you a lawyer

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Text("Are you a lawyer?".tr(), style: AppTextStyles.labelStyle)
                    ],
                  ),
                ),

                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),

                    child: Row(

                      children: [
                        Checkbox(
                          value: _yesChecked,
                          onChanged: (value) {
                            setState(() {
                              _yesChecked = value!;
                              if (value) {
                                _noChecked = false;
                              }
                            });
                          },
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6).r),
                          activeColor: AppColors.mainBlueColor,
                          checkColor: Colors.white,
                          side: BorderSide(
                            color: AppColors.textSecondaryBlack,
                            width: 1.w,
                            strokeAlign: BorderSide.strokeAlignInside,
                          ),
                        ),
                        Text(
                          "Yes".tr(),
                          style: GoogleFonts.poppins(
                            color: Color(0xFF1D2939),
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: _noChecked,
                              onChanged: (value) {
                                setState(() {
                                  _noChecked = value!;
                                  if (value) {
                                    _yesChecked = false;
                                  }
                                });
                              },
                              materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6).r),
                              activeColor: AppColors.mainBlueColor,
                              checkColor: Colors.white,
                              side: BorderSide(
                                color: AppColors.textSecondaryBlack,
                                width: 1.w,
                                strokeAlign: BorderSide.strokeAlignInside,
                              ),
                            ),
                            Text(
                              "No".tr(),
                              style: GoogleFonts.poppins(
                                color: Color(0xFF1D2939),
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),



                // login button
                SizedBox(
                  height: 20.h,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Opacity(
                        opacity: loading ? 0.5 : 1,
                        child: GradientButton(
                          key: ValueKey('signup'),
                          text: loading ? "Please wait..".tr() : 'Sign Up'.tr(),
                          onTap: () async {
                            if (!loading) {
                              if (phoneNumber.text != "" && name.text != "") {
                                if(phoneNumber.text.length==10) {
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
                                    loading = true;
                                  });
                                  bool success = await signupUser(
                                    phoneNumber.text,
                                    name.text,
                                    countryCode,
                                    deviceName,
                                    OS,
                                    tokenVal,
                                  );

                                  setState(() {
                                    loading = false;
                                  });

                                  if (success) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            OtpVerificationScreen(
                                              fcmtoken: tokenVal,
                                              mobilenumber: phoneNumber.text,
                                              countrycode: countryCode,),
                                      ),
                                    );
                                  }
                                }else{
                                  Fluttertoast.showToast(msg: "The number needs to have 10 digits, please enter again.");
                                }
                              } else {
                                Fluttertoast.showToast(msg: "Name / Number can't be empty");
                              }
                            }
                          },
                        ),
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
                                  builder: (context) => SignInScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Log In'.tr(),
                              style: GoogleFonts.poppins(
                                color: AppColors.mainBlueColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
