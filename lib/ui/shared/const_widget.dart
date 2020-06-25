import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycustomers/ui/shared/size_config.dart';

Widget btnDesign(String btnText, Color textColor, Color bgColor) {
  return Container(
    height: 200.h,
    width: double.infinity,
    alignment: Alignment.center,
    margin: EdgeInsets.only(left: 10.0, right: 10.0),
    decoration: BoxDecoration(
        color: bgColor, borderRadius: BorderRadius.all(Radius.circular(10))),
    child: Text(btnText,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: textColor,
          fontFamily: '',
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        )),
  );
}

Widget btnHome(String btnText, context) {
  double screenHeight = MediaQuery.of(context).size.height / 100;
  double screenWidth = MediaQuery.of(context).size.width / 100;

  return Container(
    height: screenHeight * 8,
    width: screenWidth * 80,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: Color(0xFF333CC1)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          btnText,
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * 4,
          ),
        ),
      ],
    ),
  );
}
