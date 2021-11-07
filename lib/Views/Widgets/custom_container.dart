import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';
import 'custom_txtStyle.dart';
class CustomContainer extends StatelessWidget {
  double? width;
  String? text;

  CustomContainer({this.width, this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
          width: width,
          height: 30.h,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
              child: CustomTxtStyle(
                text: text,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                txtSize: 16,
              ))),
    );
  }
}
