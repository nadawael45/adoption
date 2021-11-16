import 'package:flutter/material.dart';
import 'package:petsadoption/controller/provider/langProv.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class CustomScaffold extends StatelessWidget {
  Widget? body;
  Widget? bottomNav;
  AppBar? appBar;

  CustomScaffold({this.body, this.bottomNav,this.appBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: lightPink,
      bottomNavigationBar:bottomNav ,

      body:Directionality(
          textDirection: Provider.of<LangProv>(context).isRight?TextDirection.rtl:TextDirection.ltr,
          child: body!) ,
    );
  }
}
