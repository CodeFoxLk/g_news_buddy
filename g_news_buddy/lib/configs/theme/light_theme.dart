import 'package:flutter/material.dart';
import 'package:g_news_buddy/configs/theme/common_data.dart';

const Color kPrimayColorLT = Color.fromARGB(255, 82, 151, 253);
const Color kAppBarIconColorLT = Colors.white;
const Color kMainTextColorLT = Color.fromARGB(255, 40, 40, 40);
const Color kSecondaryTextColorLT = Color.fromARGB(255, 84, 84, 84);
const Color kIconColorLT = kPrimayColorLT;
const Color kShadowColorLT = Color.fromRGBO(150, 170, 180, 0.25);
const Color kCardColorLT = Color.fromARGB(255, 254, 254, 255);
const Color kScaffoldBackgroundColorLT = Colors.white;

class LightTheme with CommonData {
  ThemeData buildLightTheme(BuildContext context) {
    final ThemeData systemLightTheme = ThemeData.light();
    return systemLightTheme.copyWith(
        shadowColor: kShadowColorLT,
        //visualDensity: VisualDensity.adaptivePlatformDensity,
        tabBarTheme: getTabBarTheme(),
        appBarTheme: getAppBarTheme(),
        scaffoldBackgroundColor: kScaffoldBackgroundColorLT,
        splashColor: kPrimayColorLT.withOpacity(0.1),
        highlightColor: kPrimayColorLT.withOpacity(0.05),
        splashFactory: InkRipple.splashFactory,
        elevatedButtonTheme: getButtonTheme(),
        textTheme: getTextThemes()
            .merge(const TextTheme(
                subtitle1: TextStyle(
                    color:
                        kSecondaryTextColorLT))) // text flields input text color
            .apply(
              bodyColor: kMainTextColorLT,
              displayColor: kMainTextColorLT,
            ),
        primaryColor: kPrimayColorLT,
        cardColor: kCardColorLT,
        iconTheme: getIconData(context),
        colorScheme: ColorScheme.fromSwatch(
            accentColor: kPrimayColorLT, primarySwatch: Colors.blue));
  }
}
