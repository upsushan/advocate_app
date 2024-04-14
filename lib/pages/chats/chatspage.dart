import 'package:advocate_app/pages/chats/chatscreen.dart';
import 'package:advocate_app/utils/colors.dart';
import 'package:advocate_app/utils/textStyle.dart';
import 'package:advocate_app/widgets/buttons.dart';
import 'package:advocate_app/widgets/textField.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  bool showNavMenu = false;
  List<String> _translateText = [
    'Give me the details for the most',
  ]; // Initial list of texts
// Initial list of texts
  List<String> _caseTexts = [
    'The best way to do legal work in the way of heaven',
  ]; // Initial list of texts
// Initial list of texts

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
                            'Chats'.tr(),
                            style: AppTextStyles.subHeadingStyle,
                          )
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

                SizedBox(
                  height: 25.h,
                ),
            // search
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    height: 65.h,
                    child: TextField(
                      decoration:
                          AppTextFieldStyle.textFieldStyle('Search Conversations'.tr()),
                    ),
                  ),
                ),

            // chats
                SizedBox(
                  height: 25.h,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Translate',
                        style: GoogleFonts.poppins(
                          color: AppColors.textMainBlack,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Today',
                        style: GoogleFonts.poppins(
                          color: Color(0xFF98A1B2),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
            // deletable text
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ChatScreen()));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60.h,
                    alignment: Alignment.center,
                    child: ListView.builder(
                      itemCount: _translateText.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: Key(
                              _translateText[index]), // Unique key for each item
                          direction: DismissDirection
                              .endToStart, // Swipe from right to left to delete
                          background: Container(
                            height: 40.h,
                            alignment: Alignment.centerRight,
                            color: Colors.red,
                            child: Icon(Icons.delete,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                          onDismissed: (direction) {
                            setState(() {
                              _translateText
                                  .removeAt(index); // Remove the text from the list
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 10.h),
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              _translateText[index],
                              style: GoogleFonts.poppins(
                                color: AppColors.textMainBlack,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                //

            // chats
                SizedBox(
                  height: 5.h,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Case Search',
                        style: GoogleFonts.poppins(
                          color: AppColors.textMainBlack,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Yesterday',
                        style: GoogleFonts.poppins(
                          color: Color(0xFF98A1B2),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
            // deletable text
                Container(
                  width: double.infinity,
                  height: 60.h,
                  alignment: Alignment.center,
                  child: ListView.builder(
                    itemCount: _caseTexts.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key(_caseTexts[index]), // Unique key for each item
                        direction: DismissDirection
                            .endToStart, // Swipe from right to left to delete
                        background: Container(
                          height: 40.h,
                          alignment: Alignment.centerRight,
                          color: Colors.red,
                          child: Icon(Icons.delete,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        onDismissed: (direction) {
                          setState(() {
                            _caseTexts
                                .removeAt(index); // Remove the text from the list
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 10.h),
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            _caseTexts[index],
                            style: GoogleFonts.poppins(
                              color: AppColors.textMainBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 60.h,
                  alignment: Alignment.center,
                  child: ListView.builder(
                    itemCount: _caseTexts.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key(_caseTexts[index]), // Unique key for each item
                        direction: DismissDirection
                            .endToStart, // Swipe from right to left to delete
                        background: Container(
                          height: 40.h,
                          alignment: Alignment.centerRight,
                          color: Colors.red,
                          child: Icon(Icons.delete,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        onDismissed: (direction) {
                          setState(() {
                            _caseTexts
                                .removeAt(index); // Remove the text from the list
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 10.h),
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            _caseTexts[index],
                            style: GoogleFonts.poppins(
                              color: AppColors.textMainBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                //
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
      ),
    );
  }
}
