import 'package:flutter/material.dart';

const kDesktopChangePoint = 1100.0;
const kTabletChangePoint = 500.0; //768.0;
const kMobileChangePoint = 380.0;
const kSmallMobileChangePoint = 360.0;

const kScreenPadding = 15.0;
const kCardBorderrRadius = 5.0;
const kTextFieldBorderRadius = 12.0;
const kButtondBorderRadius = 15.0;
const kFormFieldItemGap = 20.0;

// ignore: avoid_classes_with_only_static_members
class UIParameters {
  static BorderRadius get cardBorderRadius =>
      BorderRadius.circular(kCardBorderrRadius);

  //for cards
  static EdgeInsets get contentPadding => const EdgeInsets.all(kScreenPadding);

  static double contentGap(BuildContext context) => const RD(t:kScreenPadding, d: kScreenPadding, m: kScreenPadding, s : kScreenPadding/2 ).get(context) ?? kScreenPadding;
  static double appBarBottomGap(BuildContext context) => const RD(t:20, d: 20, m: 15, s : 5).get(context) ?? 15;

  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static bool isDesktop(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return (kDesktopChangePoint <= _screenWidth);
  }

  static bool isMobile(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return (kTabletChangePoint > _screenWidth);
    //return (kMobileChangePoint <= _screenWidth);
  }

  static bool isTablet(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return (kTabletChangePoint <= _screenWidth);
  }

  static List<BoxShadow> getShadow(BuildContext context,
          {Color? shadowColor,
          double spreadRadius = 0,
          double blurRadius = 20}) =>
      [
        BoxShadow(
          color: shadowColor ?? Theme.of(context).shadowColor,
          spreadRadius: spreadRadius,
          blurRadius: blurRadius,
          offset: const Offset(0, 3),
        ),
      ];

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static double getResponsizeCardWidth(BuildContext context, int count) {
    final screenPadding = MediaQuery.of(context).viewPadding;
    final screenWidth = MediaQuery.of(context).size.width;
    return (screenWidth -
            (count * 20) -
            (screenPadding.left + screenPadding.right)) /
        count;
  }
}

class RD {
  // Responsive double
  final double? d;
  final double? t;
  final double? m;
  final double? s;

  const RD({
    this.d,
    this.t,
    this.m,
    this.s,
  });

  double? get(context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    if (kDesktopChangePoint <= _screenWidth) {
      return d;
    } else if (kTabletChangePoint <= _screenWidth) {
      return t;
    } else if(kMobileChangePoint <= _screenWidth) {
      return m;
    }else{
      return s ?? m;
    }
  }
}

class RWP {
  // Responsive Width Potion
  final double d;
  final double t;
  final double m;

  const RWP({required this.d, required this.t, required this.m});

  double? get(context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    if (kDesktopChangePoint <= _screenWidth) {
      return d * _screenWidth;
    } else if (kTabletChangePoint <= _screenWidth) {
      return t * _screenWidth;
    } else {
      return m * _screenWidth;
    }
  }
}
