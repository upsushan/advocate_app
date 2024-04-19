import 'dart:io';

import 'package:advocate_app/apis/apis.dart';
import 'package:advocate_app/models/chat_class.dart';
import 'package:advocate_app/pages/chats/chat_screen.dart';
import 'package:advocate_app/pages/chats/chat_history_screen.dart';
import 'package:advocate_app/pages/language/settingsScreen.dart';
import 'package:advocate_app/pages/onboarding/onboardingscreen.dart';
import 'package:advocate_app/utils/colors.dart';
import 'package:advocate_app/utils/icons.dart';
import 'package:advocate_app/utils/textStyle.dart';
import 'package:advocate_app/widgets/buttons.dart';
import 'package:advocate_app/wrapper.dart';
import 'package:docx_template/docx_template.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/functions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showNavMenu = false;
  int _pressedCount = 0;
  bool sessionChecked = false;
  SpeechToText speechToText = SpeechToText();
  bool listening = false;
  TextEditingController controller = TextEditingController();
  bool firstText = false;
  bool response = false;
  int? chatid;

  List<dynamic> aichats = [];
  List<String> aichat_type = [];

  ScrollController _scrollController = ScrollController();

  validateSession()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token =  prefs.getString("sessionToken");
    print("Session token $token");
    if(token!=null) {
      bool session = await checkIfSessionisValid(token);
      if(!session){
        prefs.remove("sessionToken");
        prefs.remove("loggedIn");
        Fluttertoast.showToast(msg: "Login session has expired. Please log in again.");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Wrapper()));
      }else{
        chatSync();
      }
    }
  }



  @override
  void initState() {
    checkMic();
    super.initState();

  }


  void checkMic() async{
    bool micAvailable = await speechToText.initialize();

    if(micAvailable){
      print("MicroPhone Available");
    }else{
      print("User Denied the use of speech micro");
    }
  }


  Future<bool> showExitPopup(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit the app?'),
        actions: <Widget>[
          new ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    ) ?? false; // Returning false if dialog is dismissed.
  }


  @override
  Widget build(BuildContext context) {

    if(!sessionChecked) {
      validateSession();
      sessionChecked = true;
    }


    if(aichats.length>1)
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      });



    return SafeArea(
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
                      if(!firstText)
                      Text(
                        'Try our new feature!'.tr(),
                        style: GoogleFonts.poppins(
                          color: AppColors.textMainBlack,
                          fontSize: 18.sp,
                        ),
                      ),
                      if(!firstText)
                      SizedBox(
                        height: 10.h,
                      ),
                      if(!firstText)
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
                        },
                        child: SizedBox(
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
                      ),

                      if(firstText)
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              scrollDirection: Axis.vertical,
                              itemCount: aichats.length,
                              controller: _scrollController,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return Row(
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
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
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
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  ApiResponse response = aichats[index];
                                  print(response.contents.length);

                                  chatid = response.contents[index].chatId;

                                  return Column(
                                  children: [

                                  for (int i=0; i<3; i++)

                                     Column(
                                      children: [
                                       if (response.contents[i].type == "Bot Judgement List")

                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.symmetric(vertical: 4),
                                              width: 320.w,
                                              padding: EdgeInsets.all(15.h),
                                              decoration: ShapeDecoration(
                                                color: Color.fromARGB(
                                                    255, 242, 244, 247),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(16.r),
                                                    topRight: Radius.circular(16.r),
                                                    bottomRight: Radius.circular(
                                                        16.r),
                                                  ),
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment
                                                    .start,
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .end,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: [


                                                        Column(
                                                          children: [

                                                            Text(
                                                              'Judgements that Support condition of Delay by DRT or DRAT team',
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontSize: 18.sp,
                                                                color: AppColors
                                                                    .textMainBlack,
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                              ),
                                                            ),

                                                            SizedBox(
                                                              height: 10.h,
                                                            ),

                                                            for (int j = 0; j <
                                                                response.contents[i].content.length; j++)


                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                  '${j+1}. ${response.contents[i].content[j].title}. ${response.contents[i].content[j].summary}',
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                    fontSize: 14.sp,
                                                                    color: AppColors
                                                                        .textMainBlack,
                                                                    fontWeight: FontWeight
                                                                        .w400,
                                                                  ),
                                                                ),

                                                                SizedBox(
                                                                  width: 200,
                                                                  child: MidSizeButton(
                                                                    key: ValueKey(
                                                                        'submit'),
                                                                    text: 'See the judgement',
                                                                    onTap: () {
                                                                      launchURL(
                                                                          response.contents[i].content[j].url
                                                                      );
                                                                    },
                                                                  ),
                                                                ),

                                                                if(j==0)
                                                                  SizedBox(height: 10,)

                                                              ],
                                                            ),

                                                          ],
                                                        ),

                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ]
                                      ),

                                      if (response.contents[i].sender == "user" && response.contents[i].content is String)
                                         Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.symmetric(vertical: 4),
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
                                                mainAxisAlignment: MainAxisAlignment
                                                    .start,
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .end,
                                                children: [
                                                  SizedBox(
                                                    width: 220.w,
                                                    child: Text(
                                                      response.contents[i].content,
                                                      style: GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        fontSize: 14.sp,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 4.h),
                                                  Text(
                                                    formatTimestamp(
                                                        response.contents[i].timestamp) + ' Read',
                                                    style: GoogleFonts.poppins(
                                                      color: Colors.white.withOpacity(
                                                          0.75),
                                                      fontSize: 10.sp,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),

                                      if (response.contents[i].sender == "bot" && response.contents[i].content is String)
                                        Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.symmetric(vertical: 4),
                                                width: 320.w,
                                                padding: EdgeInsets.all(15.h),
                                                decoration: ShapeDecoration(
                                                  color: Color.fromARGB(
                                                      255, 242, 244, 247),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(16.r),
                                                      topRight: Radius.circular(16.r),
                                                      bottomRight: Radius.circular(
                                                          16.r),
                                                    ),
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .start,
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .end,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                          response.contents[i].content,
                                                          style: GoogleFonts.poppins(
                                                            color: AppColors
                                                                .textMainBlack,
                                                            fontSize: 16.sp,
                                                            fontWeight: FontWeight
                                                                .w400,
                                                          ),
                                                        ),
                                                        SizedBox(height: 4.h),
                                                        Text(
                                                          formatTimestamp(
                                                              response.contents[i].timestamp),
                                                          style: GoogleFonts.poppins(
                                                            color: Colors.white
                                                                .withOpacity(0.75),
                                                            fontSize: 10.sp,
                                                            fontWeight: FontWeight
                                                                .w400,
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                    SizedBox(height: 4.h),

                                                  ],
                                                ),

                                              ),


                                              SizedBox(
                                                height: 25.h,
                                              ),
                                            ]
                                        ),

                                        ],
                                        ),


                                           if(aichats.length != 0 && aichats.length -1 == index)
                                             Column(
                                               children: [
                                                 Center(
                                                   child: SizedBox(
                                                     width: 230,
                                                     child: GreenButton(
                                                         key: ValueKey('submit'),
                                                         text: 'Export Report to Word File',
                                                         onTap: ()async {
                                                               //createDocFile(aichats);
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


                                               ],
                                             )


                                            ],
                                            );
                                      }
                                    }



                          ),
                        ),

                   ],
                  ),
                ),

        SizedBox(height: 10,),
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
                  controller: controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText:   listening  ? 'Listening...' :'Take consult from your legal assistant'.tr(),
                    hintStyle: GoogleFonts.poppins(
                      color: Colors.black.withOpacity(0.75),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                  onTap:(){
                    if(!listening) {
                      controller.text = "";
                      setState(() {
                        listening = true;
                      });

                      speechToText.listen(
                          listenFor: Duration(seconds: 20),
                          onResult: (result) {
                            setState(() {
                              controller.text = result.recognizedWords;
                              listening =
                              speechToText.isListening ? true : false;
                            });
                          }
                      );
                    }else{

                      setState(() {
                        listening = false;
                        speechToText.stop();
                      });
                    }


                  },
                  child: Icon(listening ? Icons.stop_circle_rounded : Icons.mic, color: AppColors.mainBlueColor, size: 26)),
              SizedBox(width: 10),
              GestureDetector(
                onTap: ()async {
                  if(controller.text!="") {
                    if (!firstText) {
                      aichats.add(controller.text);
                      firstText = true;
                    }

                    setState(() {});
                    ApiResponse? response = await chat(firstText,chatid, "Normal", controller.text);
                    if(response!=null){
                      aichats.add(response);
                    }else{
                      Fluttertoast.showToast(msg: "Response is null");
                    }
                    controller.text = "";
                    setState(() {});
                  }

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
                                  //Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
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
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatsHistory()));
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
                             // Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
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


    Future<void> launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
    } else {
    throw 'Could not launch $url';
    }
    }





}
