import 'package:flutter/material.dart';
import 'package:petsadoption/Views/Widgets/custom_txtStyle.dart';
import 'package:petsadoption/constants.dart';

class CustomTextFormField extends StatefulWidget {
  String? hintText;
  IconData? suffix;
  var function;
  bool obscureTxt;
  TextEditingController? controller;
  var validate;
  String? labelText;
  String?errorTxt;
  TextInputType? txtType;

  CustomTextFormField(
      {this.hintText, this.suffix, this.function, this.obscureTxt=false, this.controller, this.validate,this.labelText,this.errorTxt,this.txtType});

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextFormField(
      controller: widget.controller!,
      validator: widget.validate,
      keyboardType:widget.txtType ,
      obscureText: widget.obscureTxt,
      cursorColor: Colors.grey.shade700,
     style: TextStyle(color: Colors.grey.shade700),
      decoration: InputDecoration(
       // errorText:  widget.errorTxt,
      focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: primaryColor)),
        fillColor: Colors.grey.shade700,
        labelStyle: labelST ,
        hintStyle:hintST ,
        hintText: widget.hintText,
        labelText: widget.labelText,
        focusColor: primaryColor,

                suffixIcon: IconButton(
          onPressed: widget.function,
          icon: Icon(widget.suffix,color: primaryColor,),
           ),

      ),
    ));
  }
}
