import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';

class ProgressIndicator extends StatelessWidget {

  final int progress, total;

  ProgressIndicator(this.progress, this.total, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List<Widget>.generate(total*2 - 1, (int index) {
        return index % 2 == 0
            ? CircleAvatar(
          radius: 15,
          child: index <= progress ? Text('${index ~/ 2 + 1}', style: TextStyle(
            color: Colors.white,
          ),) : null,
          backgroundColor: index <= progress
              ? ThemeColors.cta
              : ThemeColors.gray,
        )
            : Expanded(
          child: Divider(
            thickness: 5,
            color: index <= progress
                ? ThemeColors.cta
                : ThemeColors.gray,
          ),
        );
      }),
    );
  }
}


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

class HomeBackgroundWidget extends StatelessWidget {
  const HomeBackgroundWidget({
    Key key,

    @required this.height,
    @required this.width,
    @required this.child,
    this.offset,
  }) : super(key: key);

  final double height;
  final double width;
  final Widget child;
  final double offset;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/onboarding/ob1.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: SingleChildScrollView(
              reverse: true,
              physics: ClampingScrollPhysics(),
              child: Container(
                constraints: BoxConstraints(
                  minHeight: SizeConfig.yMargin(context, 70),
                ),
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget notificationBell(bool isNewNotification) {
  String notification = isNewNotification ? 'notification' : 'no_notification';
  final String assetName = "assets/icons/$notification.png";
  final Widget notificationIcon = Image.asset(assetName);
  return notificationIcon;
}

Widget arrow(bool forward) {
  String direction = forward ? 'foward' : 'back';
  final String assetName = "assets/icons/arrow_$direction.svg";
  final Widget svgIcon = SvgPicture.asset(assetName,
      color: Color(0xff333cc1),
      semanticsLabel: 'An arrow');
  return svgIcon;
}


Widget circleDesign(double outerRadius, double innerRadius){
  return Container(
    height: outerRadius * 2,
    width: outerRadius * 2,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(outerRadius),
      color: Color(0xff1d6aff),
    ),
    child: Center(
      child: Container(
        height: innerRadius * 2,
        width: innerRadius * 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(outerRadius),
          color: Color(0xff333cc1),
        ),
      ),
    ),
  );
}

