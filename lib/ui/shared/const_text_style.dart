import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_color.dart';

TextStyle kheadingText = TextStyle(
    fontFamily: '',
    color: ThemeColors.black,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    fontSize: 11,);

  TextStyle bodyTextStyle(FontWeight fWeight) {
  return TextStyle(
      fontFamily: '',
      color: Color(0xff4F4F4F),
      fontStyle: FontStyle.normal,
      fontWeight: fWeight,
      fontSize: 19,
      height: 1.5
   );
}