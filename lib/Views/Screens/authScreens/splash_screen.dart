import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'onboarding_screen.dart';
import 'package:petsadoption/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../navBtnScreens/home_screen.dart';
import 'login.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool first=true;
  bool isSigned=false;
checkFirst()async{
  SharedPreferences pref=await SharedPreferences.getInstance();
  setState(() {
    first=pref.getBool('first')!;
      isSigned=pref.getBool('signed')!;
  });



}

  @override
  void initState() {
    super.initState();
    checkFirst();
   Timer(Duration(seconds: 3),()=> Navigator.popAndPushNamed(context,
       first? OnBoardingScreen.id:isSigned?HomePage.id:Login.id));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: primaryColor,
      child:Image.asset( 'images/pet.jpg',fit: BoxFit.contain,)

    );
  }
}