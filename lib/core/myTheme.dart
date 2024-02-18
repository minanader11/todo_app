import 'dart:ui';

import 'package:flutter/material.dart';

class MyTheme {
  static const primaryColor = Color(0xff5D9CEC);
  static const whiteColor = Color(0xffFFFFFF);
  static const greyColor = Color(0xffC8C9CB);
  static const greenColor = Color(0xff61E757);
  static const backgroundColorLight = Color(0xffDFECDB);
  static const blackColor = Color(0xff141922);
  static const redColor = Color(0xffEC4B4B);
  static const backgroundColorDark = Color(0xff060E1E);
  static ThemeData lightMode = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: whiteColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: blackColor,
      ),
      bodySmall:TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: blackColor,
      ),
    ),
    scaffoldBackgroundColor: backgroundColorLight,
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(selectedItemColor: primaryColor,backgroundColor: Colors.transparent,elevation: 0),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      shape: StadiumBorder(
        side: BorderSide(
          color: whiteColor,
          width: 4,
        ),
      ),
    ),
  );
}
