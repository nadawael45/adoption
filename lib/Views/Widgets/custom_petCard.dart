import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petsadoption/Views/Widgets/custom_txtStyle.dart';
import 'package:petsadoption/constants.dart';

class CustomPetCard extends StatefulWidget {
  String? price;
  String? age;
  String? name;
  String? location;
  bool isVacc;
  bool isAdopt;
  bool isFemale;
  String? img;
  var iconTap;
  bool isFav;

  CustomPetCard(
      {this.price,
      this.age,
      this.name,
      this.isFemale = false,
      this.img,
      this.location,
        this.isFav=false,
        this. iconTap,
      this.isAdopt = false,
      this.isVacc = false});

  @override
  _CustomPetCardState createState() => _CustomPetCardState();
}

class _CustomPetCardState extends State<CustomPetCard> {

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.r))),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 110.h,
                width: 200.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(widget.img!),
                      fit: BoxFit.cover,
                    ))),
            Center(
                child: CustomTxtStyle(
                    text: widget.name,
                    txtSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_city,
                  color: iconPink,
                  size: 20,
                ),
                CustomTxtStyle(
                    text: widget.location,
                    txtSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey.shade700),
                Text(
                  ' | ',
                  style: TextStyle(color: grey),
                ),
                CustomTxtStyle(
                    text: widget.age,
                    txtSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey.shade700),
                Text(
                  ' | ',
                  style: TextStyle(color: grey),
                ),
                Icon(
                  widget.isFemale ? Icons.female : Icons.male,
                  color: iconPink,
                  size: 20,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(
                children: [
                  CustomTxtStyle(
                      text: '${widget.price}',
                      txtSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700),
                  Spacer(),
                  InkWell(
                    child: Icon(
                     widget.isFav ? Icons.favorite : Icons.favorite_border,
                      color: iconPink,
                      size: 25,
                    ),
                    onTap: widget.iconTap
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Visibility(
                      visible: widget.isAdopt,
                      child: CustomTxtStyle(
                          text: 'For Adoption',
                          txtSize: 15,
                          fontWeight: FontWeight.bold,
                          color: primaryColor)),
                  CustomTxtStyle(
                      text: widget.isVacc ? 'Vaccinated' : 'Not Vaccinated',
                      txtSize: 15,
                      fontWeight: FontWeight.bold,
                      color: widget.isVacc ? primaryColor : grey),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
