import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petsadoption/Views/Widgets/custom_txtStyle.dart';

import '../../constants.dart';

class CustomListTile extends StatelessWidget {
  String?text;
  var onTap;
  String?number;
  bool isVisible;

  CustomListTile({this.text, this.onTap, this.number,this.isVisible=false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 60.h,
      color: Colors.white,
      child: ListTile(
        title:CustomTxtStyle(text: text,color: grey,fontWeight: FontWeight.bold,) ,
        trailing:Container(
          height: 0.3.sh,
          width: 0.5.sw,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            Visibility(
              visible: isVisible,
              child: Container(
                height: 20.h,
                width: 20.w,
                child: Badge(
                  badgeColor: primaryColor,
                  padding: EdgeInsets.all(2),
                  badgeContent: Align(alignment: Alignment.topCenter,
                      child: CustomTxtStyle(text: number,color: Colors.white,fontWeight: FontWeight.bold,txtSize: 12,)) ,

                ),
              ),
            ),
            SizedBox(width: 10,),
            Icon(Icons.arrow_forward_ios,color: primaryColor,)
          ],),
        ) ,
        onTap: onTap,
      ),
    );
  }
}
