import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petsadoption/Views/Screens/vet_details.dart';
import 'package:petsadoption/Views/Widgets/custom_scaffold.dart';
import 'package:petsadoption/Views/Widgets/custom_txtStyle.dart';
import 'package:petsadoption/Views/Widgets/custom_vet_card.dart';
import 'package:petsadoption/controller/store.dart';
import 'package:petsadoption/models/vet_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';
class AllVetScreen extends StatelessWidget {
  static String id ='allvets';
  List<VetModel>vetlist=[];
  Store store=Store();
  @override
  Widget build(BuildContext context) {
    return
      CustomScaffold(
appBar: AppBar(
  backgroundColor: Colors.white,
  leading: BackButton(color: primaryColor,),
  title:CustomTxtStyle(text:'Back',txtSize: 22,fontWeight: FontWeight.bold,color: grey),),
        body:
        StreamBuilder<QuerySnapshot>(
            stream:store.getAllVets() ,
            builder: (context,snapshot){
              if(snapshot.hasData){
                for(var doc in snapshot.data!.docs){
                  vetlist.add(VetModel(
                    locationLink: doc.get('mapLink'),
                    location: doc.get('location'),
                    faceLink: doc.get('faceLink'),
                    clinicname: doc.get('ClinicName'),
                    name: doc.get('DR-Name'),
                    image: doc.get('image'),
                    city: doc.get('LocationCity'),
                    description: doc.get('description'),
                    type: doc.get('type'),
                    phone: doc.get('DR-Phone'),
                    email:doc.get('DR-Email'),
                    id: doc.get('DR-Id'),
                  ));              }
                return
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15,bottom: 20,top: 20),
                    child: GridView.builder(

                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.8),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context,index)=>Material(
                          child: InkWell(

                            onTap: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>VetDetails(vetlist[index])));
                            },
                            child:CustomVetCard(
                              img: vetlist[index].image,
                              city: vetlist[index].city,
                              type: vetlist[index].type,
                            ),
                          ),
                        )



                    ),
                  );

              }else{
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: primaryColor,),
                    CustomTxtStyle(text: 'Check your internet connection',)
                  ],
                );
              }
            }

        )
      );
  }
}
