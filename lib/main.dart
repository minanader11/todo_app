import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/app_config_provider.dart';
import 'package:todo_app/features/Home/home_screen.dart';
import 'package:todo_app/features/splash_screen/splash_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AppConfigProvider(),)
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var configProvider = Provider.of<AppConfigProvider>(context);
    // TODO: implement build
    return MaterialApp(debugShowCheckedModeBanner: false,initialRoute: SplashScreen.routeName, routes: {
      SplashScreen.routeName: (context) => SplashScreen(),
      HomeScreen.routeName: (context) => HomeScreen()
    }, themeMode: configProvider.themeMode,);
  }
}


