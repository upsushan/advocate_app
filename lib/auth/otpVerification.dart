import "package:advocate_app/apis/apis.dart";
import "package:advocate_app/auth/signup.dart";
import "package:advocate_app/pages/home/homepage.dart";
import "package:advocate_app/pages/register/register.dart";
import "package:advocate_app/utils/colors.dart";
import "package:advocate_app/utils/images.dart";
import "package:advocate_app/utils/textStyle.dart";
import "package:advocate_app/widgets/buttons.dart";
import "package:advocate_app/widgets/textField.dart";
import "package:country_code_picker/country_code_picker.dart";
import "package:easy_localization/easy_localization.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:google_fonts/google_fonts.dart";
import "package:pinput/pinput.dart";
import "package:shared_preferences/shared_preferences.dart";

class OtpVerificationScreen extends StatefulWidget {
  String fcmtoken;
  String mobilenumber;
  String countrycode;
  OtpVerificationScreen({super.key,  required this.fcmtoken, required this.mobilenumber, required this.countrycode});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  String pinVal = "";
  bool loading = false;
  bool resendOTP = false;

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  TextEditingController _controller = TextEditingController();
  bool _isTextFieldEmpty = true;

  bool _yesChecked = false;
  bool _noChecked = false;

  CountryCode? _selectedCountry;

  void _checkTextFieldEmpty() {
    setState(() {
      _isTextFieldEmpty = _controller.text.isEmpty;
    });
  }

  void _clearTextField() {
    setState(() {
      _controller.clear();
      _isTextFieldEmpty = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = AppColors.mainBlueColor;
    const fillColor = Colors.transparent;
    const borderColor = Colors.transparent;


    final defaultPinTheme = PinTheme(
      width: 66.w,
      height: 66.h,
      textStyle: AppTextStyles.headingStyle,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: borderColor),
        color: Color(0xFFF5F6FF),
      ),
    );

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
                          key: ValueKey("back_button"),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),

                  // signin illustration
                  SizedBox(height: 50.h,),

                  Image.asset(
                    "assets/images/otp.png",
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
                          "OTP Verification".tr(),
                          style: AppTextStyles.headingStyle,
                        ),
                        Text(
                          "Enter the verification code we just sent to your mobile number.".tr(),
                          style: AppTextStyles.subtitleStyle,
                        )
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 20.h,
                  ),

// otp verification

                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Pinput(
                          length: 5,
                          pinAnimationType: PinAnimationType.none,
                          controller: pinController,
                          focusNode: focusNode,
                          androidSmsAutofillMethod:
                          AndroidSmsAutofillMethod.smsUserConsentApi,
                          listenForMultipleSmsOnAndroid: true,
                          defaultPinTheme: defaultPinTheme,
                          separatorBuilder: (index) => SizedBox(width: 12.w),
                          validator: (value) {
                            return value == "2222" ? null : null;
                          },
                          // onClipboardFound: (value) {
                          //   debugPrint("onClipboardFound: $value");
                          //   pinController.setText(value);
                          // },
                          hapticFeedbackType: HapticFeedbackType.lightImpact,
                          onCompleted: (pin) {
                            pinVal = pin;
                          },
                          onChanged: (value) {
                            pinVal = value;
                            debugPrint("onChanged: $value");
                          },
                          cursor: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 2.w,
                                height: 32.h,
                                color: focusedBorderColor,
                              ),
                            ],
                          ),
                          focusedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                  color: focusedBorderColor, width: 3.w),
                            ),
                          ),
                          submittedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              color: fillColor,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                  color: focusedBorderColor, width: 3.w),
                            ),
                          ),

                          errorPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: Colors.red, width: 3.w),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 25.h,
                  ),
                  //  change number



                  // login butto
                  SizedBox(
                    height: 25.h,
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

                  SizedBox(
                    height: 30.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Opacity(
                          opacity: loading ? 0.5 : 1,
                          child: GradientButton(
                              key: ValueKey( "verify"),
                              text: loading ? "Please wait..".tr(): !resendOTP ? "Verify" : "Resend OTP",
                              onTap: () async{
                                if(!resendOTP){
                                if(!loading) {
                                  if(pinVal!=""){
                                  if (pinVal.length == 5) {
                                    setState(() {
                                      loading = true;
                                    });
                                    String verificationResponse = await otpVerification(
                                        pinVal,widget.mobilenumber, widget.fcmtoken, widget.countrycode);
                                    setState(() {
                                      loading = false;
                                    });

                                    if(verificationResponse!="error") {
                                      if (verificationResponse.contains("OTP_INCORRECT")) {
                                        Fluttertoast.showToast(
                                            msg: "The OTP is incorrect. Please check carefully and try again");
                                        pinController.clear();
                                      } else if (verificationResponse.contains("SUCCESS")) {

                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                        prefs.setBool("loggedIn", true);
                                        final String todayDate = DateTime.now().toIso8601String();
                                        await prefs.setString('loggedInDate', todayDate);
                                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                                builder: (context) =>
                                                    HomePage()), (
                                            Route<dynamic> route) => false);

                                      } else if(verificationResponse.contains("OTP_TIMEOUT")) {
                                        Fluttertoast.showToast(msg: "The OTP has expired");
                                        resendOTP = true;
                                        setState(() {
                                        });

                                      }else if(verificationResponse.contains("OTP_MAX_ATTEMPTS_EXCEEDED")) {
                                        Fluttertoast.showToast(msg: "Too many OTP attempts. Login is blocked for a day.");
                                        Navigator.pop(context);
                                      }
                                    }


                                  }else{
                                    Fluttertoast.showToast(msg: "OTP needs to have 5 digits");
                                  }
                                  }else{
                                    Fluttertoast.showToast(msg: "OTP can't be empty");
                                  }
                                }
                              }else{
                                  setState(() {
                                    loading = true;
                                  });

                                bool success =   await resendOTPCode(widget.mobilenumber, widget.countrycode);
                                if(success){
                                  resendOTP = false;
                                }

                                  setState(() {
                                    loading = false;
                                  });

                                }
                                }),
                        ),

                        SizedBox(
                          height: 20.h,
                        ),
                        // new to advocate assit

                        if(!resendOTP)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Didn’t receive code? ".tr(),
                              style: GoogleFonts.poppins(
                                color: AppColors.textSecondaryBlack,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                            GestureDetector(
                              onTap: ()async {
                                await resendOTPCode(widget.mobilenumber, widget.countrycode);
                              },
                              child: Text(
                                "Resend".tr(),
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
