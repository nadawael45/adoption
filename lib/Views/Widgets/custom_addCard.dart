import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petsadoption/Views/Widgets/custom_txtStyle.dart';

class CustomAddCard extends StatelessWidget {
  String? text1;
  String? text2;
  String? img;


  CustomAddCard(this.text1, this.text2,this.img);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.h,
      width: 1.sw,
      child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.r))),
        elevation: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                SizedBox(height: 10,),
                CustomTxtStyle(text:text1,txtSize: 17.sp,fontWeight: FontWeight.bold, color:Colors.grey.shade700,),
                Container(width: 0.45.sw,
                    child: CustomTxtStyle(text:text2,txtSize: 11.sp, fontWeight:FontWeight.normal, color:Colors.grey.shade700,lines:4)),

              ],),
            ),
            Expanded(
              child: Image.asset(img!,fit:BoxFit.fill,height: 130.h,width: 0.4.sw,
              ),
            ),

          ],)
      ),
    );
  }
}
