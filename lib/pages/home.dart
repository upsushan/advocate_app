import 'package:advocate_app/pages/chats/chat_history_screen.dart';
import 'package:advocate_app/pages/home/homepage.dart';
import 'package:advocate_app/pages/language/settingsScreen.dart';
import 'package:advocate_app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ChatsHistory(),
    settingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
    ),
    );
  }
}
