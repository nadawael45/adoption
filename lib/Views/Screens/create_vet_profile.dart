import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:petsadoption/Views/Widgets/custom_btn.dart';
import 'package:petsadoption/Views/Widgets/custom_category.dart';
import 'package:petsadoption/Views/Widgets/custom_pe_profileCard.dart';
import 'package:petsadoption/Views/Widgets/custom_scaffold.dart';
import 'package:petsadoption/Views/Widgets/custom_txtStyle.dart';
import 'package:petsadoption/controller/store.dart';
import 'package:petsadoption/models/vet_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class CreateVetProfile extends StatefulWidget {
  static String id = 'createvetprof';

  @override
  _CreateVetProfileState createState() => _CreateVetProfileState();
}

class _CreateVetProfileState extends State<CreateVetProfile> {
var name;
var email;
var phone;
var id;
var city;
  Store store = Store();

  bool petShop = false;
  bool vetClinic = false;
  bool heightBool = true;

  var type ;
  String? imageUrl;
  File? pickedImg;

  TextEditingController nameCon = TextEditingController();
  TextEditingController locationLinkCon = TextEditingController();
  TextEditingController locationCon = TextEditingController();
  TextEditingController descCon = TextEditingController();
  TextEditingController phoneCon = TextEditingController();
  TextEditingController faceCon = TextEditingController();

  bool loading = false;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  isVisible() {
    if (petShop == true || vetClinic == true) {
      return true;
    } else {
      return false;
    }
  }

  pickFromCamera() async {
    var img = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      pickedImg = File(img!.path);
    });
  }

  pickFromGallery() async {
    var img = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      pickedImg = File(
        img!.path,
      );
    });
  }

  uploadImageFireBase(id) async {
    FirebaseStorage storage =
        FirebaseStorage.instanceFor(bucket: 'adopted-pets.appspot.com');
    Reference ref = storage.ref().child('clinicImg').child(id);
    await ref.putFile(pickedImg!).whenComplete(() => null);
    imageUrl = await ref.getDownloadURL();
  }
var result;
getuser()async{
  SharedPreferences pref=await SharedPreferences.getInstance();
  name= pref.getString('userName');
  city= pref.getString('userCity');
  email= pref.getString('userEmail');
  id= pref.getString('userUid');





}
String? admin;
isAdmin()async{

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentSnapshot  snapshot=
  await firestore.collection('users').doc(id).get();
   admin=snapshot.get('isAdmin');
  return snapshot;

}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuser();
    isAdmin();

}
@override
  Widget build(BuildContext context) {
  getuser();
  print(id);
  print(admin);
    return SafeArea(
      child: CustomScaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackButton(
            color: primaryColor,
          ),
          title: CustomTxtStyle(
            text: 'Create pet Store',
            color: grey,
            fontWeight: FontWeight.bold,
            txtSize: 18,
          ),
          centerTitle: false,
        ),
        body:
        FutureBuilder(
        future: isAdmin(),
  builder: (context, snapshot) => snapshot.hasData
  ? admin=='true'?
        ModalProgressHUD(
          inAsyncCall: loading,
          progressIndicator:SpinKitWave(color: primaryColor,) ,

          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                CustomTxtStyle(
                  text: 'Do You Want To Create...',
                  fontWeight: FontWeight.bold,
                  txtSize: 22,
                  color: grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: CustomBtn(
                      labelText: 'Pet Shop',
                      color: petShop ? primaryColor : Colors.white,
                      colorTxt: grey,
                      size: 16,
                      onTap: () {
                        setState(() {
                          vetClinic = false;
                          petShop = !petShop;
                          type = 'Pet Shop';
                        });
                      },
                    )),
                    CustomTxtStyle(
                      text: 'OR',
                      fontWeight: FontWeight.bold,
                      txtSize: 22,
                      color: grey,
                    ),
                    Expanded(
                        child: CustomBtn(
                      labelText: 'Vet Clinic',
                      color: vetClinic ? primaryColor : Colors.white,
                      colorTxt: grey,
                      size: 16,
                      onTap: () {
                        setState(() {
                          petShop = false;
                          vetClinic = !vetClinic;
                          type = 'Vet Clinic';
                        });
                      },
                    )),
                  ],
                ),
                Visibility(
                    visible: isVisible(),
                    child: Form(
                      key: key,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 35, left: 35, bottom: 10),
                            child: Divider(
                              color: grey,
                              thickness: 1,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (builder) => SimpleDialog(
                                        title: CustomTxtStyle(
                                          text: 'Select...',
                                          color: grey,
                                        ),
                                        children: [
                                          SimpleDialogOption(
                                            child: CustomTxtStyle(
                                              text: 'Pick From Camera',
                                              color: grey,
                                              fontWeight: FontWeight.normal,
                                              txtSize: 16,
                                            ),
                                            onPressed: pickFromCamera,
                                          ),
                                          SimpleDialogOption(
                                            child: CustomTxtStyle(
                                              text: 'Pick From Gallery',
                                              color: grey,
                                              fontWeight: FontWeight.normal,
                                              txtSize: 16,
                                            ),
                                            onPressed: pickFromGallery,
                                          ),
                                        ],
                                      ));
                            },
                            child: CircleAvatar(

                              radius: 60.r,
                              backgroundColor: Colors.white,
                              child: pickedImg == null
                                  ? Icon(
                                      Icons.add_a_photo,
                                      color: iconPink,
                                    )
                                  : Image.file(pickedImg!),

                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                CustomPetProfile(
                                  txtSize: 16,
                                  hinTxt: petShop
                                      ? 'Your Pet Shop Name'
                                      : 'Your Clinic Name',
                                  width: 0.75.sw,
                                  heightBool: heightBool,
                                  controller: nameCon,
                                  validate: (v) {
                                    if (nameCon.text.isEmpty) {
                                      setState(() {
                                        heightBool = false;
                                      });
                                      return 'Enter name';
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomPetProfile(
                                  txtSize: 16,
                                  width: 0.75.sw,
                                  hinTxt: 'Add Phone',
                                  heightBool: heightBool,
                                  icon: Icon(Icons.add_call, color: iconPink),
                                  controller: phoneCon,
                                  validate: (v) {
                                    if (phoneCon.text.isEmpty) {
                                      setState(() {
                                        heightBool = false;
                                      });
                                      return 'Enter phone';
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomPetProfile(
                                  txtSize: 16,
                                  width: 0.75.sw,
                                  hinTxt: 'Goole Map Link',
                                  heightBool: heightBool,
                                  icon: Icon(Icons.location_on, color: iconPink),
                                  controller: locationLinkCon,
                                  validate: (v) {
                                    if (locationLinkCon.text.isEmpty) {
                                      setState(() {
                                        heightBool = false;
                                      });
                                      return 'Enter your  location link';
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomPetProfile(
                                  txtSize: 16,
                                  width: 0.75.sw,
                                  hinTxt: 'Describe Location',
                                  icon:
                                      Icon(Icons.location_city, color: iconPink),
                                  controller: locationCon,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomPetProfile(
                                  txtSize: 16,
                                  width: 0.75.sw,
                                  hinTxt: 'FaceBook Link',
                                  controller: faceCon,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTxtStyle(
                            text: 'Add Description...',
                            fontWeight: FontWeight.bold,
                            txtSize: 22,
                            color: grey,
                          ),
                          CustomPetProfile(
                            txtSize: 15,
                            width: 0.75.sw,
                            hinTxt: ' Surgery, Xray, Lab, hotel',
                            controller: descCon,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: CustomBtn(
                              labelText: 'Submit',
                              onTap: () async {
//                                if(imageUrl!.isEmpty){
//                                  ScaffoldMessenger.of(context)
//                                      .showSnackBar(SnackBar(
//                                    content: Text(
//                                      'You must add image',
//                                      style: TextStyle(color: Colors.white),
//                                    ),
//                                    backgroundColor: iconPink,
//                                  ));                                }else{
                                  if (key.currentState!.validate()) {
                                    try {
                                      setState(() {
                                        loading = true;
                                      });
                                      await uploadImageFireBase(DateTime.now().toString());
                                      await getuser();
                                      SharedPreferences pref=await SharedPreferences.getInstance();
                                      pref.setBool('isClinic', type=='Vet Clinic'?true:false);
                                      pref.setString('clinicName',nameCon.text );
                                      pref.getString('clinicName' );


                                      store.sendVetData(VetModel(
                                          location: locationCon.text,
                                          locationLink: locationLinkCon.text,
                                          faceLink: faceCon.text,
                                          clinicname: nameCon.text,
                                          image: imageUrl,
                                          name: name,
                                          phone: phoneCon.text,
                                          type: type,
                                          email:email ,
                                          id:id,
                                          city:city,
                                          description: descCon.text));
                                    } catch (e) {
                                      setState(() {
                                        loading = false;
                                      });
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text(e.toString())));
                                    }
                                    setState(() {
                                      loading = false;
                                    });
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        'Done',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: iconPink,
                                    ));
                                    faceCon.text = '';
                                    phoneCon.text = '';
                                    nameCon.text = '';
                                    type = '';
                                    pickedImg = null;
                                    descCon.text = '';
                                    locationLinkCon.text = '';
                                    locationCon.text = '';
                                    nameCon.text = '';
                                  }else{
                                    setState(() {
                                      loading = false;
                                    });
                                  }
                               // }


                              },
                            ),
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ),
        )
  :
  Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          color: primaryColor,
        ),
        SizedBox(height: 20,),
        CustomTxtStyle(text:'you are not admin \n Please contact us',color: grey,fontWeight: FontWeight.bold,txtSize:18 ,),
      ],
    ),
  )
  : Center(
    child: Column(
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
    ),
  )
      ),
      ));
  }
}
