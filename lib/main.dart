import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/app_config_provider.dart';
import 'package:todo_app/core/myTheme.dart';
import 'package:todo_app/features/Home/presentation/manager/task_provider.dart';
import 'package:todo_app/features/Home/presentation/views/home_screen.dart';
import 'package:todo_app/features/splash_screen/splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => AppConfigProvider(),
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
        HomeScreen.routeName: (context) => HomeScreen()
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
