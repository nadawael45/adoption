import 'package:flutter/material.dart';

import '../../constants.dart';
import 'custom_txtStyle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProfileInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.r))),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.person,
                    color: primaryColor,
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  CustomTxtStyle(
                      text: 'Nada wael',
                      txtSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700),
                  Spacer(),
                  Icon(
                    Icons.edit,
                    color: primaryColor,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Visibility(
                visible: false,
                child: Row(
                  children: [
                    Icon(
                      Icons.add_box,
                      color: primaryColor,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    CustomTxtStyle(
                        text: 'Petalia Clinic',
                        txtSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: primaryColor,
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  CustomTxtStyle(
                      text: 'Kafr EL Sheikh',
                      txtSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Icon(
                    Icons.phone_android,
                    color: primaryColor,
                  ),
                  CustomTxtStyle(
                      text: '01095555555',
                      txtSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
