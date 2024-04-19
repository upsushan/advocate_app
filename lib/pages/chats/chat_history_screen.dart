import 'dart:convert';

import 'package:advocate_app/apis/apis.dart';
import 'package:advocate_app/models/chat_history.dart';
import 'package:advocate_app/pages/chats/chat_screen.dart';
import 'package:advocate_app/pages/home/homepage.dart';
import 'package:advocate_app/pages/language/settingsScreen.dart';
import 'package:advocate_app/utils/colors.dart';
import 'package:advocate_app/utils/functions.dart';
import 'package:advocate_app/utils/textStyle.dart';
import 'package:advocate_app/widgets/buttons.dart';
import 'package:advocate_app/widgets/textField.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatsHistory extends StatefulWidget {
  const ChatsHistory({super.key});

  @override
  State<ChatsHistory> createState() => _ChatsHistoryState();
}

class _ChatsHistoryState extends State<ChatsHistory> {
  bool showNavMenu = false;
  List<String> _translateText = [
    'Give me the details for the most',
  ]; // Initial list of texts
// Initial list of texts
  List<String> _caseTexts = [
    'The best way to do legal work in the way of heaven',
  ]; // Initial list of texts
// Initial list of texts
  List<dynamic>? result;
  List<dynamic>? result_copy;
  List<dynamic>? search = [];
  TextEditingController controller = new TextEditingController();


  @override
  void initState() {
    getJson();
    controller.addListener((){
      if(controller.text.length>0){
        search!.clear();
        for(int i=0; i< result_copy!.length; i++){
          if(result_copy![i].toString().toLowerCase().contains(controller.text.toLowerCase())){
            search!.add(result_copy![i]);
          }
        }
        result = search;
      }else{
        result = result_copy;
      }
      setState(() {

      });
    });
    super.initState();
  }

  getJson()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String val= await prefs.getString('chat-history') ?? "";

    decode(val);

    bool synced = await chatSync();
    if(synced){
      String val= await prefs.getString('chat-history') ?? "";
      decode(val);
    }
  }

   decode(final val){
    Map<String, dynamic> decodedJson = jsonDecode(val);
    result = decodedJson['chatList']
        .map((list) => jsonEncode(list))
        .toList();


    final reversedList = List.from(result!.reversed);
    result = reversedList;
    result_copy = result;

    setState(() {});
  }

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
                      controller:  controller,
                      decoration:
                          AppTextFieldStyle.textFieldStyle('Search Conversations'.tr()),
                    ),
                  ),
                ),

            // chats
                SizedBox(
                  height: 25.h,
                ),


    if(result!=null)
    Expanded(
    child: ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: result!.length,
    itemBuilder: (context, index) {
      List<dynamic> chatJson = jsonDecode(result![index]);
      List<Chat> chats = chatJson.map((json) => Chat.fromJson(json)).toList();

      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Case Research',
                  style: GoogleFonts.poppins(
                    color: AppColors.textMainBlack,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  formatTimestampNow(
                      chats[0].timestamp),
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
                  MaterialPageRoute(builder: (context) => ChatScreen(data: chats)));
            },
            child: Container(
              width: double.infinity,
              height: 60.h,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
              alignment: Alignment.center,
              child: ListView.builder(
                itemCount: _translateText.length,
                itemBuilder: (context, index) {
                  return Text(
                    overflow: TextOverflow.ellipsis,
                    chats[0].content.toString(),
                    style: GoogleFonts.poppins(
                      color: AppColors.textMainBlack,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  );
                },
              ),
            ),
          ),


        ],
      );

      //
    }
    )
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
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
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
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => settingsScreen()));
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
                                  showLogoutConfirmationDialog(context);
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
    );
  }
}
