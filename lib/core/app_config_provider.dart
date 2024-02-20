import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier
{

  ThemeMode themeMode=ThemeMode.light;
  String language='en';
  void changeLanguage(String newLanguage){
    language=newLanguage;
    notifyListeners();
  }
  void changeTheme(String theme){
    if(theme== 'Light'||theme== 'مضئ'){
      themeMode=ThemeMode.light;

    }else{
      themeMode=ThemeMode.dark;

    }

    notifyListeners();
  }

}