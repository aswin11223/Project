import 'package:flutter/foundation.dart';

class Logorreg extends ChangeNotifier{

  bool showloginpage=true; 
  void togglepages(){
    showloginpage=showloginpage;
    notifyListeners();

  }
}