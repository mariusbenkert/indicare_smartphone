import 'package:flutter/material.dart';
import 'package:ms_project/helpers/custom_route.dart';
import 'package:ms_project/helpers/material_helper.dart';

abstract class Styles {
  static const primaryColor = Color(0xff43a047);
  static const accentColor = Color(0xff7e38ed);

  static const textColorPrimary = Color(0xD9000000);
  static const textColorPrimaryLight = Color(0x8C000000);
  static const iconColor = Color(0xff8c8c8c);

  static const backgroundColorGreen = Color(0xffD7E4D7);
  static const textColorGreen = Color(0xff273A27);

  static const backgroundColorRed = Color(0xffE4D7D7);
  static const textColorRed = Color(0xff3D2929);

  static const backgroundColorYellow = Color(0xffE4E1D7);
  static const textColorYellow = Color(0xff3D3829);

  static const backgroundColorGrey = Color(0xffEDEDED);
  static const textColorGrey = textColorPrimary;

  static const largeFontSize = 20.0;
  static const mediumFontSize = 16.0;
  static const smallFontSize = 14.0;

  static const iconSize = 24.0;

  static const textStyle =
      TextStyle(fontSize: mediumFontSize, color: textColorPrimary);
  static const textStyleSmall =
      TextStyle(fontSize: smallFontSize, color: textColorPrimary);

  static const appBarTextStyle = TextStyle(
    fontSize: largeFontSize,
    color: textColorPrimary,
  );

  static const body1TextStyle = TextStyle(
    color: textColorPrimary,
    fontSize: smallFontSize,
  );

  static const body2TextStyle = TextStyle(
    color: textColorPrimary,
    fontSize: smallFontSize,
    fontWeight: FontWeight.bold,
  );

  static const headlineTextStyle = TextStyle(
    color: textColorPrimary,
    fontSize: largeFontSize,
    fontWeight: FontWeight.bold,
  );

  static const primarayTextTheme = TextTheme(
    bodyText2: body1TextStyle,
    bodyText1: body2TextStyle,
    headline5: headlineTextStyle,
  );

  static const iconStyle = IconThemeData(
    color: Colors.black,
    size: mediumFontSize,
    opacity: 1,
  );

  static ThemeData themeData = ThemeData(
    brightness: Brightness.light,
    primarySwatch: HelperFunctions.createMaterialColor(primaryColor),
    primaryColor: primaryColor,
    accentColor: accentColor,
    primaryTextTheme: primarayTextTheme,
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(headline6: appBarTextStyle),
      iconTheme: iconStyle,
      color: Colors.white,
    ),
    fontFamily: 'Lato',
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CustomPageTransitionBuilder(),
        TargetPlatform.iOS: CustomPageTransitionBuilder(),
      },
    ),
  );
}
