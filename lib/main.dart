import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/app_config_provider.dart';
import 'package:todo_app/core/myTheme.dart';
import 'package:todo_app/features/Home/presentation/manager/auth_provider.dart';
import 'package:todo_app/features/Home/presentation/manager/task_provider.dart';
import 'package:todo_app/features/Home/presentation/views/home_screen.dart';
import 'package:todo_app/features/authentication/login/presentation/views/login_screen.dart';
import 'package:todo_app/features/authentication/register/presentation/views/register_screen.dart';
import 'package:todo_app/features/splash_screen/splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AuthProviders(),),
    ChangeNotifierProvider(
      create: (context) => AppConfigProvider()..getLang()..getTheme(),
    ),
    ChangeNotifierProvider(
      create: (context) => TaskProvider(),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var configProvider = Provider.of<AppConfigProvider>(context);
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginScreen.routeName:(context) => LoginScreen()
      },
      themeMode: configProvider.themeMode,
      theme: MyTheme.lightMode,
      darkTheme: MyTheme.darkTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(configProvider.language),
    );
  }
}
