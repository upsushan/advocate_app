
import 'dart:io' show Platform;

import 'package:advocate_app/auth/signin.dart';
import 'package:advocate_app/pages/home.dart';
import 'package:advocate_app/pages/home/homepage.dart';
import 'package:advocate_app/pages/onboarding/onboardingscreen.dart';
import 'package:advocate_app/wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  if (Platform.isAndroid) {
    //Initializing firebase for Android
    await Firebase.initializeApp( options: const FirebaseOptions( apiKey: "AIzaSyCod09qeF6nhD3nPJ1u8ZkYJR3OUL1mDjo", appId: "1:219122845130:android:0dbe2103eb7def8a387b33", messagingSenderId: "219122845130", projectId:"advocateapp-123e5" ));
  } else if (Platform.isIOS) {
    //Initializing firebase for IOS and MacOs
    await Firebase.initializeApp();
  }


    runApp(EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('hi', 'IN'),
      ],
      path: 'assets/translation', // Path to your translation files
      fallbackLocale: const Locale('en', 'US'), // Default language
      child: const MyApp(),
    ));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    // Set status bar color to white
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.white, // Color you want for status bar
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    // orientation of screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
            ),
            debugShowCheckedModeBanner: false,
            home: Wrapper(),
          );
        });
  }
}
