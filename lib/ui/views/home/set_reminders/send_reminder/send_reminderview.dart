import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'send_reminderviewmodel.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import './send_reminderviewmodel.dart';
import 'package:mycustomers/ui/shared/const_color.dart';

class SendMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    ScreenUtil.init(context, width: width, height: height);
    return ViewModelBuilder<SendMessageViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          // resizeToAvoidBottomInset: false,
          appBar: customizeAppBar(context, 'Send Reminder', 1.0),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 60.h,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30),
                    child: TextField(
                      style: TextStyle(height: height * 0.002),
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Type a heading',
                        hintStyle: TextStyle(color: ThemeColors.black),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ThemeColors.gray, width: 2.0),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ThemeColors.gray, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ThemeColors.gray, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ThemeColors.gray, width: 2.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30),
                    child: TextField(
                      style: TextStyle(height: height * 0.002),
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Start typing your message',
                        hintStyle: TextStyle(color: ThemeColors.black),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ThemeColors.gray, width: 2.0),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ThemeColors.gray, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ThemeColors.gray, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ThemeColors.gray, width: 2.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 150.h,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30),
                    height: 50.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: MaterialButton(
                            color: ThemeColors.gray[500],
                            elevation: 2,
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/scheduleNotifications');
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Center(
                              child: Text(
                                'Schedule',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: BrandColors.primary),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: MaterialButton(
                            color: BrandColors.primary,
                            elevation: 2,
                            onPressed: () {
                              print('Clicked');
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Center(
                              child: Text(
                                'Send',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: ThemeColors.background,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => SendMessageViewModel(),
    );
  }
}
