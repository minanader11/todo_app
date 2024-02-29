import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigProvider extends ChangeNotifier
{
  Future<SharedPreferences> themeModeShared=  SharedPreferences.getInstance();
  Future<SharedPreferences> languageShared= SharedPreferences.getInstance();
  ThemeMode themeMode=ThemeMode.light;
  String language='en';
  void changeLanguage(String newLanguage)async {


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