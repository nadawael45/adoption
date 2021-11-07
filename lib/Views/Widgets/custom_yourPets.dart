import 'package:flutter/material.dart';
import 'package:petsadoption/Views/Widgets/custom_iconBTN.dart';
import '../../constants.dart';
import 'custom_txtStyle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomYourPets extends StatelessWidget {
  String?img;
  String?age;
  String?color;
  String?weight;
  String?location;
  IconData? icon;
  var deleteFunc;
  var editFunc;


  CustomYourPets({this.img, this.age, this.weight, this.location, this.icon,this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(children: [
          CircleAvatar(backgroundImage: NetworkImage(img!),radius: 35,),
          SizedBox(width: 6,),
          Expanded(
            child: Center(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [


                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.location_city,color: iconPink,size: 20,),
                      CustomTxtStyle(text:location!+' | ',txtSize: 16, fontWeight:FontWeight.normal,color: Colors.grey),
                      CustomTxtStyle(text: color!+' | ',txtSize: 16, fontWeight:FontWeight.normal,color: Colors.grey),
                      CustomTxtStyle(text:age!+' | ',txtSize: 16, fontWeight:FontWeight.normal,color: Colors.grey),
                      CustomTxtStyle(text:weight!+' | ',txtSize: 16, fontWeight:FontWeight.normal,color: Colors.grey),
                      Icon(icon,color: iconPink,size: 20,),
                      Spacer(),
                      Row(mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          PopupMenuButton(
                              color: Colors.white,
                              
                              itemBuilder: (context)
                              {
                                return [
                                  PopupMenuItem(child:
                                  InkWell(
                                      onTap: ()
                                      {
                                      },
                                      child: Text('Edit')),),
                                  PopupMenuItem(child:
                                  InkWell(
                                      onTap: (){
                                      },
                                      child: Text('Delete'))),





                                ];
                              }),
                        ],
                      ),
    ]
                  ),
                ),

              ],),
            ),
          )
        ],),
      ),
    );
  }
}
