import 'package:advocate_app/apis/apis.dart';
import 'package:advocate_app/models/chat_class.dart';
import 'package:advocate_app/models/chat_history.dart';
import 'package:advocate_app/pages/chats/chat_history_screen.dart';
import 'package:advocate_app/pages/home/homepage.dart';
import 'package:advocate_app/utils/colors.dart';
import 'package:advocate_app/utils/functions.dart';
import 'package:advocate_app/utils/textStyle.dart';
import 'package:advocate_app/widgets/buttons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends StatefulWidget {
  final List<Chat>? data;
  const ChatScreen({super.key,  this.data});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late List<Chat>? chatList;
  bool showNavMenu = false;
  ScrollController _scrollController = ScrollController();

  SpeechToText speechToText = SpeechToText();
  bool listening = false;
  TextEditingController controller = TextEditingController();
  int? chatId;

  @override
  void initState() {
    if(widget.data!=null) {
      chatList = widget.data;
    }else{
      chatList = [];
    }
    super.initState();
  }

  init()async{
     await speechToText.initialize();
  }

  @override
  Widget build(BuildContext context) {

    if(chatList!=null && chatList!.length>1)
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
                  child: Column(
                    children: [


                      if(chatList!=null)
                      Expanded(
                        child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            scrollDirection: Axis.vertical,
                            itemCount: chatList!.length,
                            controller: _scrollController,
                            itemBuilder: (context, index) {

                                Chat response = chatList![index];
                                chatId = response.chatId;

                                return Column(
                                  children: [

                                    if(index == 0)
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        width: 250,
                                        padding: EdgeInsets.all(15.h),
                                        margin: EdgeInsets.symmetric(vertical: 4),
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
                                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                    ),


                                      Column(
                                        children: [
                                          if (response.type == "Bot Judgement List")
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
                                                                    response.content.length; j++)


                                                                  Column(
                                                                    crossAxisAlignment: CrossAxisAlignment
                                                                        .start,
                                                                    children: [
                                                                      Text(
                                                                        '${j+1}. ${response.content[j].title}. ${response.content[j].summary}',
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
                                                                            print(response.content[j].url.toString());
                                                                            launchURL(
                                                                                response.content[j].url
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

                                          if (response.sender == "user" && response.content is String)
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
                                                          response.content,
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
                                                            response.timestamp) + ' Read',
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

                                          if (response.sender == "bot" && response.content is String)
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
                                                              response.content,
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
                                                                  response.timestamp),
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


                                    if(chatList!.length != 0 && chatList!.length -1 == index)
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




                        ),
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
                    SizedBox(width: 10,),
                    GestureDetector(
                      onTap: ()async{
                        ApiResponse? response = await chat(false,chatId, "Normal", controller.text);
                        if(response!=null){
                           chatList!.addAll(response.contents);
                        }else{
                          Fluttertoast.showToast(msg: "Response is null");
                        }
                        controller.text = "";
                        setState(() {});
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
