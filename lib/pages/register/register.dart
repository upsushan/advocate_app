import 'package:advocate_app/apis/apis.dart';
import 'package:advocate_app/pages/home.dart';
import 'package:advocate_app/pages/home/homepage.dart';
import 'package:advocate_app/utils/colors.dart';
import 'package:advocate_app/utils/icons.dart';
import 'package:advocate_app/utils/textStyle.dart';
import 'package:advocate_app/widgets/buttons.dart';
import 'package:advocate_app/widgets/textField.dart';
import 'package:advocate_app/wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? _selectedBarCouncil;

  TextEditingController email = TextEditingController();
  TextEditingController lawyerRegistrationNumber = TextEditingController();
  TextEditingController lawFirmOrganization = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController yearsOfExperience = TextEditingController();

  List<String> councilItems = [
    'Select Bar Council Affiliated To :'.tr(),
    'Bar Council of Delhi'.tr(),
    'Bar Council of Maharashtra and Goa'.tr(),
    'Bar Council of West Bengal'.tr(),
    'Bar Council of Uttar Pradesh'.tr(),
    'Bar Council of Karnataka'.tr(),
    'Bar Council of Tamil Nadu and Puducherry'.tr(),
    'Bar Council of Andhra Pradesh'.tr(),
    'Bar Council of Kerala'.tr(),
    'Bar Council of Gujarat'.tr(),
    'Bar Council of Rajasthan'.tr(),
    'Bar Council of Madhya Pradesh'.tr(),
    'Bar Council of Punjab and Haryana'.tr(),
    'Bar Council of Chhattisgarh'.tr(),
    'Bar Council of Odisha'.tr(),
    'Bar Council of Jharkhand'.tr(),
    'Bar Council of Bihar'.tr(),
    'Bar Council of Jammu and Kashmir'.tr(),
    'Bar Council of Uttarakhand'.tr(),
    'Bar Council of Himachal Pradesh'.tr(),
    'Bar Council of Assam, Nagaland, Mizoram, Arunachal Pradesh and Sikkim'.tr(),
    'Bar Council of Tripura, Manipur and Meghalaya'.tr(),
    'Bar Council of Andaman and Nicobar Islands'.tr(),
    'Bar Council of Lakshadweep'.tr(),
    'Bar Council of Dadra and Nagar Haveli and Daman and Diu'.tr(),
    'Bar Council of Chandigarh'.tr(),
  ];

  List<String> practiceItems = [
    'Select Practice Areas :'.tr(),
    'Litigation'.tr(),
    'Corporate Law'.tr(),
    'Intellectual Property Law'.tr(),
    'Family Law'.tr(),
    'Real Estate Law'.tr(),
    'Labor and Employment Law'.tr(),
    'Tax Law'.tr(),
    'Bankruptcy Law'.tr(),
    'Environmental Law'.tr(),
    'Immigration Law'.tr(),
    'Others'.tr()
  ];

  List<String> expertiseItems = [
    'Select Your Expertise :'.tr(),
    'Practicing Advocate'.tr(),
    'Corporate Lawyer'.tr(),
    'Legal Freelancer'.tr(),
    'In-house Counsel'.tr(),
    'Paralegal'.tr(),
    'Fresh Law Graduate'.tr()
  ];

  List<String> languageItems = [
    'Select Preferred Language :'.tr(),
    'English'.tr(),
    'Hindi'.tr(),
  ];

  List<String> registeredLawyer = [
    'Are you a Registered Lawyer :'.tr(),
    'Yes'.tr(),
    'No'.tr(),
  ];

  String? selectedLanguageItem = 'Select Preferred Language :'.tr();
  String? selectedLanguageItem_firstVal = 'Select Preferred Language :'.tr();

  String? selectedExpertiseItem = 'Select Your Expertise :'.tr();
  String? selectedExpertiseItem_firstVal = 'Select Your Expertise :'.tr();

  String? selectedCouncilItem = 'Select Bar Council Affiliated To :'.tr();
  String? selectedCouncilItem_firstVal = 'Select Bar Council Affiliated To :'.tr();
  String? areyouregistered_firstVal = 'Are you a Registered Lawyer :'.tr();
  String? areyouregistered = 'Are you a Registered Lawyer :'.tr();

  String? selectedAreaItem = 'Select Practice Areas :'.tr();
  String? selectedAreaItem_firstVal = 'Select Practice Areas :'.tr();

  bool registred =false;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            SizedBox(
              height: 8.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Backbutton(
                    key: ValueKey('back_button'),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),

// Register to continue using the platform.
            SizedBox(
              height: 10.h,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Text(
                    'Register to continue using\nthe platform.'.tr(),
                    style: GoogleFonts.poppins(
                      color: AppColors.textMainBlack,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),

            SizedBox(
              height: 10.h,
            ),
// email address
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                height: 65.h,
                child: TextField(
                  style: GoogleFonts.poppins(
                    color: AppColors.textMainBlack,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  controller: email,
                  decoration:
                  AppTextFieldStyle.textFieldStyle('Enter email address'.tr()),
                ),
              ),
            ),

            SizedBox(
              height: 10.h,
            ),
// Enter Lawyer Registration Number
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                height: 65.h,
                child: TextField(
                  style: GoogleFonts.poppins(
                    color: AppColors.textMainBlack,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  controller: lawyerRegistrationNumber,
                  keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
                  decoration: AppTextFieldStyle.textFieldStyle(
                      'Enter Lawyer Registration Number'.tr()),
                ),
              ),
            ),

            SizedBox(
              height: 10.h,
            ),
// Enter Law Firm/Organization
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                height: 65.h,
                child: TextField(
                  style: GoogleFonts.poppins(
                    color: AppColors.textMainBlack,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  controller: lawFirmOrganization,
                  decoration: AppTextFieldStyle.textFieldStyle(
                      'Enter Law Firm/Organization '.tr()),
                ),
              ),
            ),

            SizedBox(
              height: 10.h,
            ),

            // bar council

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                height: 65.h,
                width: double.infinity,
                decoration: ShapeDecoration(
                  color: Color(0xFFF9FAFB),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 1.w, color: AppColors.textMainBlack),
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
                    value: areyouregistered,
                    items: registeredLawyer
                        .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        style: GoogleFonts.poppins(
                          color: areyouregistered_firstVal == item ? AppColors.textMainBlack.withOpacity(0.4) :  AppColors.textMainBlack,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ))
                        .toList(),
                    onChanged: (item) =>
                        setState(() {
                          areyouregistered = item;
                          registred =  item == "Yes".tr() ? true : false;
                        }),
                  ),
                ),
              ),
            ),

            if(registred)
              SizedBox(
                height: 10.h,
              ),


            if(registred)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  height: 65.h,
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    color: Color(0xFFF9FAFB),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 1.w, color: AppColors.textMainBlack),
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
                      value: selectedCouncilItem,
                      items: councilItems
                          .map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                          style: GoogleFonts.poppins(
                            color:  selectedCouncilItem_firstVal == item ? AppColors.textMainBlack.withOpacity(0.4):AppColors.textMainBlack,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ))
                          .toList(),
                      onChanged: (item) =>
                          setState(() => selectedCouncilItem = item),
                    ),
                  ),
                ),
              ),

            SizedBox(
              height: 10.h,
            ),
// Enter location
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                height: 65.h,
                child: TextField(
                  style: GoogleFonts.poppins(
                    color: AppColors.textMainBlack,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  controller: location,
                  decoration:
                  AppTextFieldStyle.textFieldStyle('Enter Location'.tr()),
                ),
              ),
            ),

// select practice areas

            SizedBox(
              height: 10.h,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                height: 65.h,
                width: double.infinity,
                decoration: ShapeDecoration(
                  color: Color(0xFFF9FAFB),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 1.w, color: AppColors.textMainBlack),
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
                    value: selectedAreaItem,
                    items: practiceItems
                        .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        style: GoogleFonts.poppins(
                          color:  selectedAreaItem_firstVal == item ? AppColors.textMainBlack.withOpacity(0.4):AppColors.textMainBlack,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ))
                        .toList(),
                    onChanged: (item) =>
                        setState(() => selectedAreaItem = item),
                  ),
                ),
              ),
            ),

// select your expertise
            SizedBox(
              height: 10.h,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                height: 65.h,
                width: double.infinity,
                decoration: ShapeDecoration(
                  color: Color(0xFFF9FAFB),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 1.w, color: AppColors.textMainBlack),
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
                    value: selectedExpertiseItem,
                    items: expertiseItems
                        .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        style: GoogleFonts.poppins(
                          color:  selectedExpertiseItem_firstVal == item ? AppColors.textMainBlack.withOpacity(0.4):AppColors.textMainBlack,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ))
                        .toList(),
                    onChanged: (item) =>
                        setState(() => selectedExpertiseItem = item),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 10.h,
            ),
// Enter years of experience
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                height: 65.h,
                child: TextField(
                  style: GoogleFonts.poppins(
                    color: AppColors.textMainBlack,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  controller: yearsOfExperience,
                  keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
                  decoration: AppTextFieldStyle.textFieldStyle(
                      'Enter years of experience'.tr()),
                ),
              ),
            ),

// select your prefered language

            SizedBox(
              height: 10.h,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                height: 65.h,
                width: double.infinity,
                decoration: ShapeDecoration(
                  color: Color(0xFFF9FAFB),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 1.w, color: AppColors.textMainBlack),
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
                          color: selectedLanguageItem_firstVal == item ? AppColors.textMainBlack.withOpacity(0.4):AppColors.textMainBlack.withOpacity(1),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ))
                        .toList(),
                    onChanged: (item) =>
                        setState(() => selectedLanguageItem = item),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 30.h,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: GradientButton(
                  key: ValueKey('submit'),
                  text: 'Submit'.tr(),
                  onTap: ()async {



                   if(email.text!="" && lawyerRegistrationNumber.text!="" && lawFirmOrganization.text!="" && location.text!="" && yearsOfExperience.text!=""){
                     if(areyouregistered_firstVal != areyouregistered && selectedAreaItem_firstVal!= selectedAreaItem  && selectedExpertiseItem!=selectedExpertiseItem_firstVal && selectedLanguageItem_firstVal!=selectedLanguageItem){
                       String token = await sessionToken();
                       bool registered = await registerUser(token, email.text, lawyerRegistrationNumber.text, areyouregistered!, lawFirmOrganization.text, location.text, selectedAreaItem!, selectedExpertiseItem!, yearsOfExperience.text, selectedLanguageItem!);

                       if(registered){
                         Fluttertoast.showToast(msg: "Registered Successfully");
                         Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Wrapper()));
                       }else{
                         Fluttertoast.showToast(msg: "Sorry there was an issue");
                       }


                     }else{
                       Fluttertoast.showToast(msg: "Please select from all selection fields before Registering");
                     }

                   }else{
                     Fluttertoast.showToast(msg: "Please enter all details before Registering");
                   }

                  }),
            ),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }

 Future<String> sessionToken()async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   String? token =  prefs.getString("sessionToken");
   return token!;
 }
}
