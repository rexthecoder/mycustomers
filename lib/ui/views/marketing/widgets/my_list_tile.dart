import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyListTile extends StatelessWidget {
  const MyListTile(
      {Key key,
        this.leading,
        @required this.title,
        this.trailing,
        this.subtitle})
      : super(key: key);

  final Widget leading, title, trailing, subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: Row(
        children: <Widget>[
          this.leading ?? Container(),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  this.title,
                  this.subtitle == null
                      ? Container()
                      : SizedBox(
                    height: 3.sp,
                  ),
                  this.subtitle ?? Container(),
                ],
              ),
            ),
          ),
          this.trailing ?? Container(),
        ],
      ),
    );
  }
}
