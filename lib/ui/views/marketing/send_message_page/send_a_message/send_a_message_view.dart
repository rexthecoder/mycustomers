import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'send_a_message_viewmodel.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/shared/const_color.dart';

class Stuff extends StatelessWidget {
  final bgColor = Colors.white;
  final color = Colors.blueAccent[700];
  final outlineColor = Colors.grey[200];
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 1440, width: 720, allowFontScaling: true);
    return ViewModelBuilder<StuffModel>.reactive(
      viewModelBuilder: () => StuffModel(),
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
                          }, // TODO: implement back button
                          icon: Icon(
                            Icons.keyboard_backspace,
                            color: color,
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Send a Message',
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
                      color: BrandColors.primary,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    height: SizeConfig.yMargin(context, 15),
                    width: SizeConfig.xMargin(context, 90),
                    margin: EdgeInsets.only(
                        top: 40.h, left: 60.w, right: 60.w, bottom: 0.0),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(5, 30, 20, 20),
                      child: FlatButton(
                        onPressed: () {
                          model.navigateToQuickMessage();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Quick message',
                              style: TextStyle(
                                color: bgColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 33.sp,
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.yMargin(context, 1),
                            ),
                            Text(
                              'We have already made messages for you so feel free to use them',
                              style: TextStyle(
                                fontSize: 21.sp,
                                color: bgColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: BrandColors.primary,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    height: SizeConfig.yMargin(context, 15),
                    width: SizeConfig.xMargin(context, 90),
                    margin: EdgeInsets.only(
                        top: 40.h, left: 60.w, right: 60.w, bottom: 0.0),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(5, 30, 20, 20),
                      child: FlatButton(
                        onPressed: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Compose message',
                              style: TextStyle(
                                color: bgColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 33.sp,
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.yMargin(context, 1),
                            ),
                            Text(
                              'Create unique messages for your customers and make them feel special!',
                              style: TextStyle(
                                fontSize: 21.sp,
                                color: bgColor,
                              ),
                            ),
                          ],
                        ),
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
