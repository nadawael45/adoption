import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Userid{
  FirebaseFirestore firestore =FirebaseFirestore.instance;

  getUser()async {
    SharedPreferences pref=await SharedPreferences.getInstance();
    var userUid=pref.getString('userUid');
    return userUid;
   // firestore.collection('users').doc(id).snapshots();

  }
}