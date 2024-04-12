import 'package:advocate_app/pages/chats/chatscreen.dart';
import 'package:advocate_app/pages/chats/chatspage.dart';
import 'package:advocate_app/pages/language/changelanguage.dart';
import 'package:advocate_app/pages/onboarding/onboardingscreen.dart';
import 'package:advocate_app/utils/colors.dart';
import 'package:advocate_app/utils/icons.dart';
import 'package:advocate_app/utils/textStyle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showNavMenu = false;
  int _pressedCount = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          if (_pressedCount == 1) {
            return true;
          } else {
            Fluttertoast.showToast(msg: "Press back again to exit app");
            _pressedCount++;
            await Future.delayed(Duration(seconds: 2));
            _pressedCount = 0;
            return false;
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 60.h,
                              width: 60.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1000.r),
                                image: DecorationImage(
                                  image: AssetImage('assets/images/logo.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              showNavMenu = true;
                            });
                          },
                          child: Container(child: Icon(Icons.menu_rounded, size: 30)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  //  notification ticker

                  // tap to chat
                  SizedBox(
                    height: 25.h,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Try our new feature!'.tr(),
                          style: GoogleFonts.poppins(
                            color: AppColors.textMainBlack,
                            fontSize: 18.sp,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 240.h,
                          child: InnerShadow(
                            shadows: [
                              Shadow(
                                color: Color.fromARGB(255, 150, 188, 255),
                                blurRadius: 20.h,
                                offset: Offset(-1.w, -5.h),
                              )
                            ],
                            child: Center(
                              child: Container(
                                height: 240.h,
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.r),
                                  color: const Color.fromARGB(255, 255, 255, 255),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/icons/case.png",
                                        height: 55.h,
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        'Case Research'.tr(),
                                        style: GoogleFonts.poppins(
                                          color: AppColors.textMainBlack,
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        width: 200.w,
                                        child: Text(
                                          'For Lawyers to search laws and judgements related to a case'.tr(),
                                          style: GoogleFonts.poppins(
                                            color: AppColors.textMainBlack,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // explore
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                          height: 65.h,
                          decoration: ShapeDecoration(
                            color: Color(0xFFF2F4F7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 278.w,
                                height: 65.h,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Take consult from your legal assistant'.tr(),
                                    hintStyle: GoogleFonts.poppins(
                                      color: Colors.black.withOpacity(0.75),
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              Icon(Icons.mic, color: AppColors.mainBlueColor, size: 26),
                              SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
                                },
                                child: SvgPicture.asset(
                                  "assets/icons/xend.svg",
                                  height: 30.h,
                                  width: 30.w,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (showNavMenu)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showNavMenu = false;
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black.withOpacity(0.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            width: 250,
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            color: Colors.white,
                            child: (Column(
                              children: [
                                SizedBox(
                                  height: 40,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.chat_bubble_rounded, size: 35, color: AppColors.mainBlueColor.withOpacity(0.8)),
                                      SizedBox(width: 8),
                                      Text(
                                        "New Chat".tr(),
                                        style: GoogleFonts.poppins(
                                          fontSize: 20.sp,
                                          color: AppColors.textMainBlack.withOpacity(0.6),
                                          fontWeight: FontWeight.w800,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatsPage()));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.chat_rounded, size: 35, color: AppColors.mainBlueColor.withOpacity(0.8)),
                                      SizedBox(width: 8),
                                      Text(
                                        "Chat History".tr(),
                                        style: GoogleFonts.poppins(
                                          fontSize: 20.sp,
                                          color: AppColors.textMainBlack.withOpacity(0.6),
                                          fontWeight: FontWeight.w800,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Divider(color: Colors.black.withOpacity(0.1)),
                                SizedBox(
                                  height: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeLanguage()));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.settings, size: 35, color: AppColors.mainBlueColor.withOpacity(0.8)),
                                      SizedBox(width: 8),
                                      Text(
                                        "Settings".tr(),
                                        style: GoogleFonts.poppins(
                                          fontSize: 20.sp,
                                          color: AppColors.textMainBlack.withOpacity(0.6),
                                          fontWeight: FontWeight.w800,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Divider(color: Colors.black.withOpacity(0.1)),
                                SizedBox(
                                  height: 15,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    prefs.setBool('loggedin', false);
                                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => OnboardingScreen()), (Route<dynamic> route) => false);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.logout, size: 35, color: AppColors.mainBlueColor.withOpacity(0.8)),
                                      SizedBox(width: 8),
                                      Text(
                                        "Sign Out".tr(),
                                        style: GoogleFonts.poppins(
                                          fontSize: 20.sp,
                                          color: AppColors.textMainBlack.withOpacity(0.6),
                                          fontWeight: FontWeight.w800,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Divider(color: Colors.black.withOpacity(0.1)),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> popUp(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: SizedBox(
            height: 300.h,
            width: 400.w,
            child: InnerShadow(
              shadows: [
                Shadow(
                  color: Color.fromARGB(255, 150, 188, 255),
                  blurRadius: 20.h,
                  offset: Offset(-1.w, -5.h),
                )
              ],
              child: Center(
                child: Container(
                  height: 300.h,
                  width: 400.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.r),
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                "assets/icons/translate.png",
                                height: 35.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: SvgPicture.asset(
                                  "assets/icons/close.svg",
                                  height: 24.h,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            children: [
                              Text(
                                'Translate'.tr(),
                                style: AppTextStyles.tileHeading,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Translate legal documents with\nTranslate legal documents\nwith ',
                                  style: AppTextStyles.tileSubtitle,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
