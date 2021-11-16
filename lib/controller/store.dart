import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petsadoption/models/favourite.dart';
import 'package:petsadoption/models/pet_model.dart';
import 'package:petsadoption/models/vet_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Store {

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  var id;
  var city;
  String? animalType;
  String? type2;

  Store({this.animalType, this.type2});

  sendAnimalData(animalType, PetModel petmodel) async {
 //  await getUid();
    await firestore
        .collection('petProfile')
        .doc()
//        .collection('pets')
//        .doc()
        .set(petmodel.toJson());
  }

  getAllAnimals(type2) {
    getUid();
    return firestore
        .collection('petProfile')
        .where('type',isEqualTo: 'Fish')

        .snapshots();
  }




  getMyAnimals() {
   getUid();
    return firestore
        .collection('petProfile')
       // .where('id',isEqualTo: id)
        .snapshots();
  }
  getAllVets() {
    return firestore.collection('vetProfile').snapshots();
  }
  getVetsByLocation() {
    getUid();
    return  firestore.collection('vetProfile').where('LocationCity',isEqualTo: city).snapshots();
  }
  sendVetData(VetModel vetmodel) async {
    await firestore.collection('vetProfile').doc().set(vetmodel.toJson());
  }

//deleteData()async{
//  var userUid = await auth.currentUser!.uid;
//  await firestore.collection('petProfile').doc(userUid).delete();
//}
getUid()async{
  SharedPreferences pref=await SharedPreferences.getInstance();
   id= pref.getString('userUid');
  city= pref.getString('userCity');

}


addFav( PetModel petmodel)async{
    await getUid();
  return  await firestore.collection('users').doc(id).collection('favourites').doc().set(petmodel.toJson());

}
  removeFav( PetModel petmodel)async{
    await getUid();
    return  await firestore.collection('users').doc(id).collection('favourites').doc().delete();

  }
}
