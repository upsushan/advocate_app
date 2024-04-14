import 'dart:convert';
import 'dart:ffi';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
final dio = Dio();
String host_url = "https://helical-ranger-419111.el.r.appspot.com";


//login endpoint /user/login
Future<bool> loginUser(String number, String countrycode, String devicenumber, String os, String fcmtoken) async {
 final Map<String, dynamic> payload = {
  "countryCode": countrycode,
  "number": number,
  "deviceInfo": {
   "deviceNumber": devicenumber,
   "operatingSystem": os,
   "appVersion": "1.0",
   "fcmToken": fcmtoken,
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
   if(response.data.toString().contains("ACCOUNT_UNVERIFIED")){
    Fluttertoast.showToast(msg: "Not verified");
    return false;
   }else if(response.data.toString().contains("ACCOUNT_DOES_NOT_EXIST")){
    Fluttertoast.showToast(msg: "The number is not associated with any account, please sign up instead");
    return false;
   }
   else{
    return true;
   }
   print(response.headers);


  } else {
   Fluttertoast.showToast(msg: getErrorMessage(response.data));
   return false;
  }
 } catch (e) {

  Fluttertoast.showToast(msg:"There was an issue. Please try again later.");
  return false;
 }
}


//otp endpoint /user/otp-verification
Future<String> otpVerification(String number,String mobile, String fcmToken, String countrycode) async {

 final payload = {
  "number": mobile,
  "countryCode": countrycode,
  "otp": number,
 };

 try {
  Response response = await dio.post(
   host_url + '/user/otp-verification',
   data: payload,
   options: Options(
    headers: {
     'Content-Type': 'application/json',
    },
    validateStatus:  (status) => true
   ),
  );


  // Accessing the headers map
  var headers = response.headers;

  // Fetching the 'sessionToken' header
  String? sessionToken = headers.value('sessiontoken');
  if(sessionToken!=null){
   SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.setString("sessionToken", sessionToken);
  }


  print(response.headers.toString());
   return response.data.toString();


 } catch (e) {

  return "error";
 }
}


//otp endpoint /user/otp-resend
Future<bool> resendOTPCode(String mobile, String countrycode) async {

 final payload = {
  "number": mobile,
  "countryCode": countrycode,
 };

 try {
  Response response = await dio.post(
   host_url + '/user/otp-resend',
   data: payload,
   options: Options(
       headers: {
        'Content-Type': 'application/json',
       },
       validateStatus:  (status) => true
   ),
  );
  if (response.statusCode == 200) {
   Fluttertoast.showToast(msg: "OTP resent successfully!");
   return true;
  }else{
   return false;
  }

 } catch (e) {
  return false;
 }
}


//checksession endpoint /user/check-logged-in
Future<bool> checkIfSessionisValid(String token) async {
 try {
  Response response = await dio.post(
   host_url + '/user/check-logged-in',
   options: Options(
       headers: {
        'sessionToken': token,
        'Content-Type': 'application/json',
       },
       validateStatus:  (status) => true
   ),
  );

  if (response.statusCode == 200) {
   if(response.data.toString().contains("TOKEN_EXPIRED")){
    return false;
   }else{
    return true;
   }
  }else{
   return true;
  }

 } catch (e) {
  return false;
 }
}



//deleteAccount endpoint /user/delete
Future<bool> deleteAccount(String token) async {
 try {
  Response response = await dio.delete(
   host_url + '/user/delete',
   options: Options(
       headers: {
        'sessionToken': token,
        'Content-Type': 'application/json',
       },
       validateStatus:  (status) => true
   ),
  );


  if (response.statusCode == 200) {
   if(response.data.toString().contains("SUCCESS") ){
    return true;
   }else{
    return false;
   }
  }else{
   return false;
  }

 } catch (e) {
  return false;
 }
}



//registration endpoint /user/registration
Future<bool> registerUser(String token, String email, String registration_number, String registered, String lawfirm, String location, String practiceArea,  String expertise, String experienceinyears, String language ) async {

 final Map<String, dynamic> payload =
 {
  "email": email,
  "lawyerRegistrationNumber": registration_number,
  "lawFirm": lawfirm,
  "isRegisteredLawyer": registered == "Yes" ? true : false,
  "location": location,
  "selectPracticeAreas": practiceArea,
  "selectExpertise": expertise,
  "experienceInYears": int.parse(experienceinyears),
  "preferredLanguage": language == "English" ?  0 : 1
 };

 try {
  Response response = await dio.post(
   host_url + '/user/registration',
   data: payload,
   options: Options(
    headers: {
     'sessionToken': token,
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
   return false;
  }
 } catch (e) {

  Fluttertoast.showToast(msg:"There was an issue. Please try again later.");
  return false;
 }
}





//logout endpoint /user/logout
Future<bool> logoutFromSession(String token) async {
 try {

  Response response = await dio.post(
   host_url + '/user/logout',
   options: Options(
       headers: {
        'sessionToken': token,
        'Content-Type': 'application/json',
       },
       validateStatus:  (status) => true
   ),
  );

  if (response.statusCode == 200) {
   if(response.data.toString().contains("TOKEN_EXPIRED") || response.data.toString().contains("SUCCESS") ){
    return true;
   }else{
    return false;
   }
  }else{
   return false;
  }

 } catch (e) {
  return false;
 }
}




//signupuser endpoint /user/signup
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
   if(response.data.toString().contains("ACCOUNT_UNVERIFIED")){
    Fluttertoast.showToast(msg: "Not verified");
    return false;
   }else if(response.data.toString().contains("ACCOUNT_EXIST")){
    Fluttertoast.showToast(msg: "This number is already registered, please go to login");
    return false;
   }else{
    return true;
   }
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