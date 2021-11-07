import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petsadoption/Views/Screens/pet_details.dart';
import 'package:petsadoption/Views/Screens/setting_screen.dart';

import 'package:petsadoption/Views/Widgets/custom_iconBTN.dart';
import 'package:petsadoption/Views/Widgets/custom_petCard.dart';
import 'package:petsadoption/Views/Widgets/custom_txtStyle.dart';
import 'package:petsadoption/constants.dart';
import 'package:petsadoption/controller/store.dart';
import 'package:petsadoption/models/animalImg_model.dart';
import 'package:petsadoption/models/pet_model.dart';

class AllAnimals extends StatefulWidget {
  static String id='allanimal';
  @override
  _AllAnimalsState createState() => _AllAnimalsState();
}

class _AllAnimalsState extends State<AllAnimals> {
  static final List<AnimalModel> animalImg=[
    AnimalModel(img:'images/icons8-dog-64 (1).png',name: 'Dogs'),
    AnimalModel(img:'images/icons8-cat-64.png',name: 'Cats'),
    AnimalModel(img:'images/icons8-fish-40.png',name: 'Fish'),
    AnimalModel(img:'images/icons8-turtle-64.png',name: 'Turtles'),
    AnimalModel(img:'images/icons8-chick-60 (2).png',name: 'Birds'),

  ];
  List<bool> clicck = List.filled(animalImg.length, false);
  String? animalName;


  Store store= Store();
  List<PetModel>petlist=[];
  @override
  Widget build(BuildContext context) {
    return
    StreamBuilder<QuerySnapshot>(
      stream:store.getAllAnimals() ,
      builder: (context,snapshot){
        if(snapshot.hasData){
          for(var doc in snapshot.data!.docs){
            petlist.add(PetModel(name: doc.get('name'),
                color: doc.get('color'), birth: doc.get('birthDate'),
                filelink: doc.get('fileLink'), price: doc.get('price'),
                image: doc.get('image'), weight: doc.get('weight'),
                clinicname: doc.get('ClinicName'), locationLink: doc.get('mapLink'),
                ownername: doc.get('ownerName'), ownerlocation: doc.get('ownerLocation'),
                ownerphone: doc.get('ownerPhone'), owneremail: doc.get('ownerEmail'), ownerid: doc.get('id'),
                age: doc.get('age'), animaltype: doc.get('type'), vaccinated: doc.get('isVaccinated'),sex:doc.get('sex'), ));}
          return
            SingleChildScrollView(

            child: Container(
              color: lightPink,
              width: 1.sw,
              height: 1.sh,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width:1.sw ,
                    height: 0.3.sh,
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BackButton(color: primaryColor,),
                                CustomTxtStyle(text:'Adopt me',txtSize: 22,fontWeight: FontWeight.bold,color: grey),
                              ],
                            ),
                            SizedBox(height: 10.h,),

                            Expanded(
                              child: Container(
                                height: 10.h,
                                  width: 1.sw,
                                  decoration: BoxDecoration(
                                      color: lightPink,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: TextFormField(
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.search,color:primaryColor),
                                    hintStyle: GoogleFonts.amiri(fontSize: 17,fontWeight: FontWeight.normal,color: grey),
                                    hintText: 'Enter type of animal or city',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(11),
                                  )
                              )),
                            ),
                            SizedBox(height:20 ,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                          Expanded(
                            child: Center(
                              child: Container(
                                height:40.h ,
                                width: 0.75.sw,
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context,index)=>CustomIconBtn(
                                        onPressed: (){
                                          clicck = List.filled(animalImg.length, false);
                                          setState(() {

                                            clicck[index]=!clicck[index];
                                            animalName=animalImg[index].name;


                                          });
                                        },
                                        color:clicck[index]==false?
                                        Colors.white:primaryColor ,
                                        icon:Image.asset(animalImg[index].img.toString(),width: 25,height: 25,)),
                                    separatorBuilder: (context,index)=>SizedBox(width: 5,),
                                    itemCount: animalImg.length),


                              ),
                            ),
                          ),
                              ],
                            ),

                          ],),
                      ),
                    ),
                  ),
                  SizedBox(height:10 ,),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: lightPink,
                          borderRadius:
                          BorderRadius.only(topRight: Radius.circular(1)),
                        ),
                        child: GridView.builder(

                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.5),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context,index)=>Material(
                              child: InkWell(

                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PetDetails(petlist[index])));
                                },
                                child: CustomPetCard(
                                  price:petlist[index].price ,
                                  name: petlist[index].name,
                                  age: petlist[index].age,
                                  location:petlist[index].ownerlocation ,
                                  img: petlist[index].image,
                                  isAdopt:petlist[index].price=='free'?true:false ,
                                  isVacc: petlist[index].vaccinated=='true'?true:false,
                                  isFemale:petlist[index].sex=='Female'?true:false ,

                                ),
                              ),
                            )



                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

          );

        }else{
          return Center(child: Text('no data'));
        }
      }
     
    );


  }
}
