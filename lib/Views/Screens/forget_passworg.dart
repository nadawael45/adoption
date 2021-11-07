import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petsadoption/Views/Screens/home_screen.dart';
import 'package:petsadoption/Views/Screens/login.dart';
import 'package:petsadoption/Views/Widgets/customTextFormField.dart';
import 'package:petsadoption/Views/Widgets/custom_btn.dart';
import 'package:petsadoption/Views/Widgets/custom_txtStyle.dart';
import 'package:petsadoption/constants.dart';
import 'package:petsadoption/controller/auth.dart';

class ForgotPass extends StatefulWidget {
  static String id ='forgotpass';


  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  Auth auth=Auth();
  TextEditingController controllerEmail=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                        text:  'Forgot Password',txtSize: 37,fontWeight: FontWeight.bold,color: primaryColor),
                      CustomTextFormField(
                        labelText: 'Email',
                        hintText: 'Enter e-mail',
                        controller: controllerEmail,
                        txtType: TextInputType.emailAddress,

                      ),
                      CustomBtn(
                        labelText: 'Submit',

                        onTap: (){
                          if(controllerEmail.text.isEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('please Enter Email')));

                          }else{
                            auth.forgetPass(controllerEmail.text);
                          }
   // Navigator.pushNamed(context, HomePage.id);

    }

                      ),
                      InkWell(
                        onTap: ()=>Navigator.pushNamed(context, Login.id),
                        child: CustomTxtStyle(text:'Back to login',txtSize: 16,fontWeight: FontWeight.normal,
                          color:  Colors.grey.shade700),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
