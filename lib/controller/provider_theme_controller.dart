import 'package:flutter/cupertino.dart';

class ProviderThemeController extends ChangeNotifier{

bool isDark=false;


void setDarkTheme(){
  isDark=true;
  notifyListeners();
}


void setLightTheme(){
  isDark=false;
  notifyListeners();
}






}