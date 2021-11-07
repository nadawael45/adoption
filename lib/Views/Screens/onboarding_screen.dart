import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petsadoption/Views/Screens/Sign_up.dart';
import 'package:petsadoption/Views/Widgets/custom_btn.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class OnBoardingScreen extends StatefulWidget {
  static String id='onboarding';
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  checkFirst()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    pref.setBool('first',false);

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkFirst();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 100.h,
            child: Center(
              child: Text(
                'Welcome !',
                style: GoogleFonts.amiri(
                    color: Colors.white,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                    height: 3.5.h,
                    wordSpacing: 2.sp,
                    letterSpacing: 1),
              ),
            ),
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(70.r),
                    bottomRight: Radius.circular(70.r))),
          ),
          Image.asset('images/undraw_friends_r511.png',
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity),
          Text(
            'Find the nearest pet',
            style: txtSPLarge,
          ),
          Text(
            'from your location',
            style: txtSPLarge,
          ),
          SizedBox(
            height: 15.h,
          ),
          Text(
            'Choose a location of your for',
            style: txtSPSmall,
          ),
          Text(
            'finding the nearest animal for you',
            style: txtSPSmall,
          ),
          Spacer(),
          CustomBtn(
            labelText: 'continue',
            height: 40.h,
            width: double.infinity,
           onTap:()=> Navigator.popAndPushNamed(context, SignUp.id),
          ),
        ],
      ),
    );
  }
}
