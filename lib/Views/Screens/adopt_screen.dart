import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petsadoption/Views/Screens/setting_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:petsadoption/Views/Widgets/custom_iconBTN.dart';
import 'package:petsadoption/Views/Widgets/custom_petCard.dart';
import 'package:petsadoption/Views/Widgets/custom_txtStyle.dart';
import 'package:petsadoption/Views/Widgets/custom_vet_card.dart';
import 'package:petsadoption/constants.dart';
import 'package:petsadoption/controller/auth.dart';
import 'package:petsadoption/controller/provider/langProv.dart';
import 'package:petsadoption/controller/store.dart';
import 'package:petsadoption/controller/user.dart';
import 'package:petsadoption/models/animalImg_model.dart';
import 'package:petsadoption/models/pet_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'all_animals_screen.dart';

class AdoptMe extends StatefulWidget {
  @override
  _AdoptMeState createState() => _AdoptMeState();
}

class _AdoptMeState extends State<AdoptMe> {
  var userUid;

  String? animalName;
  bool isarab = false;
 // bool iseng = false;


  Auth auth = Auth();
  Userid userid = Userid();
  static final List<AnimalModel> animalImg = [
    AnimalModel(img: 'images/icons8-dog-64 (1).png', name: 'Dogs'),
    AnimalModel(img: 'images/icons8-cat-64.png', name: 'Cats'),
    AnimalModel(img: 'images/icons8-fish-40.png', name: 'Fish'),
    AnimalModel(img: 'images/icons8-turtle-64.png', name: 'Turtles'),
    AnimalModel(img: 'images/icons8-chick-60 (2).png', name: 'Birds'),
  ];
  Store store = Store();
  List<PetModel> petlist = [];
  List<bool> clicck = List.filled(animalImg.length, false);
  var id;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    clicck[0] = true;
    animalName = 'Dogs';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 1.sw,
            height: 0.27.sh,
            child: Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //  snapshot.data!.docs[id]['name']
                        CustomTxtStyle(
                            text: '',
                            txtSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700),
                        Container(
                            height: 35.h,
                            width: 40.w,
                            child: Card(
                              elevation: 10,
                              color: primaryColor,
                              child: PopupMenuButton(
                                onSelected: (result) async {
                                  if (result == 2) {
                                    auth.signOut();
                                    SharedPreferences pref =
                                        await SharedPreferences.getInstance();
                                    pref.setBool('signed', false);
                                    SystemNavigator.pop();
                                  }
                                  if (result == 1) {
                                    showDialog(context: context, builder: (builder)=>SimpleDialog(
                                      title: CustomTxtStyle(text: 'Choose a language...',color: grey,fontWeight: FontWeight.bold),
                                      children: [
                                        SimpleDialogOption(child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                          ElevatedButton(onPressed: (){setState(() {
                                           isarab=true;

                                          });
                                          }, child: CustomTxtStyle(text: 'عربي',color: grey,fontWeight: FontWeight.bold,),

                                            style: ButtonStyle(backgroundColor:MaterialStateProperty.resolveWith((states) => isarab==false?Colors.white:primaryColor) ),),
                                          ElevatedButton(onPressed: (){
                                            setState(() {
                                            isarab=false;

                                          });

                                          }, child: CustomTxtStyle(text: 'English',color: grey,fontWeight: FontWeight.bold),
                                            style: ButtonStyle(backgroundColor:MaterialStateProperty.resolveWith((states) => isarab==false?primaryColor:Colors.white) ),),

                                        ],),),
                                        SimpleDialogOption(child:
                                        ElevatedButton(onPressed: (){

                                              if(isarab){
                                                context.setLocale(Locale('ar'));
                                                Provider.of<LangProv>(context,listen: false).isChanged();
                                              }else{
                                                context.setLocale(Locale('en',));
                                              }

                                              Navigator.pop(context);


                                        }, child: CustomTxtStyle(text: 'Done',color: grey,fontWeight: FontWeight.bold),
                                          style: ButtonStyle(),),

                                            )
                                      ],
                                    ));
                                  }
                                },
                                color: Colors.white,
                                icon: Image.asset(
                                  'images/edit (1).png',
                                  width: 25,
                                  height: 25,
                                ),
                                itemBuilder: (BuildContext context) {
                                  return [
                                    PopupMenuItem(
                                      value: 1,

                                      child: Text('Language').tr(),
                                    ),
                                    PopupMenuItem(
                                      value: 2,
                                      child: Text('Sign-Out').tr(),
                                    ),
                                  ];
                                },
                              ),
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: primaryColor,
                        ),
                        CustomTxtStyle(
                            text: '',
                            txtSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            height: 40.h,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => CustomIconBtn(
                                    onPressed: () {
                                      clicck =
                                          List.filled(animalImg.length, false);
                                      setState(() {
                                        clicck[index] = !clicck[index];
                                        animalName = animalImg[index].name;
                                      });
                                    },
                                    color: clicck[index] == false
                                        ? Colors.white
                                        : primaryColor,
                                    icon: Image.asset(
                                      animalImg[index].img.toString(),
                                      width: 25,
                                      height: 25,
                                    )),
                                separatorBuilder: (context, index) => SizedBox(
                                      width: 5,
                                    ),
                                itemCount: animalImg.length),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(13),
                        child: Container(
                            width: 0.4.sw,
                            height: 30.h,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                                child: CustomTxtStyle(
                                    text: 'Nearby $animalName'.tr(),
                                    txtSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)))),
                    InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AllAnimals.id);
                        },
                        child: CustomTxtStyle(
                            text: 'seeAll'.tr(),
                            txtSize: 16,
                            fontWeight: FontWeight.bold,
                            color: grey)),
                  ],
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: store.getAllAnimals(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        for (var doc in snapshot.data!.docs) {
                          petlist.add(PetModel(
                            name: doc.get('name'),
                            color: doc.get('color'),
                            birth: doc.get('birthDate'),
                            filelink: doc.get('fileLink'),
                            price: doc.get('price'),
                            image: doc.get('image'),
                            weight: doc.get('weight'),
                            clinicname: doc.get('ClinicName'),
                            locationLink: doc.get('mapLink'),
                            ownername: doc.get('ownerName'),
                            ownerlocation: doc.get('ownerLocation'),
                            ownerphone: doc.get('ownerPhone'),
                            owneremail: doc.get('ownerEmail'),
                            ownerid: doc.get('id'),
                            age: doc.get('age'),
                            animaltype: doc.get('type'),
                            vaccinated: doc.get('isVaccinated'),
                            sex: doc.get('sex'),
                          ));
                        }
                        return Container(
                          height: 250.h,
                          width: 1.sw,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => Container(
                                    height: 250.h,
                                    width: 200.w,
                                    child: CustomPetCard(
                                      price: petlist[index].price,
                                      name: petlist[index].name,
                                      age: petlist[index].age,
                                      location: petlist[index].ownerlocation,
                                      img: petlist[index].image,
                                      isAdopt: false,
                                      isVacc:
                                          petlist[index].vaccinated == 'true'
                                              ? true
                                              : false,
                                      isFemale: petlist[index].sex == 'Female'
                                          ? true
                                          : false,
                                    ),
                                  ),
                              separatorBuilder: (context, index) => SizedBox(
                                    width: 6,
                                  ),
                              itemCount: snapshot.data!.docs.length),
                        );
                      } else {
                        return Text('no Data');
                      }
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(13),
                      child: Container(
                          width: 0.5.sw,
                          height: 30.h,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: CustomTxtStyle(
                            text: 'Nearby Pets Clinic'.tr(),
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            txtSize: 16,
                          ))),
                    ),
                    CustomTxtStyle(
                        text: 'seeAll'.tr(),
                        txtSize: 16,
                        fontWeight: FontWeight.bold,
                        color: grey),
                  ],
                ),
                Container(
                  width: 1.sw,
                  height: 180.h,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Container(
                          width:180.w ,
                          height: 180.h,
                          child: CustomVetCard()),
                      itemCount: 5),
                ),
              ],
            ),
          ),
        ],
      ),
    );

  }
}
