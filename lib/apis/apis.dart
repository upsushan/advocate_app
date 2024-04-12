import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
final dio = Dio();
String host_url = "https://helical-ranger-419111.el.r.appspot.com";

Future<bool> loginUser(String number, String countrycode, String devicenumber, String os, String fcmtoken) async {
 print("Number $number \nCountry code: $countrycode \nDevice number: $devicenumber \nOS: $os \nFCM token: $fcmtoken");

 final Map<String, dynamic> payload = {
  "countryCode": countrycode,
  "number": number, // Use the variable `number` instead of the string "number"// Use the variable `countrycode`
  "deviceInfo": {
   "deviceNumber": devicenumber, // Use the variable `devicenumber`
   "operatingSystem": os, // This is correctly using the variable `os`
   "appVersion": "1.0",
   "fcmToken": fcmtoken, // Use the variable `fcmtoken`
  }
 };

 try {
  Response response = await dio.post(
   host_url + '/user/login',
   data: payload,
   options: Options(
    headers: {
     'Content-Type': 'application/json',
    },
    validateStatus: (status) {
     return (status != null && status < 500); // Accept any status less than 500
    },
   ),
  );

  if (response.statusCode == 200) {
   print(response.headers);

   return true;
  } else {
   Fluttertoast.showToast(msg: getErrorMessage(response.data));
   return false;
  }
 } catch (e) {

  Fluttertoast.showToast(msg:"There was an issue. Please try again later.");
  return false;
 }
}



Future<bool> otpVerification(String number, String fcmToken) async {

 final Map<String, dynamic> payload = {
  "otp": number, // Use the variable `number` instead of the string "number"
 };

 try {
  Response response = await dio.post(
   host_url + '/user/otp-verification',
   data: payload,
   options: Options(
    headers: {
     'sessionToken': fcmToken,
     'Content-Type': 'application/json',
    },
    validateStatus: (status) {
     return (status != null && status < 500); // Accept any status less than 500
    },
   ),
  );

  if (response.statusCode == 200) {
   return true;
  } else {
   Fluttertoast.showToast(msg: getErrorMessage(response.data));
   return false;
  }
 } catch (e) {
  Fluttertoast.showToast(msg:"There was an issue. Please try again later.");

  return false;
 }
}



Future<bool>  signupUser(String number, String name, String countrycode, String devicenumber,String os, String fcmtoken)  async {
 print("Signup Number $number \n  Country code: $countrycode \n device number: $devicenumber \n  OS: $os \n  fcmtoken: $fcmtoken");
 final Map<String, dynamic> payload = {
  "number": number,
  "countryCode": countrycode,
  "name": name,
  "deviceInfo": {
   "deviceNumber": devicenumber,
   "operatingSystem": os,
   "appVersion": "1.0",
   "fcmToken": fcmtoken,
  }
 };

 try {
  Response response = await dio.post(
   host_url+'/user/signup',
   data: payload,
   options: Options(
    headers: {
     'Content-Type': 'application/json',
    },
    validateStatus: (status) {
     return (status != null && status < 500); // Accept any status less than 500
    },
   ),
  );

  if (response.statusCode == 200) {
   print(response.data);
   return true;
  } else {
   Fluttertoast.showToast(msg: getErrorMessage(response.data));
   return false;
  }

 }catch (e) {
  // Handle any other errors
  Fluttertoast.showToast(msg:"There was an issue. Please try again later.");
  return false;
 }
}



String getErrorMessage(dynamic val) {
 Map<String, dynamic> errorDetails = val;
 return errorDetails['error']; // ✅ Correctly returning a String
}