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
    height: screenHeight * 7,
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

Widget btnAuth(String btnText, context) {
  double screenHeight = MediaQuery.of(context).size.height / 100;
  double screenWidth = MediaQuery.of(context).size.width / 100;
  return Container(
    height: screenHeight * 6,
    width: screenWidth * 90,
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
        SizedBox(width: screenWidth * 5),
        Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
          size: screenHeight * 2,
        ),
      ],
    ),
  );
}

class HomeBackgrouWidget extends StatelessWidget {
  const HomeBackgrouWidget({
    Key key,
    
    @required this.height,
    @required this.width,
    @required this.widget,
    @required this.context,
  }) : super(key: key);

  final double height;
  final double width;
  final BuildContext context;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            height: height * 0.8,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/onboarding/ob1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: SizeConfig.yMargin(context, 20)),
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: Color(0xffffffff),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(height * 0.05),
                topRight: Radius.circular(height * 0.05),
              ),
            ),
            child: Column(
              children: <Widget>[
               widget
              ],
            ),
          ),
        ],
      ),
    );
  }
}
