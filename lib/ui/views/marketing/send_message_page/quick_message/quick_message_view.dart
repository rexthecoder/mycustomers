import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/views/marketing/send_message_page/quick_message/quick_message_viewmodel.dart';

class QuickMessageView extends StatelessWidget {
  final bgColor = Colors.white;
  final color = Colors.blueAccent[700];
  final outlineColor = Colors.grey[200];
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 1440, width: 720, allowFontScaling: true);
    return ViewModelBuilder<QuickMessageViewModel>.reactive(
      viewModelBuilder: () => QuickMessageViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: bgColor,
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 50.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    height: 120.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            model.navigateTo();
                          },
                          icon: Icon(
                            Icons.keyboard_backspace,
                            color: color,
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Quick Message',
                          style: TextStyle(
                            fontSize: 35.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(flex: 2),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: color,
                      ),
                      color: null,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    height: SizeConfig.yMargin(context, 12),
                    width: SizeConfig.xMargin(context, 90),
                    margin: EdgeInsets.only(
                        top: 40.h, left: 60.w, right: 60.w, bottom: 0.0),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 30, 20, 20),
                      child: Flexible(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Happy New Year! \nBest wishes from me',
                              style: TextStyle(
                                color: color,
                                fontWeight: FontWeight.w500,
                                fontSize: 25.sp,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: color,
                                ),
                                onPressed: () {
                                  model.navigateToMessageView();
                                })
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: color,
                      ),
                      color: null,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    height: SizeConfig.yMargin(context, 12),
                    width: SizeConfig.xMargin(context, 90),
                    margin: EdgeInsets.only(
                        top: 40.h, left: 60.w, right: 60.w, bottom: 0.0),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 30, 20, 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Season\'s Greetings! \nWishing you a happy new near!',
                            style: TextStyle(
                              color: color,
                              fontWeight: FontWeight.w500,
                              fontSize: 25.sp,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: color,
                              ),
                              onPressed: () {
                                model.navigateToMessageView();
                              })
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
