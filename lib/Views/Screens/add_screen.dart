import 'package:flutter/material.dart';
import 'package:petsadoption/Views/Widgets/custom_addCard.dart';
import 'package:petsadoption/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'adopt_screen.dart';
import 'cereate_pet_profile.dart';
class AddScreen extends StatelessWidget {
  String text1='Adopet A pet';
  String text2='We have the cutest pets available all waiting you to make you their new friend';
  String text3='Create Pet Profile';
  String text4='You already have a pet and you want to sell it or  give it to someone who will care for it';
  String text5='You are a Veterinarian';
  String text6='Do you want to join our team? complete the form to make people easily find you '
      'But firstly you have to verify your account';
  String text7='Monitor Your pet';
  String text8='We have best doctors for you with the best offers search for the nearest clinic ';



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: lightPink,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              InkWell(
                  child: CustomAddCard(text1, text2, 'images/undraw_friends_r511.png')),
              SizedBox(height: 15,),
                InkWell(onTap: (){Navigator.pushNamed(context, CreatePetProfile.id);},
                    child: CustomAddCard(text3, text4, 'images/undraw_pet_adoption_2qkw.png')),
                SizedBox(height: 15,),
                CustomAddCard(text5, text6, 'images/vetclinic.jpg'),
                SizedBox(height: 15,),
                CustomAddCard(text7, text8, 'images/doctor.jpg'),


            ],),
          ),
        ),
      ),
    );
  }
}
