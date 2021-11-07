import 'package:flutter/cupertino.dart';

class LangProv extends ChangeNotifier{

  bool isRight=false;

  isChanged(){
    isRight=!isRight;
    notifyListeners();
  }
}