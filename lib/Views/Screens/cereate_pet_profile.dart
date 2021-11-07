
import 'package:flutter/material.dart';
import 'package:petsadoption/Views/Widgets/custom_btn.dart';
import 'package:petsadoption/Views/Widgets/custom_pe_profileCard.dart';
import 'package:petsadoption/Views/Widgets/custom_txtStyle.dart';
import 'package:petsadoption/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:petsadoption/controller/store.dart';
import 'package:petsadoption/controller/user.dart';
import 'package:petsadoption/models/pet_model.dart';

class CreatePetProfile extends StatefulWidget {
  static String id = 'cretepetprofile';

  @override
  _CreatePetProfileState createState() => _CreatePetProfileState();
}

class _CreatePetProfileState extends State<CreatePetProfile> {
 Store store=Store();

 GlobalKey<FormState> key= GlobalKey<FormState>();

  List<String> radioList = ['Yes', 'No'];
  var indexRadio;
  bool vacc = false;
  bool notVacc = false;
  bool priceVisible = false;

  String ownerEmail='';
 String ownerName='';
 String ownerPhone='';
 String ownerLocation='';
 String ownerClinic='';


 Userid userid = Userid();


 TextEditingController nameCon = TextEditingController();
  TextEditingController ageCon = TextEditingController();
  TextEditingController birthCon = TextEditingController();
  TextEditingController colorCon = TextEditingController();
  TextEditingController fileCon = TextEditingController();
  TextEditingController locationCon = TextEditingController();
 TextEditingController locationLinkCon = TextEditingController();
 TextEditingController sexCon = TextEditingController();
  TextEditingController weightCon = TextEditingController();
  TextEditingController priceCon = TextEditingController();
  TextEditingController typeCon = TextEditingController();

  String petImage = '';
 String isVaccinated = '';

 bool heightBool=true;

 showDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2100),
    );

    setState(() {
      birthCon.text = DateFormat.yMMMd().format(date!).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          color: primaryColor,
        ),
        title: CustomTxtStyle(
          text: 'Create pet Profile',
          color: grey,
          fontWeight: FontWeight.bold,
          txtSize: 18,
        ),
        centerTitle: false,
      ),
      backgroundColor: lightPink,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                      width: 0.5.sw,
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: CustomTxtStyle(
                        text: 'Owner Information',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        txtSize: 16,
                      ))),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.r))),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: primaryColor,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              CustomTxtStyle(
                                  text: 'Nada wael',
                                  txtSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade700),
                              Spacer(),
                              Icon(
                                Icons.edit,
                                color: primaryColor,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Visibility(
                            visible: false,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add_box,
                                  color: primaryColor,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                CustomTxtStyle(
                                    text: 'Petalia Clinic',
                                    txtSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade700),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: primaryColor,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              CustomTxtStyle(
                                  text: 'Kafr EL Sheikh',
                                  txtSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade700),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.phone_android,
                                color: primaryColor,
                              ),
                              CustomTxtStyle(
                                  text: '01095555555',
                                  txtSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade700),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                          width: 0.5.sw,
                          height: 30.h,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: CustomTxtStyle(
                                text: 'Pet Information',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                txtSize: 16,
                              ))),
                    ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: key,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.add_a_photo,
                                  color: iconPink,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: CustomPetProfile(
                                hinTxt: 'Type',
                                width: 0.5.sw,
                                heightBool: heightBool,
                                controller: nameCon,
                                    validate: (v){
                                  if(nameCon.text.isEmpty){
                                    setState(() {
                                      heightBool=false;

                                    });
                                    return 'Enter your animal type';
                                  }
                                    },

                              )),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                Expanded(
                                    child: CustomPetProfile(
                                  hinTxt: 'Choose Animal',
                                  width: 0.5.sw,
                                  txtSize: 13,
                                  icon: PopupMenuButton(
                                    onSelected: (result) {
                                      if (result == 1) {
                                        setState(() {
                                          typeCon.text = 'Dog';
                                        });
                                      }
                                      if (result == 2) {
                                        setState(() {
                                          typeCon.text = 'Cat';
                                        });
                                      }
                                      if (result == 3) {
                                        setState(() {
                                          typeCon.text = 'Fish';
                                        });
                                      }
                                      if (result == 4) {
                                        setState(() {
                                          typeCon.text = 'Turtle';
                                        });
                                      }
                                      if (result == 5) {
                                        setState(() {
                                          typeCon.text = 'Bird';
                                        });
                                      }
                                    },
                                    color: Colors.white,
                                    icon: Icon(Icons.keyboard_arrow_down,
                                        color: iconPink),
                                    itemBuilder: (BuildContext context) {
                                      return [
                                        PopupMenuItem(
                                          value: 1,
//
                                          child: Text('Dog'),
                                        ),
                                        PopupMenuItem(
                                          value: 2,
                                          child: Text('Cat'),
                                        ),
                                        PopupMenuItem(
                                          value: 3,
                                          child: Text('Fish'),
                                        ),
                                        PopupMenuItem(
                                          value: 4,
                                          child: Text('Turtle'),
                                        ),
                                        PopupMenuItem(
                                          value: 5,
                                          child: Text('Bird'),
                                        ),
                                      ];
                                    },
                                  ),
                                  enabled: true,
                                  heightBool: heightBool,
                                  contentPadding: 15,
                                  controller: typeCon,
                                      validate: (v){
                                        if(typeCon.text.isEmpty){
                                          setState(() {
                                            heightBool=false;

                                          });
                                          return 'Choose  animal';
                                        }
                                      },
                                )),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: CustomPetProfile(
                                  hinTxt: 'Date Of Birth',
                                  width: 0.5.sw,
                                  txtSize: 13,
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: iconPink,
                                  ),
                                  enabled: true,
                                  contentPadding: 15,
                                  controller: birthCon,
                                  onTap: showDate,
                                )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                Expanded(
                                    child: CustomPetProfile(
                                  hinTxt: 'Age',
                                  heightBool: heightBool,
                                  width: 0.5.sw,
                                  controller: ageCon,
                                      validate: (v){
                                    if(ageCon.text.isEmpty){
                                      setState(() {
                                        heightBool=false;

                                      });
                                      return 'Enter your animal age';
                                    }
                                      },
                                )),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: CustomPetProfile(
                                  hinTxt: 'Weight',
                                  width: 0.5.sw,
                                  controller: weightCon,
                                )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                Expanded(
                                    child: CustomPetProfile(
                                  hinTxt: 'Color',
                                  width: 0.5.sw,
                                  controller: colorCon,
                                )),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: CustomPetProfile(
                                  hinTxt: 'Gender',
                                  heightBool: heightBool,
                                  width: 0.5.sw,
                                      validate: (v){
                                        if(sexCon.text.isEmpty){
                                          setState(() {
                                            heightBool=false;

                                          });
                                          return 'Choose your animal sex';
                                        }
                                      },
                                  icon: PopupMenuButton(
                                    onSelected: (result) {
                                      if (result == 1) {
                                        setState(() {
                                          sexCon.text = 'Male';
                                        });
                                      }
                                      if (result == 2) {
                                        setState(() {
                                          sexCon.text = 'Female';
                                        });
                                      }
                                    },
                                    color: Colors.white,
                                    icon: Icon(Icons.keyboard_arrow_down,
                                        color: iconPink),
                                    itemBuilder: (BuildContext context) {
                                      return [
                                        PopupMenuItem(
                                          value: 1,
//
                                          child: Text('Male'),
                                        ),
                                        PopupMenuItem(
                                          value: 2,
                                          child: Text('Female'),
                                        ),
                                      ];
                                    },
                                  ),
                                  enabled: true,
                                  controller: sexCon,
                                  onTap: () {},
                                )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
                              height: 50.h,
                              child: Card(
                                elevation: 10,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.all(7),
                                      child: TextButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .resolveWith((states) =>
                                                          vacc == false
                                                              ? Colors.white
                                                              : primaryColor)),
                                          onPressed: () {
                                            setState(() {
                                              notVacc = false;
                                              vacc = !vacc;
                                              isVaccinated='true';

                                            });
                                          },
                                          child: Center(
                                              child: CustomTxtStyle(
                                            text: 'Vaccinated',
                                            color: grey,
                                            fontWeight: FontWeight.bold,
                                            txtSize: 16,
                                          ))),
                                    )),
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.all(7),
                                      child: TextButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .resolveWith((states) =>
                                                          notVacc == false
                                                              ? Colors.white
                                                              : primaryColor)),
                                          onPressed: () {
                                            setState(() {
                                              vacc = false;
                                              notVacc = !notVacc;
                                              isVaccinated='false';
                                            });
                                          },
                                          child: Center(
                                              child: CustomTxtStyle(
                                            text: 'Not Vaccinated',
                                            color: grey,
                                            fontWeight: FontWeight.bold,
                                            txtSize: 16,
                                          ))),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                Expanded(
                                    child: CustomPetProfile(
                                  hinTxt: 'Upload Files',
                                  width: 0.5.sw,
                                  icon: Icon(
                                    Icons.file_upload,
                                    color: iconPink,
                                  ),
                                  controller: fileCon,
                                )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: CustomTxtStyle(
                                text:
                                    '* upload google drive link for animal passport images \n in case of vaccination ',
                                txtSize: 13,
                                fontWeight: FontWeight.normal,
                                color: grey,

                                lines: 2,
                                heightTxt: 1,

                              )),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                Expanded(
                                    child: CustomPetProfile(
                                  hinTxt: 'Add location',
                                  heightBool: heightBool,
                                  icon: Icon(Icons.location_on,
                                      color: iconPink),
                                  controller: locationLinkCon,
                                      validate: (v){
                                        if(locationLinkCon.text.isEmpty){
                                          setState(() {
                                            heightBool=false;

                                          });
                                          return 'Enter your  location link';
                                        }
                                      },
                                )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: CustomTxtStyle(
                                text:
                                    '* upload animal location from goolgle maps  ',
                                txtSize: 13,
                                fontWeight: FontWeight.normal,
                                color: grey,
                                lines: 2,
                                heightTxt: 1,
                              )),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 1.sw,
                            height: 80.h,
                            child: Card(
                              elevation: 10,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    CustomTxtStyle(
                                      text:
                                          'Do you want to show it for adoption with\nfree price?',
                                      txtSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: grey,
                                      lines: 2,
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: 0.5.sw,
                                        height: 50.h,
                                        child: ListView.builder(
                                            itemCount: radioList.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) =>
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Radio(
                                                        activeColor:
                                                            primaryColor,
                                                        value: index,
                                                        groupValue:
                                                            indexRadio,
                                                        onChanged: (v) {
                                                          setState(() {
                                                            indexRadio = v;
                                                            if (radioList[
                                                                    index] ==
                                                                'No') {
                                                              priceVisible =
                                                                  true;
                                                            } else {
                                                              priceVisible =
                                                                  false;
                                                              priceCon.text='free';
                                                            }
                                                          });
                                                        }),
                                                    CustomTxtStyle(
                                                      txtSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: grey,
                                                      text: radioList[index],
                                                    ),
                                                  ],
                                                )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: priceVisible,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Row(
                                children: [
                                  CustomPetProfile(
                                    hinTxt: 'Price',
                                    width: 0.5.sw,
                                    heightBool: heightBool,
                                    controller: priceCon,
                                    validate: (v){
                                      if(priceCon.text.isEmpty){
                                        setState(() {
                                          heightBool=false;

                                        });
                                        return 'Enter the price';
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                        ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: CustomBtn(
                    labelText: 'Submit',
                    onTap:() {
                      if(key.currentState!.validate()) {
                        store.sendData(PetModel(
                          sex: sexCon.text,
                            name: nameCon.text,
                            color: colorCon.text,
                            birth: birthCon.text,
                            filelink: fileCon.text,
                            price: priceCon.text=='free'?'free':'${priceCon.text}'+' LE',
                            image: petImage,
                            weight: weightCon.text,
                            clinicname: ownerClinic,
                            locationLink: locationLinkCon.text,
                            ownername: ownerName,
                            ownerlocation: ownerLocation,
                            ownerphone: ownerPhone,
                            owneremail: ownerEmail,
                            ownerid: userid.getUser(),
                            age: ageCon.text,
                            animaltype: typeCon.text,
                            vaccinated: isVaccinated));

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'Done', style: TextStyle(color: Colors.white),),
                          backgroundColor: iconPink,));
                        colorCon.text = '';
                        birthCon.text = '';
                        priceCon.text = '';
                        weightCon.text = '';
                        ageCon.text = '';
                        typeCon.text = '';
                        petImage = '';
                        isVaccinated = '';
                        locationLinkCon.text = '';
                        fileCon.text = '';
                        nameCon.text = '';
                      }

                    }
                  ),
                ),
              ])),
        ),
      ),
    );
  }

}
