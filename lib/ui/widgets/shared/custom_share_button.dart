import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomShareRaisedButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  CustomShareRaisedButton({
    @required this.label,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      color: Color(0xFF333CC1),
      padding: EdgeInsets.symmetric(vertical: 22.sp),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.sp),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.share,
            color: Colors.white,
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
