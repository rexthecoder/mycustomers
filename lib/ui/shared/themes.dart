import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_text_style.dart';

import 'const_color.dart';

final _lightThemeData = ThemeData.light();
final _darkThemeData = ThemeData.dark();

/// Light Theme
final primaryMaterialTheme = _lightThemeData.copyWith(
  textTheme: _lightThemeData.textTheme.apply(
    fontFamily: 'Lato',
  ),
  backgroundColor: ThemeColors.background,
  bottomAppBarColor: ThemeColors.primary,
  cursorColor: ThemeColors.black,
  hintColor: const Color.fromARGB(60, 25, 25, 25),
  bottomAppBarTheme: _lightThemeData.bottomAppBarTheme.copyWith(
    color: ThemeColors.primary,
    elevation: 0,
  ),
  buttonTheme: _lightThemeData.buttonTheme.copyWith(
    buttonColor: ThemeColors.primary,
    focusColor: ThemeColors.primary.withOpacity(0.5),
  ),
  appBarTheme: _lightThemeData.appBarTheme.copyWith(
    color: ThemeColors.background,
    textTheme: TextTheme(
      headline6: kheadingText,
      bodyText2: bodyTextStyle(FontWeight.normal),
    ),
    iconTheme: IconThemeData(
      color: ThemeColors.black,
    ),
  ),
  iconTheme: _lightThemeData.iconTheme.copyWith(
    color: BrandColors.secondary,
  ),
  accentIconTheme: _lightThemeData.accentIconTheme.copyWith(
    color: ThemeColors.gray[800],
  ),
);

/// Dark Theme
final darkMaterialTheme = _darkThemeData.copyWith(
  textTheme: _darkThemeData.textTheme.apply(
    fontFamily: 'Lato',
  ),
  appBarTheme: _lightThemeData.appBarTheme.copyWith(
    textTheme: TextTheme(
      headline6: kheadingText,
      bodyText2: bodyTextStyle(FontWeight.normal),
    ),
    iconTheme: IconThemeData(
      color: ThemeColors.background,
    ),
  ),
  iconTheme: _lightThemeData.iconTheme.copyWith(color: ThemeColors.background),
  accentIconTheme: _lightThemeData.accentIconTheme.copyWith(
    color: ThemeColors.gray[800],
  ),
);

/// Cupertino Theme Data
final primaryCupertinoTheme = CupertinoThemeData(
  primaryColor: CupertinoDynamicColor.withBrightness(
    color: Color(0xFF333CC1),
    darkColor: Colors.cyan,
  ),
);
