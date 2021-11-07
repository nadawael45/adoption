import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:petsadoption/Views/Screens/Sign_up.dart';
import 'package:petsadoption/Views/Widgets/customTextFormField.dart';
import 'package:petsadoption/Views/Widgets/custom_btn.dart';
import 'package:petsadoption/Views/Widgets/custom_iconBTN.dart';
import 'package:petsadoption/Views/Widgets/custom_txtStyle.dart';
import 'package:petsadoption/controller/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import 'home_screen.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  static String id ='signup';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
   GlobalKey<FormState> key= GlobalKey<FormState>();
  Auth auth=Auth();
  bool check= false;
   bool loading=false;

   TextEditingController controllerPass=TextEditingController();
  TextEditingController controllerEmail=TextEditingController();
  TextEditingController controllerPhone=TextEditingController();
  TextEditingController controllerName=TextEditingController();
   TextEditingController controllerLocation=TextEditingController();

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: loading,
        progressIndicator:SpinKitWave(color: primaryColor,) ,
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap:(){
              FocusScope.of(context).unfocus();
            },
            child: Column(
              children: [
                SizedBox(height: 20.h,),
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: double.infinity,
                  child: Image.asset('images/cat.png',
                      fit: BoxFit.contain,
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: double.infinity),
                ),

                Card(
                    elevation: 11,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.r))),
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        children: [
                          CustomTxtStyle(
                            text:  'Sign-up', txtSize:37, fontWeight:FontWeight.bold, color:primaryColor),
                          Form(key:key ,child: Column(children: [
                            CustomTextFormField(
                              txtType: TextInputType.name,

                              labelText: 'Name',
                              hintText: 'Enter name',
                              controller: controllerName,
                             validate: (v){
                                if(v.toString().isEmpty){

                                  return 'please Enter Name';
                                }

                              },
                            ),
                            SizedBox(height: 5,),
                            CustomTextFormField(
                              txtType: TextInputType.phone,


                              labelText: 'Phone no.',
                              hintText: 'Enter phone no.',
                              controller: controllerPhone,
                              validate: (v){
                                if(v.toString().isEmpty){

                                  return 'please Enter Phone no.';
                                }
                              },
                            ),
                            SizedBox(height: 5,),
                            CustomTextFormField(
                              txtType: TextInputType.multiline,


                              labelText: 'Location',
                              hintText: 'Enter city Name',
                              controller: controllerLocation,
                              validate: (v){
                                if(v.toString().isEmpty){


                                  return 'please Enter location ';
                                }
                              },
                            ),
                            SizedBox(height: 5,),
                            CustomTextFormField(
                              txtType: TextInputType.emailAddress,
                              labelText: 'Email',
                              hintText: 'Enter e-mail',
                              controller: controllerEmail,
                              validate: (v){
                                if(v.toString().isEmpty){

                                  return 'please Enter Email';
                                }
                              },

                            ),
                            SizedBox(height: 5,),
                            CustomTextFormField(
                              txtType: TextInputType.visiblePassword,
                              labelText: 'Password',
                              hintText: 'Enter password',
                              controller: controllerPass,
                              validate: (v){
                                if(v.toString().isEmpty){

                                  return 'please Enter Password';
                                }},
                              suffix: check==false? Icons.remove_red_eye: Icons.visibility_off,
                              function:() {
                                setState(() {
                                  check = !check;
                                });
                              },

                              obscureTxt:check ,

                            ),
                          ],)),



                          CustomBtn(
                            labelText: 'Sign-up',
                            onTap: ()async{
                              if(key.currentState!.validate()){
                                try{
                                  setState(() {
                                    loading=true;

                                  });
                                  await auth.signUp(controllerEmail.text, controllerPass.text,controllerPhone.text,controllerLocation.text,controllerName.text);
                                  SharedPreferences pref=await SharedPreferences.getInstance();
                                  pref.setBool('signed',true);
                                  Navigator.popAndPushNamed(context, HomePage.id);
                                }catch(e){
                                  setState(() {
                                    loading=false;

                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                                  print(e);
                                }
                              }else{
                                setState(() {
                                  loading=false;

                                });

                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Enter your data')));
                              }

                            }

                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomTxtStyle(text:'Already have account?', txtSize: 16,fontWeight: FontWeight.normal,
                                  color:  Colors.grey.shade700),
                              InkWell(
                                onTap: ()=>Navigator.popAndPushNamed(context, Login.id) ,
                                child: Hero(
                                  tag: 'sign',
                                  child: CustomTxtStyle(text:' Login', txtSize: 16,fontWeight: FontWeight.normal,
                                      color:  Colors.grey.shade700),
                                ),
                              ),

                            ],
                          ),
                          SizedBox(height: 20,),





                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
