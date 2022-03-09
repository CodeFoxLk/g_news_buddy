
import 'package:flutter/material.dart';

mixin CommonData {
  AppBarTheme getAppBarTheme() {
    return const AppBarTheme(
      centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24));
  }

  BottomAppBarTheme getBottomAppBarTheme() {
    return const BottomAppBarTheme(color: Colors.transparent, elevation: 0);
  }

  TextTheme getTextThemes() {
    // return GoogleFonts.dmSansTextTheme(const TextTheme(
    //     bodyText1: TextStyle(
    //       fontWeight: FontWeight.w400,
    //     ),
    //     bodyText2: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)));
    return const TextTheme(
        bodyText1: TextStyle(fontWeight: FontWeight.normal),
        bodyText2: TextStyle(fontWeight: FontWeight.normal));
  }

  IconThemeData getIconData(BuildContext context){
    return IconThemeData(
      color: Theme.of(context).primaryColor 
    );
  }

  

  ElevatedButtonThemeData getButtonTheme() {
    return ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom());
  }

  BottomNavigationBarThemeData getBottomNavigationBarTheme() {
    return const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        showSelectedLabels: false,
        showUnselectedLabels: false);
  }

  TabBarTheme getTabBarTheme(){
    return const TabBarTheme(
      labelStyle: TextStyle(fontWeight: FontWeight.normal)
    );
  }
}
