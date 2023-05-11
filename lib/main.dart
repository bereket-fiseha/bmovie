import 'package:bmovie/const/appcolors.dart';
import 'package:bmovie/screens/discovermovies.dart';
import 'package:bmovie/screens/moviedetail.dart';
import 'package:bmovie/screens/moviesearch.dart';
import 'package:bmovie/screens/imageslider.dart';
import 'package:bmovie/screens/similarmovies.dart';
import 'package:bmovie/screens/tempscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/themesettingprovider.dart';
import 'screens/movielistbygenre.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var customTheme = ThemeData(
        primaryColor: bprimarycolor.withOpacity(.7),
        backgroundColor: bprimarycolor.withOpacity(1),
        appBarTheme: AppBarTheme(color: bprimarycolor.withOpacity(.7)),
        scaffoldBackgroundColor: bprimarycolor.withOpacity(1),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: bprimarycolor.withOpacity(.4)),
        iconTheme: IconThemeData(color: Colors.white),
        cardTheme: CardTheme(color: bprimarycolor.withOpacity(1)),
        textTheme: TextTheme(
            bodyText1: TextStyle(color: Colors.white),
            bodyText2: TextStyle(color: Colors.white)));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeSettingProvider>(
            create: (context) => ThemeSettingProvider()),
      ],
      child: Consumer<ThemeSettingProvider>(
        builder: (context, provider, child) => MaterialApp(
          theme: provider.isCustomThemeEnabled()
              ? customTheme
              : ThemeData(primarySwatch: Colors.teal, fontFamily: "OpenSans"),
          themeMode:
              provider.isDarkModeEnabled() & !provider.isCustomThemeEnabled()
                  ? ThemeMode.dark
                  : ThemeMode.light,
          darkTheme: ThemeData.dark(),
          home: TempScreen(),
        ),
      ),
    );
  }
}
