import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petsadoption/constants.dart';
class CustomPetProfile extends StatefulWidget {
  String? hinTxt;
  double? width;
  Widget? icon;
  double? txtSize;
  double? contentPadding;
  bool enabled;
  var controller;
  String? labelTxt;
  var onTap;
  var validate;
  bool heightBool;


  CustomPetProfile({this.hinTxt,this.width,this.icon,this.txtSize=17,this.heightBool=true,
    this.enabled=false,this.contentPadding=10,this.controller,this.labelTxt,this.onTap,this.validate});

  @override
  _CustomPetProfileState createState() => _CustomPetProfileState();
}

class _CustomPetProfileState extends State<CustomPetProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height:widget.heightBool?50.h:70.h ,
      width:widget.width ,
      child: Card(
        elevation: 10,
        child: TextFormField(
          readOnly: widget.enabled,
          controller: widget.controller,
          onTap: widget.onTap,
          cursorColor: primaryColor,
          validator: widget.validate,
          decoration: InputDecoration(
            labelText:widget.labelTxt ,
            suffixIcon: widget.icon,
            hintStyle: GoogleFonts.amiri(fontSize: widget.txtSize,fontWeight: FontWeight.bold,color: grey),
            hintText: widget.hinTxt,
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(widget.contentPadding!),
          ),
        ),
        ),
    );
  }
}
