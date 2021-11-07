import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petsadoption/Views/Widgets/custom_txtStyle.dart';
import 'package:petsadoption/constants.dart';

class CustomVetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.r))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 120.h,
            width: 1.sw,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                image: DecorationImage(
                    image: NetworkImage(
                        'https://cdn1.vectorstock.com/i/1000x1000/13/20/vet-clinic-with-doctor-vector-21191320.jpg'),
                    fit: BoxFit.fill)),
          ),
          SizedBox(height: 3,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                color: primaryColor,
                size: 15,
              ),
              CustomTxtStyle(
                  text: 'kafr el sheikh',
                  txtSize: 13,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey.shade700),
            ],
          ),
          CustomTxtStyle(
              text: 'Vet Clinic',
              txtSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor),
        ],
      ),
    );
  }
}
