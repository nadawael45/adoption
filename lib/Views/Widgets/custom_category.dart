import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petsadoption/Views/Widgets/custom_txtStyle.dart';
import 'package:petsadoption/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCategory extends StatelessWidget {
  String?text;
  CustomCategory({this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
          decoration: BoxDecoration(
          color:  Colors.white,
          borderRadius: BorderRadius.circular(30),),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(

            children: [
            Icon(Icons.clear,color: grey,size: 20,),
            SizedBox(width: 0.01.sw,),
            Row(
              children: [
                CustomTxtStyle(text: ' # ',fontWeight: FontWeight.bold,txtSize: 13,color: grey,),
                CustomTxtStyle(text:text ,fontWeight: FontWeight.bold,txtSize: 13,color: grey,),

              ],
            ),

          ],),
        ),

      ),
    );
  }
}
