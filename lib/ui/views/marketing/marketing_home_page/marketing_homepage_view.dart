import 'package:flutter/material.dart';
//import 'package:mycustomers/ui/widgets/shared/under_construction.dart';
//import 'package:mycustomers/ui/views/main/main_view.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import 'marketing_homepage_viewmodel.dart';

class MarketingHomePageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context,
        width: 375, height: height, allowFontScaling: true);
    return ViewModelBuilder<MarketingHomePageViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 200.h,
                      color: Color(0xff333cc1),
                    ),
                    Positioned(
                      top: -86.h,
                      left: -90.h,
                      child: circleDesign(98.h, 65.h),
                    ),
                    Positioned(
                      top: -30.h,
                      right: -108.h,
                      child: circleDesign(98.h, 65.h),
                    ),
                    Positioned(
                      top: 18.h,
                      child: Padding(
                        padding:
                            new EdgeInsets.fromLTRB(30.w, 20.h, 29.w, 20.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  'Marketing',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 205.w),
                                notificationBell(model.notification)
                              ],
                            ),
                            SizedBox(
                              height: 17,
                            ),
                            Text(
                              'Show your customers how much you care.',
                              style: TextStyle(
                                  fontSize: 12.sp, color: Colors.white),
                            ),
                            SizedBox(
                              height: 19,
                            ),
                            Container(
                              height: height > 900 ? 200.h : 140,
                              width: 315.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.w),
                                  border: Border.all(
                                      color: Color(0xff333cc1),
                                      width: 1.00601)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(23, 19, 22, 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Happy New Year!',
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 16.sp > 30 ? 30 : 16.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Celebrate the new year with your customers. Send them a message.',
                                      style: TextStyle(
                                        color: Color(0xffacacac),
                                        fontSize: 12.sp > 24 ? 24 : 12.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        //TODO: Implement routing
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            'Send a Happy new Year Message',
                                            style: TextStyle(
                                              color: Color(0xff333cc1),
                                              fontSize: 12.sp > 24 ? 24 : 12.sp,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          arrow(true)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(height: height > 900 ? 380.h : 270)
                  ],
                ),
                Padding(
                  padding: new EdgeInsets.only(left: 30, right: 30),
                  child: TextField(
                    // TODO: Implement search functionality
                    decoration: InputDecoration(
                        contentPadding:
                            new EdgeInsets.only(top: 12.h, bottom: 12.h),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color(0xff939393),
                        ),
                        hintText: 'Search Customers',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                                color: Color(0xffd1d1d1),
                                width: 1,
                                style: BorderStyle.solid))),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Frequently Contacted',
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: model.persons.length,
                            itemBuilder: (context, index) {
                              var person = model.persons[index];
                              return InkWell(
                                onTap: () {
                                  // TODO: implement message route
                                },
                                child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Color(0xffd1d1d1),
                                      child: Text('AH'),
                                    ),
                                    title: Text('${person['name']}'),
                                    subtitle: Text('${person['number']}')),
                              );
                            },
                          ),
                          SizedBox(height: 100.h)
                        ])),
              ],
            )),
            Positioned(
                bottom: 10,
                left: 25.h,
                right: 25.h,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: 325.w,
                      height: 48.h,
                      child: RaisedButton(
                        onPressed: () {
                          //TODO: Implement routing
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text('Send Message',
                            style: TextStyle(color: Colors.white)),
                        color: Color(0xFFFF8C5F),
                      ),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    SizedBox(
                      width: 325.w,
                      height: 48.h,
                      child: FlatButton(
                          onPressed: () {
                            //TODO: Implement routing
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: BorderSide(color: Color(0xffff8c5f))),
                          child: Text('Send Bulk SMS',
                              style: TextStyle(color: Color(0xFFFF8C5F))),
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                  ],
                ))
          ],
        ),
      ),
      viewModelBuilder: () => MarketingHomePageViewModel(),
    );
  }
}
