import 'package:advocate_app/apis/apis.dart';
import 'package:advocate_app/utils/colors.dart';
import 'package:advocate_app/utils/textStyle.dart';
import 'package:advocate_app/widgets/buttons.dart';
import 'package:advocate_app/wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class ChangeLanguage extends StatefulWidget {
  const ChangeLanguage({super.key});

  @override
  State<ChangeLanguage> createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  final Uri _privacyUrl = Uri.parse('https://google.com/');
  final Uri _rateUrl = Uri.parse('https://google.com/');

  List<String> languageItems = [
    'English',
    'Hindi'.tr(),
  ];

  String? selectedLanguageItem = 'English';

  @override
  Widget build(BuildContext context) {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
      '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

// ···
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'your@example.com',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Subject',
      }),
    );

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 5.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Backbutton(
                    key: ValueKey('back_button'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    'Settings'.tr(),
                    style: AppTextStyles.subHeadingStyle,
                  )
                ],
              ),
            ),

            // seperator
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 1.h,
              decoration: BoxDecoration(
                color: Color(0xFFECECEC),
              ),
            ),

            SizedBox(
              height: 25.h,
            ),

//


            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    'Change Language'.tr(),
                    style: AppTextStyles.subHeadingStyle,
                  ),
                  SizedBox(height: 5,),
                  Container(
                    height: 65.h,
                    width: double.infinity,
                    decoration: ShapeDecoration(
                      color: Color(0xFFF9FAFB),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 1.w, color: AppColors.textSecondaryBlack),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        icon: null,
                        underline: Container(
                          height: 0, // Define the height of the underline
                        ),
                        value: selectedLanguageItem,
                        items: languageItems
                            .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: GoogleFonts.poppins(
                              color: AppColors.textMainBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ))
                            .toList(),
                        onChanged: (item)
                          {
                            Locale newLocale = item == "English" ? Locale('en', 'US') :  Locale('hi', 'IN');
                            EasyLocalization.of(context)?.setLocale(newLocale);

                            setState(() => selectedLanguageItem = item);

                          }
                      ),
                    ),
                  ),
                ],
              ),
            ),

// Share app
            SizedBox(
              height: 25.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Share the Joy!'.tr(),
                        style: AppTextStyles.subHeadingStyle,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      Share.share('check out my website https://example.com');
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/invite.svg",
                          height: 28.h,
                          color: AppColors.mainBlueColor.withOpacity(0.8),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Text(
                          'Invite Friends'.tr(),
                          style: AppTextStyles.labelStyle.copyWith(
                            fontSize: 18,
                            color: AppColors.textMainBlack.withOpacity(0.5),
                          ),
                        )
                      ],
                    ),
                  ),

                  // seperator
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: Color(0xFFECECEC),
                    ),
                  ),

// rate app

                  SizedBox(
                    height: 10.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      _launchUrlRate();
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/rate.svg",
                          height: 28.h,
                          color: AppColors.mainBlueColor.withOpacity(0.8),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Text(
                          'Rate App'.tr(),
                          style: AppTextStyles.labelStyle.copyWith(
                            fontSize: 18,

                            color: AppColors.textMainBlack.withOpacity(0.5),
                          ),
                        )
                      ],
                    ),
                  ),

                  // seperator
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: Color(0xFFECECEC),
                    ),
                  ),
                ],
              ),
            ),

//help and support
            SizedBox(
              height: 25.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Help and Support'.tr(),

                        style: AppTextStyles.subHeadingStyle,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      launchUrl(emailLaunchUri);
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/contact.svg",
                          height: 28.h,
                          color: AppColors.mainBlueColor.withOpacity(0.8),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Text(
                          'Contact Us'.tr(),
                          style: AppTextStyles.labelStyle.copyWith(
                            fontSize: 18,

                            color: AppColors.textMainBlack.withOpacity(0.5),
                          ),
                        )
                      ],
                    ),
                  ),

                  // seperator
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: Color(0xFFECECEC),
                    ),
                  ),

// rate app

                  SizedBox(
                    height: 10.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      _launchUrl();
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/privacy.svg",
                          height: 28.h,
                          color: AppColors.mainBlueColor.withOpacity(0.8),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Text(
                          'Privacy Policy'.tr(),
                          style: AppTextStyles.labelStyle.copyWith(
                            fontSize: 18,
                            color: AppColors.textMainBlack.withOpacity(0.5),
                          ),
                        )
                      ],
                    ),
                  ),

                  // seperator
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: Color(0xFFECECEC),
                    ),
                  ),
                ],
              ),
            ),

//delete acc
            SizedBox(
              height: 25.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Account Settings'.tr(),
                        style: AppTextStyles.subHeadingStyle,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      _showDeleteConfirmationDialog(context);
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/delete.svg",
                          height: 28.h,
                          color: AppColors.mainBlueColor.withOpacity(0.8),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Text(
                          'Delete Account'.tr(),
                          style: AppTextStyles.labelStyle.copyWith(
                            fontSize: 18,
                            color: AppColors.textMainBlack.withOpacity(0.5),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Delete Account?'.tr(),
            style: AppTextStyles.subHeadingStyle,
          ),
          content: Text(
            'Are you sure you want to delete your account? This action cannot be undone.'.tr(),
            style: AppTextStyles.labelStyle
                .copyWith(color: AppColors.textMainBlack.withOpacity(0.75)),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Cancel'.tr(),
                style: AppTextStyles.labelStyle.copyWith(
                  color: AppColors.textMainBlack.withOpacity(0.5),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                delete_account();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Delete'.tr(),
                style: AppTextStyles.labelStyle.copyWith(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_privacyUrl)) {
      throw Exception('Could not launch $_privacyUrl');
    }
  }

  Future<void> _launchUrlRate() async {
    if (!await launchUrl(_rateUrl)) {
      throw Exception('Could not launch $_rateUrl');
    }
  }


  delete_account()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token =  prefs.getString("sessionToken");
    if(token!=null) {
      bool loggedOut = await deleteAccount(token);
      if(loggedOut){
        prefs.remove("sessionToken");
        prefs.remove("loggedIn");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Wrapper()));
        Fluttertoast.showToast(msg: "Account Deleted Successfully");
      }else{
        Fluttertoast.showToast(msg: "Sorry, there was an issue. Please try again later.");
      }
    }
  }
}
