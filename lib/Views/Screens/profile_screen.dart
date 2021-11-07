import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petsadoption/Views/Widgets/custom_container.dart';
import 'package:petsadoption/Views/Widgets/custom_profileInfo.dart';
import 'package:petsadoption/Views/Widgets/custom_yourPets.dart';
import 'package:petsadoption/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petsadoption/controller/store.dart';
import 'package:petsadoption/controller/user.dart';
import 'package:petsadoption/models/pet_model.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Store store = Store();
  Userid userid=Userid();
  List<PetModel> petlist = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightPink,
      body: ListView(
        children: [
          CustomContainer(
            text: 'Profile Info',
            width: 0.5.sw,
          ),
          CustomProfileInfo(),
          StreamBuilder<QuerySnapshot>(
              stream: store.getAllAnimals(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  for (var doc in snapshot.data!.docs) {
                    petlist.add(PetModel(
                      // doc[userid.getUser()]['name']
                      name: doc.get('name') ,
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
                    width: 1.sw,
                    height: 1.sh,
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) => Container(
                          width: 1.sw,
                          height: 100.h,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CustomYourPets(
                              color: petlist[index].color,
                              weight: petlist[index].weight,
                              age: petlist[index].age,
                              location: petlist[index].ownerlocation,
                              img: petlist[index].image,
                            ),
                          ),
                        )),
                  );
                } else {
                  return Text('no Data');
                }
              }),
        ],
      ),
    );
  }
}
