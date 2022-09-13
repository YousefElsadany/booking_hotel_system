import 'package:flutter/material.dart';
import 'colors.dart';

class HotelThemes {
  static Color primaryColor = Color.fromARGB(255, 121, 21, 12);
  static final MaterialColor primarySwatch =
      SmartColor.primarySwatch(primaryColor);

  static Color backgroundColor = const Color(
    0xFFf9f9f9,
  );
  static Color textColor = const Color(
    0xFF9B9B9B,
  );

  static Color deepTextColor = const Color(
    0xFF222222,
  );

  static final enLightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    canvasColor: Colors.transparent,
    primarySwatch: primarySwatch,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: const TextTheme(
      button: TextStyle(
        color: Colors.black,
      ),
      bodyText1: TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
      bodyText2: TextStyle(
        color: Colors.black,
        fontSize: 12,
      ),
      subtitle1: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 16,
      ),
      subtitle2: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 14,
      ),
      headline1: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headline2: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headline3: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        height: 1.7,
      ),
      headline5: TextStyle(
        fontSize: 11,
        color: Colors.black,
        fontWeight: FontWeight.w800,
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: primarySwatch,
    ),
  );

  static final enDarkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xff1e272e),
    canvasColor: Colors.transparent,
    primarySwatch: primarySwatch,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: const TextTheme(
      button: TextStyle(
        color: Colors.white,
      ),
      bodyText1: TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
      bodyText2: TextStyle(
        color: Colors.white,
        fontSize: 12,
      ),
      subtitle1: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 16,
      ),
      subtitle2: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 14,
      ),
      headline1: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headline2: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headline3: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        height: 1.7,
      ),
      headline5: TextStyle(
        fontSize: 11,
        color: Colors.white,
        fontWeight: FontWeight.w800,
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: primarySwatch.shade300,
    ),
  );
}
