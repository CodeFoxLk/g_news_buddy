import 'package:flutter/material.dart';

import 'common_data.dart';

const Color kPrimayColorDT = Color.fromARGB(255, 0, 168, 242);
const Color kPrimayLightColorDT = Color.fromARGB(255, 92, 15, 210);
const Color appBarIconColorDT = Colors.white;
const Color kSecondaryTextColorDT = Color.fromARGB(255, 184, 184, 184);
const Color mainTextColorDT = Colors.white;
const Color iconColorDT = Colors.white;
const Color shadowColorDT = Color.fromARGB(90, 172, 172, 172);
const Color cardColorDT = Color.fromARGB(255, 28, 40, 84);
const Color scaffoldBackgroundColor = Color.fromARGB(255, 16, 16, 16);

class DarkTheme with CommonData {
  ThemeData buildDarkTheme(BuildContext context) {
    final ThemeData systemDarkTheme = ThemeData.dark();
    return systemDarkTheme.copyWith(
        brightness: Brightness.light ,
        //  visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        appBarTheme: getAppBarTheme(),
        splashColor: kPrimayColorDT.withOpacity(0.2),
        highlightColor: kPrimayColorDT.withOpacity(0.05),
        textTheme: getTextThemes()
            .apply(bodyColor: mainTextColorDT, displayColor: mainTextColorDT),
        cardColor: cardColorDT,
        shadowColor: Colors.black45,
        primaryColor: kPrimayColorDT);
  }
}
