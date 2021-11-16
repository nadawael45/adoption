import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petsadoption/Views/Screens/pet_details.dart';
import 'package:petsadoption/Views/Widgets/custom_petCard.dart';
import 'package:petsadoption/Views/Widgets/custom_scaffold.dart';
import 'package:petsadoption/Views/Widgets/custom_txtStyle.dart';
import 'package:petsadoption/controller/store.dart';
import 'package:petsadoption/models/pet_model.dart';
import 'package:petsadoption/models/vet_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';

class MyPets extends StatefulWidget {
  static String id='mypets';

  @override
  _MyPetsState createState() => _MyPetsState();
}

class _MyPetsState extends State<MyPets> {
  Store store= Store();
  int? listLength;
  var id;
  getUid()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    id= pref.getString('userUid');
  }
  List<PetModel>petlist=[];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUid();
  }
      @override
      Widget build(BuildContext context) {
        return  CustomScaffold(
          body: StreamBuilder<QuerySnapshot>(
              stream:store.getMyAnimals() ,
              builder: (context,snapshot){
                if(snapshot.hasData){
                  for(var doc in snapshot.data!.docs){
       if(doc.get('id')=='yfye1Efd5BYdvj4ZrN2h7wQy4xl1'){
          petlist.add(PetModel(name: doc.get('name'),
          color: doc.get('color'), birth: doc.get('birthDate'),
          filelink: doc.get('fileLink'), price: doc.get('price'),
          image: doc.get('image'), weight: doc.get('weight'),
          clinicname: doc.get('ClinicName'), locationLink: doc.get('mapLink'),
          ownername: doc.get('ownerName'), ownerlocation: doc.get('ownerLocation'),
          ownerphone: doc.get('ownerPhone'), owneremail: doc.get('ownerEmail'), ownerid: doc.get('id'),
          age: doc.get('age'), animaltype: doc.get('type'), vaccinated: doc.get('isVaccinated'),sex:doc.get('sex'), ));
        }
                }
                  return
                    SingleChildScrollView(

                      child: Container(
                        color: lightPink,

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            SizedBox(height:10 ,),


                            Container(
                              width: 1.sw,
                              height: 1.sh,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
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
                            )
                          ],
                        ),
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

          ),
        );
      }
}
