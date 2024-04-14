import 'package:advocate_app/pages/chats/chatspage.dart';
import 'package:advocate_app/pages/language/changelanguage.dart';
import 'package:advocate_app/utils/colors.dart';
import 'package:advocate_app/utils/textStyle.dart';
import 'package:advocate_app/widgets/buttons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool showNavMenu = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
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
                          'Case Research'.tr(),
                          style: AppTextStyles.subHeadingStyle,
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

          // mesages
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(15.h),
                            decoration: ShapeDecoration(
                              color: Color.fromARGB(255, 242, 244, 247),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16.r),
                                  topRight: Radius.circular(16.r),
                                  bottomRight: Radius.circular(16.r),
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'What can I research for you?',
                                      style: GoogleFonts.poppins(
                                        color: AppColors.textMainBlack,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      '16.50 · Read',
                                      style: GoogleFonts.poppins(
                                        color: Color(0xFF0C111D),
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),


                      SizedBox(height: 15.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.all(15.h),
                            decoration: ShapeDecoration(
                              color: AppColors.mainBlueColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16.r),
                                  topRight: Radius.circular(16.r),
                                  bottomLeft: Radius.circular(16.r),
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 220.w,
                                  child: Text(
                                    'Condonation of delay by DRT or DRAT team',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  '16.50 · Read',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white.withOpacity(0.75),
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 25.h), // received message ,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width:320.w,
                            padding: EdgeInsets.all(15.h),
                            decoration: ShapeDecoration(
                              color: Color.fromARGB(255, 242, 244, 247),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16.r),
                                  topRight: Radius.circular(16.r),
                                  bottomRight: Radius.circular(16.r),
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Here is a comprehensive report on condonation of delay by DRT or DRAT teams.',
                                      style: GoogleFonts.poppins(
                                        color: AppColors.textMainBlack,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Relevant Laws',
                                            style: GoogleFonts.poppins(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),



                                        ]),
                                    SizedBox(
                                      height: 10.h,
                                    ),

                                    Text(
                                      '1. IPC Section 34 part A',
                                      style: GoogleFonts.poppins(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),

                                    Text(
                                      '2. Point 2',
                                      style: GoogleFonts.poppins(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),

                                    Text(
                                      '3. Point 3',
                                      style: GoogleFonts.poppins(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),

                                    SizedBox(height: 15,),

                                  ],
                                ),
                                SizedBox(height: 4.h),

                              ],
                            ),

                          ),
                        ],
                      ),

                      SizedBox(
                        height: 25.h,
                      ),



                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width:320.w,
                            padding: EdgeInsets.all(15.h),
                            decoration: ShapeDecoration(
                              color: Color.fromARGB(255, 242, 244, 247),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16.r),
                                  topRight: Radius.circular(16.r),
                                  bottomRight: Radius.circular(16.r),
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                      'Judgements that Support Condonation of Delay by DRT or DRAT team',
                                      style: GoogleFonts.poppins(
                                        fontSize: 18.sp,
                                        color: AppColors.textMainBlack,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),

                                    Text(
                                      '1. Navnati Case (2018) was a key judgement where Supreme Court declared that condonation of delay by DRT team can be permitted.',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14.sp,
                                        color: AppColors.textMainBlack,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: MidSizeButton(
                                          key: ValueKey('submit'),
                                          text: 'See the judgement',
                                          onTap: () {
                                          }),
                                    ),

                                    SizedBox(
                                      height: 15.h,
                                    ),

                                    Text(
                                      '2. Navnati Case (2018) was a key judgement where Supreme Court declared that condonation of delay by DRT team can be permitted.',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14.sp,
                                        color: AppColors.textMainBlack,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),

                                    SizedBox(
                                      width: 200,
                                      child: MidSizeButton(
                                          key: ValueKey('submit'),
                                          text: 'See the judgement',
                                          onTap: () {
                                           }),
                                    ),

                                    SizedBox(height: 15,),

                                  ],
                                ),
                                SizedBox(height: 4.h),

                              ],
                            ),

                          ),
                        ],
                      ),

                      SizedBox(
                        height: 25.h,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width:320.w,
                            padding: EdgeInsets.all(15.h),
                            decoration: ShapeDecoration(
                              color: Color.fromARGB(255, 242, 244, 247),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16.r),
                                  topRight: Radius.circular(16.r),
                                  bottomRight: Radius.circular(16.r),
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                      'Judgements that Oppose Condonation of Delay by DRT or DRAT team',
                                      style: GoogleFonts.poppins(
                                        fontSize: 18.sp,
                                        color: AppColors.textMainBlack,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),

                                    Text(
                                      '1. Navnati Case (2018) was a key judgement where Allahabad High Court declared that condonation of delay by DRT team can be permitted.',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14.sp,
                                        color: AppColors.textMainBlack,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: MidSizeButton(
                                          key: ValueKey('submit'),
                                          text: 'See the judgement',
                                          onTap: () {
                                          }),
                                    ),

                                    SizedBox(
                                      height: 15.h,
                                    ),

                                    Text(
                                      '2. Navnati Case (2018) was a key judgement where Allahabad High Court declared that condonation of delay by DRT team can be permitted.',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14.sp,
                                        color: AppColors.textMainBlack,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),

                                    SizedBox(
                                      width: 200,
                                      child: MidSizeButton(
                                          key: ValueKey('submit'),
                                          text: 'See the judgement',
                                          onTap: () {
                                          }),
                                    ),


                                  ],
                                ),


                              ],
                            ),

                          ),
                        ],
                      ),

                  SizedBox(
                    height: 10,
                  ),

                      Center(
                        child: SizedBox(
                          width: 230,
                          child: GreenButton(
                              key: ValueKey('submit'),
                              text: 'Export Report to Word File',
                              onTap: () {
                              }),
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      Center(
                        child: SizedBox(
                          width: 350,
                          child: M1SizeButton(
                              key: ValueKey('submit'),
                              text: 'Add more supporting judgements to report',
                              onTap: () {
                              }),
                        ),
                      ),

                      Center(
                        child: SizedBox(
                          width: 350,
                          child: M1SizeButton(
                              key: ValueKey('submit'),
                              text: 'Add more opposing judgements to report',
                              onTap: () {
                              }),
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
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
                          hintText: 'Message'.tr(),
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.black.withOpacity(0.75),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),

                    Icon(Icons.mic, color: AppColors.mainBlueColor, size: 26,),
                    SizedBox(width: 10,),
                    SvgPicture.asset(
                      "assets/icons/xend.svg",
                      height: 30.h,
                      width: 30.w,
                    ),


                  ],
                ),
              ),
              // bottom send chat button
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
                              height: 15,
                            ),
                            Divider(color: Colors.black.withOpacity(0.1)),
                            SizedBox(
                              height: 15,
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




    ));
  }
}
