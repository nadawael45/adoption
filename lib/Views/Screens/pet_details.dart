import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petsadoption/Views/Widgets/custom_btn.dart';
import 'package:petsadoption/Views/Widgets/custom_iconBTN.dart';
import 'package:petsadoption/Views/Widgets/custom_txtStyle.dart';
import 'package:petsadoption/models/pet_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';

class PetDetails extends StatefulWidget {
  PetModel petModel;

  PetDetails(this.petModel);

  static String id='petdetails';
  @override
  _PetDetailsState createState() => _PetDetailsState();
}

class _PetDetailsState extends State<PetDetails> {
  var id;




  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightPink,
      body:
      SingleChildScrollView(
        child:  Column(
          children: [
            Container(
              width:1.sw ,
              height: 0.6.sh,
              child: Card(
                elevation: 10,

                child: Column(children: [
                  SizedBox(height: 35.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BackButton(color: primaryColor,),
                      CustomTxtStyle(text:'Adopt me',txtSize: 22,fontWeight: FontWeight.bold,color: grey),
                    ],
                  ),
                  Container(decoration: BoxDecoration(
                    color: Colors.white,
//                    borderRadius: BorderRadius.circular(30),
//                    border: Border.all(color: Colors.white,width: 5)
                  ),
                    width:0.7.sw ,
                    height: 0.27.sh,
                  child: CircleAvatar(backgroundColor: Colors.white,backgroundImage: NetworkImage(widget.petModel.image!,),radius: 100,)),
                  SizedBox(height: 10.h,),
                  CustomTxtStyle(text:widget.petModel.name!,txtSize: 22,fontWeight: FontWeight.bold,color: grey),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTxtStyle(text:widget.petModel.color==null?'':'${widget.petModel.color}'+' | ',txtSize: 16, fontWeight:FontWeight.normal,color: Colors.grey.shade700),
                      CustomTxtStyle(text:widget.petModel.age==null?'':'${widget.petModel.age}'+' | ',txtSize: 16, fontWeight:FontWeight.normal,color: Colors.grey.shade700),
                      CustomTxtStyle(text:widget.petModel.weight==null?'':'${widget.petModel.weight}'+' | ',txtSize: 16, fontWeight:FontWeight.normal,color: Colors.grey.shade700),
                      Icon(widget.petModel.sex=='Female'?Icons.female:Icons.male,color: iconPink,size: 20,),


                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(widget.petModel.vaccinated=='true'?Icons.done_all:Icons.close,color:widget.petModel.vaccinated=='true'?primaryColor:grey ,size: 25,),
                              CustomTxtStyle(text:widget.petModel.vaccinated=='true'?' Vaccinated':' Not Vaccinated',txtSize: 17, fontWeight:FontWeight.bold,color: widget.petModel.vaccinated=='true'?primaryColor:grey),

                            ],
                          ),
                        ),
                        Spacer(),
                        Row(children: [
                          widget.petModel.filelink==null?SizedBox(width: 15,)
                          :
                          FloatingActionButton(    heroTag: "btn1",
                            onPressed: (){
                            launchURL(widget.petModel.locationLink!);
                          },child:Image.asset('images/icons8-google-maps-old-48.png',width: 30,height: 30,),backgroundColor: Colors.white,)
                           ,SizedBox(width: 15,)

                         ,
                          FloatingActionButton(    heroTag: "btn2",
                            onPressed:(){ launchURL(widget.petModel.filelink!);},child:Image.asset('images/icons8-google-drive-48.png',width: 30,height: 30,),backgroundColor: Colors.white,),
                          SizedBox(width: 15,),

                        ],),


                      ],),
                    ),
                  )




                ],),


              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                  width: 0.5.sw,
                  height: 30.h,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: CustomTxtStyle(
                        text: 'Owner Information',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        txtSize: 16,
                      ))),
            ),

            Container(
              color: lightPink,
              width: 1.sw,
              height: 250.h,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // snapshot!.data()['name']!
                                CustomTxtStyle(text:'nada wael',txtSize: 22,fontWeight: FontWeight.bold,color: Colors.grey.shade700),
                              ],
                            ),
                            Row(

                              children: [
                                Icon(Icons.location_city,color: primaryColor,),
                                CustomTxtStyle(text:'  Kafr EL Sheikh',txtSize: 13, fontWeight:FontWeight.bold,color: Colors.grey.shade700),


                              ],),
                          ],),
                          Spacer(),
                          Center(child: Row(children: [
                            CustomIconBtn(icon:Icon(Icons.call,color: iconPink,) ,onPressed: (){},),
                            CustomIconBtn(icon:Icon(Icons.alternate_email,color: iconPink,) ,onPressed: (){},),


                          ],))
                        ],
                      ),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FloatingActionButton.extended(onPressed: (){},
                                label: CustomTxtStyle(text: widget.petModel.price!,fontWeight: FontWeight.bold,txtSize: 16,color: grey,),
                                icon: Icon(Icons.add_shopping_cart,color: grey,),
                                backgroundColor: Colors.white,),

                              Expanded(child: CustomBtn(labelText: 'Adopt Now',size:18 ,height: 36.h,onTap: (){

                              },)),
                            ],),
                        ),
                      )

                    ],
                  ),
                ),
              ),
            ),


          ],
        ),
      ),

    );
  }
}
