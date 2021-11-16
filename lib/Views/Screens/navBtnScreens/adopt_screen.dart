import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:petsadoption/Views/Screens/all_vet_screen.dart';
import 'package:petsadoption/Views/Screens/pet_details.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:petsadoption/Views/Widgets/custom_iconBTN.dart';
import 'package:petsadoption/Views/Widgets/custom_petCard.dart';
import 'package:petsadoption/Views/Widgets/custom_txtStyle.dart';
import 'package:petsadoption/Views/Widgets/custom_vet_card.dart';
import 'package:petsadoption/constants.dart';
import 'package:petsadoption/controller/auth.dart';
import 'package:petsadoption/controller/provider/langProv.dart';
import 'package:petsadoption/controller/store.dart';
import 'package:petsadoption/models/animalImg_model.dart';
import 'package:petsadoption/models/favourite.dart';
import 'package:petsadoption/models/pet_model.dart';
import 'package:petsadoption/models/vet_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../all_animals_screen.dart';
import '../vet_details.dart';

class AdoptMe extends StatefulWidget {
  @override
  _AdoptMeState createState() => _AdoptMeState();
}

class _AdoptMeState extends State<AdoptMe> {
  var userUid;

  String? animalName;
  bool isarab = false;

   bool isFav = false;

  Auth auth = Auth();
  static final List<AnimalModel> animalImg = [
    AnimalModel(img: 'images/icons8-dog-64 (1).png', name: 'Dog'),
    AnimalModel(img: 'images/icons8-cat-64.png', name: 'Cat'),
    AnimalModel(img: 'images/icons8-fish-40.png', name: 'Fish'),
    AnimalModel(img: 'images/icons8-turtle-64.png', name: 'Turtle'),
    AnimalModel(img: 'images/icons8-chick-60 (2).png', name: 'Bird'),
  ];
  Store store = Store();
  List<PetModel> petlist = [];
  List<VetModel> vetlist = [];


  List<bool> clicck = List.filled(animalImg.length, false);

  var nm2;
  var city;
  getuser()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    nm2= pref.getString('userName');
    city= pref.getString('userCity');




  }

  @override
  void initState() {
    super.initState();

    clicck[0] = true;
    animalName = 'Dog';
    getuser();

    print(city);
    print(nm2);

  }

  @override
  Widget build(BuildContext context) {
getuser();
print(city);
print(nm2);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
            future: getuser(),
            builder: (builder,snapshot)=>
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
                              text: nm2==null?'':nm2,
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
                                      showDialog(
                                          context: context,
                                          builder: (builder) => SimpleDialog(
                                                title: CustomTxtStyle(
                                                    text: 'Choose a language...',
                                                    color: grey,
                                                    fontWeight: FontWeight.bold),
                                                children: [
                                                  SimpleDialogOption(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              isarab = true;
                                                            });
                                                          },
                                                          child: CustomTxtStyle(
                                                            text: 'عربي',
                                                            color: grey,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          style: ButtonStyle(
                                                              backgroundColor: MaterialStateProperty
                                                                  .resolveWith((states) =>
                                                                      isarab ==
                                                                              false
                                                                          ? Colors
                                                                              .white
                                                                          : primaryColor)),
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              isarab = false;
                                                            });
                                                          },
                                                          child: CustomTxtStyle(
                                                              text: 'English',
                                                              color: grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          style: ButtonStyle(
                                                              backgroundColor: MaterialStateProperty
                                                                  .resolveWith((states) =>
                                                                      isarab ==
                                                                              false
                                                                          ? primaryColor
                                                                          : Colors
                                                                              .white)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SimpleDialogOption(
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        if (isarab) {
                                                          context.setLocale(
                                                              Locale('ar'));
                                                          Provider.of<LangProv>(
                                                                  context,
                                                                  listen: false)
                                                              .isChanged();
                                                        } else {
                                                          context
                                                              .setLocale(Locale(
                                                            'en',
                                                          ));
                                                        }

                                                        Navigator.pop(context);
                                                      },
                                                      child: CustomTxtStyle(
                                                          text: 'Done',
                                                          color: grey,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      style: ButtonStyle(),
                                                    ),
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
                              text:city==null?'':city,
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
                                         store.getAllAnimals(animalName);
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
                    stream: store.getAllAnimals(animalName),
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
                              itemBuilder: (context, index){

                                  return Container(
                                    height: 250.h,
                                    width: 200.w,
                                    child: InkWell(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PetDetails(petlist[index]))),
                                      child:
                                      CustomPetCard(
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
                                        isFav: isFav ,
                                        iconTap:(){
                                          setState(() {
                                            isFav=!isFav;
                                            if(isFav){
                                              store.addFav(petlist[index]);
                                            } else if(isFav==false){
                                              store.removeFav(petlist[index]);
                                            }
                                          });
                                        } ,
                                      ),
                                    ),
                                  );}

                                ,
                              separatorBuilder: (context, index) => SizedBox(
                                    width: 6,
                                  ),
                              itemCount: snapshot.data!.docs.length),
                        );
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: primaryColor,
                            ),
                            CustomTxtStyle(
                              text: 'Check your internet connection',
                            )
                          ],
                        );
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
                            text: 'Nearby Pet Store'.tr(),
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            txtSize: 16,
                          ))),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, AllVetScreen.id);
                      },
                      child: CustomTxtStyle(
                          text: 'seeAll'.tr(),
                          txtSize: 16,
                          fontWeight: FontWeight.bold,
                          color: grey),
                    ),
                  ],
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: store.getVetsByLocation(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        getuser();
                        for (var doc in snapshot.data!.docs) {

                         // if(doc.get('LocationCity')==city){
                            vetlist.add(VetModel(
                              locationLink: doc.data().toString(),
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
                            ));
                       //   }


//                          else{
//                            return Padding(
//                              padding: const EdgeInsets.all(10.0),
//                              child: Center(child: CustomTxtStyle(
//                                text: 'There is no Nearby Pet Store  Click on see all',
//                                fontWeight: FontWeight.bold,
//                                color: grey,
//                              )),
//                            );
//                          }


                        }

                        return


                          Container(
                          width: 1.sw,
                          height: 180.h,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>VetDetails(vetlist[index])));
                                },
                                child: Container(
                                    width: 180.w,
                                    height: 180.h,
                                    child: CustomVetCard(
                                          img: vetlist[index].image,
                                          city: vetlist[index].city,
                                          type: vetlist[index].type,

                                    )),
                              ),
                              itemCount:snapshot.data!.docs.length ),
                        );

                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: primaryColor,
                            ),
                            CustomTxtStyle(
                              text: 'Check your internet connection',
                            )
                          ],
                        );
                      }
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
