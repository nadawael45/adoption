import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth{
  FirebaseAuth auth =FirebaseAuth.instance;
  FirebaseFirestore firestore =FirebaseFirestore.instance;


  signUp(email,password,phone,location,name)async{
   var u= await auth.createUserWithEmailAndPassword(email: email, password: password);
    await auth.currentUser!.sendEmailVerification();
    await firestore.collection('users').doc(u.user!.uid).set({
       'email':email,
      'name':name,
      'phone':phone,
      'location':location,
      'id':u.user!.uid,
    });

  }
  signIn(email,password)async{
    await auth.signInWithEmailAndPassword(email: email, password: password);
    await auth.currentUser!.sendEmailVerification();
    var userUid=auth.currentUser!.uid;
    SharedPreferences pref=await SharedPreferences.getInstance();
    pref.setString('userUid', userUid);
    print(userUid);
  }
  forgetPass(email)async{
   await auth.sendPasswordResetEmail(email: email);
  }
  signOut()async{
    await auth.signOut();
   // await auth.currentUser.emailVerified
  }

    Future<UserCredential> signInWithGoogle() async {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      var userUid=auth.currentUser!.uid;
      SharedPreferences pref=await SharedPreferences.getInstance();
      pref.setString('userUid', userUid);
      print(userUid);

      return await FirebaseAuth.instance.signInWithCredential(credential);

  }

  getuserId(){
//    String? id;
//    SharedPreferences pref=await SharedPreferences.getInstance();
//    id=pref.getString('userUid');
    FirebaseFirestore firestore =FirebaseFirestore.instance;
    return firestore.collection('users').snapshots();
  }

}
