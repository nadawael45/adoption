import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petsadoption/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBtn extends StatefulWidget {
  double height;
  double width;
  double radius;
  double size;

  String?labelText;
  var onTap;


  CustomBtn({this.height=50, this.width=double.infinity, this.radius=8, this.labelText,this.onTap,this.size=23});

  @override
  _CustomBtnState createState() => _CustomBtnState();
}

class _CustomBtnState extends State<CustomBtn> {
  @override
  Widget build(BuildContext context) {
    return
      Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
            height:widget.height,
            width: widget.width,
            child: ElevatedButton(
              onPressed: widget.onTap,
              child: Text(widget.labelText!, style: GoogleFonts.amiri(
                  color: Colors.white,
                  fontSize: widget.size,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                  wordSpacing: 2,
                  letterSpacing: 1),),
              style: ButtonStyle(

                backgroundColor: MaterialStateProperty.resolveWith((
                    states) => primaryColor), shape:
              MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),)
              ),
              ),
            ),
          ));
  }
}

