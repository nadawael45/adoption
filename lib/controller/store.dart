import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petsadoption/models/pet_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Store{
  FirebaseFirestore firestore =FirebaseFirestore.instance;
  FirebaseAuth auth =FirebaseAuth.instance;



 sendData(PetModel petmodel)async{

   SharedPreferences pref=await SharedPreferences.getInstance();
    var userUid=pref.getString('userUid');
   await firestore.collection('petProfile').doc(userUid).set(petmodel.toJson());
 }
 getAllAnimals(){
  return firestore.collection('petProfile').snapshots();

 }
//deleteData()async{
//  var userUid = await auth.currentUser!.uid;
//  await firestore.collection('petProfile').doc(userUid).delete();
//}
}