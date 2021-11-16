import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
class Auth{
   String?city;
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
   var name2=auth.currentUser!.displayName;
   var id2=auth.currentUser!.uid;
   var email2=auth.currentUser!.email;


   SharedPreferences pref=await SharedPreferences.getInstance();
   pref.setString('userUid', u.user!.uid);
   pref.setString('userCity', '${getLocation()}');
   pref.setString('userPhone', '${u.user!.phoneNumber}');
   pref.setString('userEmail', '${u.user!.email}');
   pref.setString('userName', '${u.user!.displayName}');

   pref.setString('userEmail2', email2!);
   pref.setString('userName2', name2!);
   pref.setString('userUid2', id2);


  }
  signIn(email,password)async{
  getLocation();
    var userUid=await auth.signInWithEmailAndPassword(email: email, password: password);
   await auth.currentUser!.sendEmailVerification();

   SharedPreferences pref=await SharedPreferences.getInstance();

    pref.setString('userUid', userUid.user!.uid);
     pref.setString('userCity', city!);
   // pref.setString('userPhone', userUid.user!.phoneNumber.toString());
   // pref.setString('userEmail', userUid.user!.email.toString());
   // pref.setString('userName', userUid.user!.displayName.toString());


  }
  forgetPass(email)async{
   await auth.sendPasswordResetEmail(email: email);
  }
  signOut()async{
    await auth.signOut();
    SharedPreferences pref=await SharedPreferences.getInstance();
    pref.setString('userUid', '');
    pref.setString('userCity', '');
    pref.setString('userPhone', '');
    pref.setString('userEmail', '');
    pref.setString('userName', '');

    // await auth.currentUser.emailVerified
  }

    Future<UserCredential> signInWithGoogle() async {
    getLocation();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

     var userUid= await FirebaseAuth.instance.signInWithCredential(credential);
      SharedPreferences pref=await SharedPreferences.getInstance();
      pref.setString('userUid', userUid.user!.uid);
     pref.setString('userCity', city!);
    pref.setString('userPhone', userUid.user!.phoneNumber.toString());
      pref.setString('userEmail', userUid.user!.email.toString());
     pref.setString('userName', userUid.user!.displayName.toString());
      await firestore.collection('users').doc(userUid.user!.uid).set({
        'email':userUid.user!.email,
        'name':userUid.user!.displayName,
        'phone':userUid.user!.phoneNumber,
        'location':city!,
        'id':userUid.user!.uid,
      });

      return userUid;

  }


  getLocation()async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);


      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
        city=placemarks[0].administrativeArea.toString();


  }

}
