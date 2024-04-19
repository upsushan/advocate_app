

import 'dart:io';

import 'package:advocate_app/apis/apis.dart';
import 'package:advocate_app/models/chat_class.dart' as chat;
import 'package:advocate_app/utils/colors.dart';
import 'package:advocate_app/utils/textStyle.dart';
import 'package:advocate_app/wrapper.dart';
import 'package:docx_template/docx_template.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

String formatTimestamp(String timestampString) {
  // Parse the timestamp string into a DateTime object
  DateTime timestamp = DateTime.parse(timestampString);

  // Format the DateTime object to a time string "HH:mm"
  String formattedTime = DateFormat().add_Hm().format(timestamp);

  // Return the formatted time with "Read" appended
  return '$formattedTime';
}


String formatTimestampNow(String timestampString) {
  DateTime timestamp = DateTime.parse(timestampString);
  DateTime now = DateTime.now();
  DateFormat formatter;

  // Check if the timestamp is today
  if (timestamp.year == now.year && timestamp.month == now.month && timestamp.day == now.day) {
    // If the date is today, format it as "Today, HH:mm a"
    formatter = DateFormat('\'Today, \' hh:mm a');
  } else {
    // Otherwise, use a more general date format, e.g., "MMM dd, yyyy, HH:mm a"
    formatter = DateFormat('MMM dd, yyyy, hh:mm a');
  }

  // Format the DateTime object according to the formatter
  String formattedTime = formatter.format(timestamp);

  return formattedTime;
}


Future<void> launchURL(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}


void showLogoutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,

        content: Text(
          'Are you sure you want to sign out?'.tr(),
          style: AppTextStyles.labelStyle
              .copyWith(color: AppColors.textMainBlack.withOpacity(0.75)),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text(
              'No'.tr(),
              style: AppTextStyles.labelStyle.copyWith(
                color: AppColors.textMainBlack.withOpacity(0.5),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async{
              sessionLogout(context);
            },
            child: Text(
              'Sign out'.tr(),
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

sessionLogout(BuildContext context)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token =  prefs.getString("sessionToken");
  if(token!=null) {
    bool loggedOut = await logoutFromSession(token);
    if(loggedOut){
      prefs.remove("sessionToken");
      prefs.remove("loggedIn");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Wrapper()));
      Fluttertoast.showToast(msg: "Signed out successfully");
    }else{
      Fluttertoast.showToast(msg: "Sorry, there was an issue. Please try again later.");
    }
  }
}

void createDocFile(List<dynamic> aichats)async{
  for(int l=1; l<aichats.length; l++) {
    chat.ApiResponse response = aichats[l];

    final f = File("template.docx");
    final data = await rootBundle.load('assets/translation/users.docx');
    final bytes = data.buffer.asUint8List();

    final docx = await DocxTemplate.fromBytes(bytes);


    Content c = Content();

    // for (int i=0; i<3; i++){
    //   if (response.contents[i].type == "Bot Judgement List"){
    //
    //     for (int j = 0; j <
    //         response.contents[i].content.length; j++) {
    //       c..add(TextContent("",
    //           "${j + 1}. ${response.contents[i].content[j].title}. ${response
    //               .contents[i].content[j].summary}"));
    //       c..add(TextContent("Url", "${response.contents[i].content[j].url}"));
    //     }
    //   }
    // }

    c..add(TextContent("", "'Judgements that Support condition of Delay by DRT or DRAT team'"));

    Directory generalDownloadDir = Directory('/storage/emulated/0/Download');
    String timeNow = DateFormat("dMMM-hhass").format(DateTime.now());

    File qrJpg = await File('${generalDownloadDir.path}/$timeNow.pdf').create();

    final doc = await docx.generate(c);

    final file = File('${generalDownloadDir.path}/$timeNow.docx');
    await file.writeAsBytes(doc!);
    print('Document saved to ${file.path}');

  }
}