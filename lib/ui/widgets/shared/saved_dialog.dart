import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SavedDialog extends StatelessWidget {

  showSavedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0)
          )
        ),
        contentPadding: EdgeInsets.all(0.0),
        content: Container(
          width: ScreenUtil.screenWidth,
          height: ScreenUtil().setHeight(350),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  'assets/icons/blue_mark.svg'
                ),
                Text(
                  'Saved',
                  style: Theme.of(context).textTheme.headline6.copyWith(fontSize: ScreenUtil().setSp(18),),
                )
              ],
            ),
          ),
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}