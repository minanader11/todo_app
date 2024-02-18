import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier
{

  ThemeMode themeMode=ThemeMode.light;
  void changeTheme(ThemeMode newTheme){
    if(newTheme== themeMode){
      return;
    }
    themeMode=newTheme;
    notifyListeners();
  }

}