import 'package:flutter/material.dart';
import 'package:petsadoption/Views/Widgets/custom_txtStyle.dart';
import 'package:petsadoption/models/vet_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';

class VetDetails extends StatelessWidget {
  VetModel? vetModel;
  VetDetails(this.vetModel);
  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }}
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
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
              CustomTxtStyle(text:'Pet Store Profile',txtSize: 22,fontWeight: FontWeight.bold,color: grey),
            ],
          ),
          Container(decoration: BoxDecoration(
            color: Colors.white,

          ),
              width:0.7.sw ,
              height: 0.27.sh,
              child: CircleAvatar(backgroundColor: Colors.white,backgroundImage: NetworkImage(vetModel!.image!,),radius: 100,)),
          SizedBox(height: 10.h,),
          CustomTxtStyle(text:vetModel!.clinicname!,txtSize: 22,fontWeight: FontWeight.bold,color: grey),
                Visibility(visible:vetModel!.description==null?false:true,
                    child: CustomTxtStyle(text:vetModel!.description!,txtSize: 16, fontWeight:FontWeight.normal,color: Colors.grey.shade700)),

                Visibility(
                  visible:vetModel!.location==null?false:true ,
                    child: CustomTxtStyle(text:vetModel!.location!,txtSize: 16, fontWeight:FontWeight.normal,color: Colors.grey.shade700)),

                Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child:
                Row(children: [
                  vetModel!.locationLink==null?SizedBox(width: 15,) : FloatingActionButton(    heroTag: "btn1",
                    onPressed: (){
                      launchURL(vetModel!.locationLink!);
                    },child:Image.asset('images/icons8-google-maps-old-48.png',width: 30,height: 30,),backgroundColor: Colors.white,)
                  ,SizedBox(width: 15,)

                  ,
                  FloatingActionButton(    heroTag: "btn2",
                    onPressed:(){ launchURL(vetModel!.faceLink!);},child:Image.asset('images/facebook.png',width: 30,height: 30,),backgroundColor: Colors.white,),
                  SizedBox(width: 15,),
                  FloatingActionButton(    heroTag: "btn3",
                    onPressed:(){ launchURL(vetModel!.faceLink!);},child:Icon(Icons.call,color: iconPink,),backgroundColor: Colors.white,),

                ],),


              ),]
            ),
          )




        ,),])


    ),
    )


        ]));
  }
}
