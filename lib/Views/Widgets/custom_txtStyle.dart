import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomTxtStyle extends StatelessWidget {
String? text;
double?txtSize;
FontWeight?fontWeight;
Color? color;
int? lines;
double? heightTxt;


CustomTxtStyle({this.text, this.txtSize, this.fontWeight,this.color,this.lines,this.heightTxt});

@override
  Widget build(BuildContext context) {
    return Text(
      text!,
        softWrap: true,

      maxLines:lines ,
      overflow: TextOverflow.ellipsis,
        style:  GoogleFonts.amiri(

          height: heightTxt,
        color: color,
        fontSize: txtSize,
        fontWeight: fontWeight,



    ));
  }
}
