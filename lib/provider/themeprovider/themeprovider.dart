import 'package:flutter/material.dart';
import 'package:flutter_application_8/view/theme/darkmode.dart';
import 'package:flutter_application_8/view/theme/light_mode.dart';

class Themeprovider extends ChangeNotifier{
  ThemeData _themeData=lightmode;
  ThemeData get themedata=>_themeData;
  bool get isdarkmode=>_themeData==darkmode;
  set themdata(ThemeData themdata){
    _themeData=themdata;
    notifyListeners();

  }
  void toggletheme(){
    if(_themeData==lightmode){
  themdata=darkmode;
    }else{
        themdata=lightmode;
    }
    
  }
}