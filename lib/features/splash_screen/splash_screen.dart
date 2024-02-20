import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/app_config_provider.dart';
import 'package:todo_app/features/Home/presentation/manager/task_provider.dart';
import 'package:todo_app/features/Home/presentation/views/home_screen.dart';

class SplashScreen extends StatefulWidget {
 static const routeName='splash_Screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3), // Change the duration as needed
          () {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
  var configProvider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
        body: configProvider.themeMode== ThemeMode.light? Image.asset('assets/images/splash_Screen.png',fit:BoxFit.fill,height: double.infinity,width: double.infinity,):Image.asset('assets/images/splash_screen_dark.png',fit:BoxFit.fill,height: double.infinity,width: double.infinity,)
    );
  }
}
