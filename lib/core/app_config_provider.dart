
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigProvider extends ChangeNotifier
{

  ThemeMode themeMode=ThemeMode.light;
  String language='en';
  void changeLanguage(String newLanguage)async {
    language=newLanguage;
    notifyListeners();
    SharedPreferences prefs= await SharedPreferences.getInstance();
    prefs.setString('lang', newLanguage);
  }
  Future<void> getLang()async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    String? lang =prefs.getString('lang');
    if(lang != null){
      language=lang;
      notifyListeners();
    }
  }
  void changeTheme(String theme)async{
    if(theme== 'Light'||theme== 'مضئ'){
      themeMode=ThemeMode.light;
      SharedPreferences prefs= await SharedPreferences.getInstance();
      prefs.setBool("isDark", false);
    }else{
      themeMode=ThemeMode.dark;
      SharedPreferences prefs= await SharedPreferences.getInstance();
      prefs.setBool("isDark", true);
    }

    notifyListeners();
  }
  Future<void> getTheme()async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    bool? theme =prefs.getBool('isDark');
    if(theme != null){
     if(theme == true){
       themeMode= ThemeMode.dark;
     }else{
       themeMode=ThemeMode.light;
     }
    }
  }
}