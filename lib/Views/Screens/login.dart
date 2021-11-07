import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:petsadoption/Views/Screens/Sign_up.dart';
import 'package:petsadoption/Views/Screens/forget_passworg.dart';
import 'package:petsadoption/Views/Widgets/customTextFormField.dart';
import 'package:petsadoption/Views/Widgets/custom_btn.dart';
import 'package:petsadoption/Views/Widgets/custom_iconBTN.dart';
import 'package:petsadoption/Views/Widgets/custom_txtStyle.dart';
import 'package:petsadoption/constants.dart';
import 'package:petsadoption/controller/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';
class Login extends StatefulWidget {
  static String id='login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  GlobalKey<FormState> key= GlobalKey<FormState>();
  Auth auth=Auth();
 bool loading=false;
  bool check=false;
  TextEditingController controllerPass=TextEditingController();
  TextEditingController controllerEmail=TextEditingController();
checkSigned()async{
  SharedPreferences pref=await SharedPreferences.getInstance();
  pref.getBool('signed');
}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //checkSigned ();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: loading,
        progressIndicator:SpinKitWave(color: primaryColor,) ,
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap:() {
              FocusScope.of(context).unfocus();
            },
            child: Column(
              children: [
                SizedBox(height: 20.h,),
                Hero(
                  tag: 'sign',
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: double.infinity,
                    child: Image.asset('images/cat.png',
                        fit: BoxFit.contain,
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: double.infinity),
                  ),
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
                              text:'Log-in',txtSize: 37,fontWeight: FontWeight.bold,color: primaryColor),
                          Form(key:key,child: Column(children: [
                            CustomTextFormField(
                            labelText: 'Email',
                              txtType: TextInputType.emailAddress,
                            hintText: 'Enter e-mail',
                            controller: controllerEmail,
                              validate: (v){

                                    if(v.isEmpty){

                                  print('please Enter Name');
                                  return 'please Enter Name';
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

                                if(v.isEmpty){

                                  return 'please Enter Password';
                                }

                              },
                              suffix: check==false? Icons.remove_red_eye: Icons.visibility_off,
                              function:(){
                                setState(() {
                                  check=!check;
                                });
                              }
                              ,
                              obscureTxt:check ,
                            ),],),),


                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: ()=>Navigator.popAndPushNamed(context, ForgotPass.id),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: CustomTxtStyle(text:'forgot password?', txtSize: 16,fontWeight: FontWeight.normal,
                                      color:  Colors.grey.shade700)
                                ),
                              ),
                            ],
                          ),

                          CustomBtn(
                            labelText: 'Login',
                              onTap: ()async{
                                if(key.currentState!.validate()){
                                  try{
                                    setState(() {
                                      loading=true;

                                    });
                                    FirebaseAuth fauth =FirebaseAuth.instance;

                                    await auth.signIn(controllerEmail.text, controllerPass.text);
                                    SharedPreferences pref=await SharedPreferences.getInstance();
                                    setState(() {
                                      pref.setBool('signed',true);
                                      pref.setString('userUid',fauth.currentUser!.uid);

                                    });
                                    Navigator.popAndPushNamed(context, HomePage.id);
                                  }catch(e){
                                    setState(() {
                                      loading=false;

                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                                  }

                                }else{
                                  loading=false;
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('please enter data')));
                                }
                                }
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomTxtStyle(text:'Don\'t have account?',  txtSize: 16,fontWeight: FontWeight.normal,
                                  color:  Colors.grey.shade700),
                              InkWell(
                                onTap: ()=>Navigator.popAndPushNamed(context, SignUp.id) ,
                                child: CustomTxtStyle(text:' SignUp', txtSize: 16,fontWeight: FontWeight.normal,
                                    color:  Colors.grey.shade700)
                              ),

                            ],
                          ),
                          SizedBox(height: 20,),
                          Row(
                            children: [

                              Expanded(child: Divider(color:Colors.grey.shade700 ,height: 1,)),
                              Expanded(
                                child: CustomTxtStyle(text:'  Or login with', txtSize: 16,fontWeight: FontWeight.normal,
                                    color:  Colors.grey.shade700)
                              ),

                              Expanded(child: Divider(color:Colors.grey.shade700 ,height: 1,)),


                            ],
                          ),
                          SizedBox(height: 20,),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                            CustomIconBtn(onPressed: (){},icon:Image.asset('images/facebook.png',width: 25,height: 25,)),
                            CustomIconBtn(onPressed: ()async{
                              try {
                                setState(() {
                                  loading=true;

                                });

                                await auth.signInWithGoogle();
                                SharedPreferences pref=await SharedPreferences.getInstance();
                                setState(() {
                                  pref.setBool('signed',true);


                                });
                                Navigator.popAndPushNamed(context, HomePage.id);

                              }catch(e){
                                    setState(() {
                                      loading=false;


                                    });
                                print(e);
                              }
                            },icon:Image.asset('images/google.png',width: 25,height: 25,)),

                          ],),
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
