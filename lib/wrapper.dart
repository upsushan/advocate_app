
import 'package:advocate_app/pages/home/homepage.dart';
import 'package:advocate_app/pages/onboarding/onboardingscreen.dart';
import 'package:advocate_app/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Wrapper extends StatefulWidget {
  final bool loading;
  const Wrapper({super.key, this.loading = true});
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  late bool _loading;
  late SharedPreferences pref;
  bool loggedIn = false;


  @override
  void initState() {
    super.initState();
    _loading = widget.loading;



    if(_loading) {
      Future.delayed(const Duration(milliseconds: 2600), () async{
        pref = await SharedPreferences.getInstance();
        loggedIn = pref.getBool('loggedIn') ?? false;
        if(loggedIn) {
          loggedIn = await sessionActive();
        }
        if(!loggedIn){
          pref.setBool("loggedIn", false);
          pref.remove('loggedInDate');
        }

        setState(() => _loading = false);
      });
    }

  }

  @override
  Widget build(BuildContext context) {

          return _loading ? SplashScreen() : loggedIn ? HomePage() : OnboardingScreen();

  }


  Future<bool> sessionActive() async {
    final String? storedDateString = pref.getString('loggedInDate');

    if (storedDateString != null) {
      DateTime storedDate = DateTime.parse(storedDateString);
      DateTime dateAfter30Days = storedDate.add(const Duration(days: 30));

      if (DateTime.now().isAfter(dateAfter30Days)) {
       return false;
      } else {
        return true;
      }
    }else {
      return false;
    }
  }
}