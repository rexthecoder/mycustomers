import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import 'marketing_homepage_viewmodel.dart';

class MarketingHomePageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    ScreenUtil.init(context,
        width: width, height: height, allowFontScaling: true);
    return ViewModelBuilder<MarketingHomePageViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
//        body: Stack(
//          children: <Widget>[
//            SingleChildScrollView(
//                physics: ClampingScrollPhysics(),
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Stack(
//                      children: <Widget>[
//                        Container(height: 200.h, color: BrandColors.primary),
//                        Positioned(
//                          top: -86.h,
//                          left: -90.h,
//                          child: circleDesign(98.h, 65.h),
//                        ),
//                        Positioned(
//                          top: -30.h,
//                          right: -108.h,
//                          child: circleDesign(98.h, 65.h),
//                        ),
//                        Positioned(
//                          top: 18.h,
//                          child: Padding(
//                            padding:
//                                new EdgeInsets.fromLTRB(30.w, 20.h, 29.w, 20.h),
//                            child: Column(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              children: <Widget>[
//                                Row(
//                                  mainAxisAlignment:
//                                      MainAxisAlignment.spaceBetween,
//                                  children: <Widget>[
//                                    Text(
//                                      'Marketing',
//                                      style: TextStyle(
//                                          color: Colors.white,
//                                          fontSize: 17.sp,
//                                          fontWeight: FontWeight.bold),
//                                    ),
//                                    SizedBox(width: 200.w),
//                                    notificationBell(model.notification, 35.w)
//                                  ],
//                                ),
//                                SizedBox(
//                                    // height: 10,
//                                    ),
//                                Text(
//                                  'Show your customers how much you care sha.',
//                                  style: TextStyle(
//                                      fontSize: 12.sp, color: Colors.white),
//                                ),
//                                SizedBox(
//                                  height: 19,
//                                ),
//                                Container(
//                                  width: 315.w,
//                                  decoration: BoxDecoration(
//                                      color: Colors.white,
//                                      borderRadius: BorderRadius.circular(5.w),
//                                      border: Border.all(
//                                          color: Color(0xff333cc1),
//                                          width: 1.00601)),
//                                  child: Padding(
//                                    padding: const EdgeInsets.fromLTRB(
//                                        23, 19, 22, 20),
//                                    child: Column(
//                                      crossAxisAlignment:
//                                          CrossAxisAlignment.start,
//                                      children: <Widget>[
//                                        Text(
//                                          'Happy New Year!',
//                                          style: TextStyle(
//                                              color: Colors.grey[600],
//                                              fontSize: 16.sp > 30 ? 30 : 16.sp,
//                                              fontWeight: FontWeight.w600),
//                                        ),
//                                        SizedBox(
//                                          height: 10,
//                                        ),
//                                        Text(
//                                          'Celebrate the new year with your customers. Send them a message.',
//                                          style: TextStyle(
//                                            color: Color(0xffacacac),
//                                            fontSize: 12.sp > 24 ? 24 : 12.sp,
//                                          ),
//                                        ),
//                                        SizedBox(
//                                          height: 10.h,
//                                        ),
//                                        InkWell(
//                                          onTap: () {
//                                            //TODO: Implement routing
//                                          },
//                                          child: Row(
//                                            mainAxisAlignment:
//                                                MainAxisAlignment.end,
//                                            crossAxisAlignment:
//                                                CrossAxisAlignment.center,
//                                            children: <Widget>[
//                                              Text(
//                                                'Send a Happy new Year Message',
//                                                style: TextStyle(
//                                                  color: BrandColors.primary,
//                                                  fontSize:
//                                                      12.sp > 24 ? 24 : 12.sp,
//                                                ),
//                                              ),
//                                              SizedBox(
//                                                width: 9,
//                                              ),
//                                              arrow(true)
//                                            ],
//                                          ),
//                                        )
//                                      ],
//                                    ),
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                        ),
//                        Container(height: height > 900 ? 380.h : 270)
//                      ],
//                    ),
//                    Padding(
//                      padding: new EdgeInsets.only(left: 30, right: 30),
//                      child: TextField(
//                        // TODO: Implement search functionality
//                        decoration: InputDecoration(
//                            contentPadding:
//                                new EdgeInsets.only(top: 12.h, bottom: 12.h),
//                            prefixIcon: Icon(
//                              Icons.search,
//                              color: ThemeColors.gray[800],
//                            ),
//                            hintText: 'Search Customers',
//                            hintStyle: TextStyle(color: ThemeColors.gray[700]),
//                            border: OutlineInputBorder(
//                                borderRadius: BorderRadius.circular(5),
//                                borderSide: BorderSide(
//                                    color: ThemeColors.gray[700],
//                                    width: 1,
//                                    style: BorderStyle.solid))),
//                      ),
//                    ),
//                    Padding(
//                        padding: const EdgeInsets.all(28.0),
//                        child: Column(
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: <Widget>[
//                              Text(
//                                'Frequently Contacted',
//                                style: TextStyle(
//                                    color: ThemeColors.gray[800],
//                                    fontSize: 12.sp > 24 ? 24 : 12.sp,
//                                    fontWeight: FontWeight.w600),
//                              ),
//                              ListView.builder(
//                                shrinkWrap: true,
//                                itemCount: model.persons.length,
//                                itemBuilder: (context, index) {
//                                  var person = model.persons[index];
//                                  return InkWell(
//                                    onTap: () {
//                                      // TODO: implement message route
//                                    },
//                                    child: ListTile(
//                                        leading: CircleAvatar(
//                                          backgroundColor: Color(0xffd1d1d1),
//                                          child: Text('AH'),
//                                        ),
//                                        title: Text('${person['name']}'),
//                                        subtitle: Text('${person['number']}')),
//                                  );
//                                },
//                              ),
//                              SizedBox(height: 100.h)
//                            ])),
//                  ],
//                )),
//            Positioned(
//                bottom: 10,
//                left: 25.h,
//                right: 25.h,
//                child: Column(
//                  children: <Widget>[
//                    SizedBox(
//                      width: 325.w,
//                      height: 48.h,
//                      child: RaisedButton(
//                        onPressed: () {
//                          //TODO: Implement routing
//                          model.navigateToSendMessageView();
//                        },
//                        shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(5.0),
//                        ),
//                        child: Text('Send Message',
//                            style: TextStyle(color: Colors.white)),
//                        color: ThemeColors.cta,
//                      ),
//                    ),
//                    SizedBox(
//                      height: 14.h,
//                    ),
//                    SizedBox(
//                      width: 325.w,
//                      height: 48.h,
//                      child: FlatButton(
//                          onPressed: () {
//                            //TODO: Implement routing
//                          },
//                          shape: RoundedRectangleBorder(
//                              borderRadius: BorderRadius.circular(5.0),
//                              side: BorderSide(color: ThemeColors.cta)),
//                          child: Text('Send Bulk SMS',
//                              style: TextStyle(color: ThemeColors.cta)),
//                          color: Colors.white),
//                    ),
//                    SizedBox(
//                      height: 18.h,
//                    ),
//                  ],
//                ))
//          ],
//        ),
      backgroundColor:BrandColors.primary,
      body: SafeArea(
        bottom: false,
        child: Container(
        child: Column(
          children:<Widget>[
            Container(
              color: Colors.white,
              width: width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:<Widget>[
                      Text('Marketing', style: TextStyle(
                          fontSize: 24.sp, fontWeight: FontWeight.bold
                      ),),
                      SizedBox(height: 10.h,),
                      Text('Show your customer that you really care about them', style: TextStyle(
                          fontSize: 14.sp, color: BrandColors.greyedText
                      ),),
                      SizedBox(height: 10.h,),
                    ]
                ),
              ),
            ),
           model.allCustomers.length ==0? Expanded(

              child:Container(
                color: Color(0xFFF9F9F9),
                width: width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                  child: Column(
                      children:<Widget>[
                        Expanded(

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:<Widget>[
                              Container(
                                width: width/4,
                                height: height/4,
                                child: Image.asset('assets/images/megaphone.png',fit: BoxFit.contain ,),
                              ),
                              SizedBox(height: 10.h,),
                              Text('It\'s all about sending messages to customers. Click the nice blue button below to get that started', style: TextStyle(
                                  fontSize: 14.sp, color: BrandColors.greyedText
                              ),
                              textAlign:TextAlign.center,
                              ),

                            ],
                          ),
                        ),
                        Container(
              color: Colors.white,
              height: 50.h,
           child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                Expanded(
                  child: InkWell(
                    // onTap: ()=>model.navigateToAddCustomer(),
                    child: Container(
                      decoration: BoxDecoration(
                         color: BrandColors.primary,
                         borderRadius: BorderRadius.circular(5.0)),
                       
                        child: Center(
                          child: Text('Add a customer', style: TextStyle(
                              fontSize: 14.sp, color: Colors.white
                          ),),
                        ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: InkWell(
                    child: Container(
                       decoration: BoxDecoration(
                         color:ThemeColors.gray,
                         borderRadius: BorderRadius.circular(5.0)),
                       
                       
                        child: Center(
                          child: Text('Send message', style: TextStyle(
                              fontSize: 14.sp, color: Colors.white
                          ),),
                        ),
                    ),
                  ),
                ),
                ],
              ),
            ),
                      ]
                  ),
                ),
              ),
            ):
           

            Expanded(

              child:Container(
                color: Colors.white,
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children:<Widget>[
                      Expanded(
                        child: SingleChildScrollView(
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:<Widget>[
                               SizedBox(height: 20.h,),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal:20.0,),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Customer List', style: TextStyle(
                                        fontSize: 20.sp,
                                    ),),
                                     Text('Send message to all', style: TextStyle(
                                        fontSize: 14.sp, color: BrandColors.secondary
                                    ),),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.h,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal:15.0,vertical: 10),
                                child: Container(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.search),
                                      hintText: 'Type customer name',
                                      border: InputBorder.none,
                                      focusColor: BrandColors.primary,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:const EdgeInsets.symmetric(horizontal:20.0,vertical: 10),
                                child: Text('All'),
                              ),
                              ListView.builder(
                                itemCount: model.allCustomers.length,
                                itemBuilder: (context, index)=>Container())
                              

                            

                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:const EdgeInsets.symmetric(horizontal:20.0,vertical: 10),
                        child: Container(
              color: Colors.white,
              height: 50.h,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    // =>Navigator.pushNamed(context, '/addCustomerMarketing'),
                    child: Container(
                      decoration: BoxDecoration(
                         color: BrandColors.primary,
                         borderRadius: BorderRadius.circular(5.0)),
                       
                        child: Center(
                          child: Text('Add a customer', style: TextStyle(
                              fontSize: 14.sp, color: Colors.white
                          ),),
                        ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: InkWell(
                    child: Container(
                       decoration: BoxDecoration(
                         color: model.selectedCustomers.length==0? ThemeColors.gray: BrandColors.secondary,
                         borderRadius: BorderRadius.circular(5.0)),
                       
                       
                        child: Center(
                          child: Text('Send message', style: TextStyle(
                              fontSize: 14.sp, color: Colors.white
                          ),),
                        ),
                    ),
                  ),
                ),
                ],
              ),
            ),
                      ),
                    ]
                ),
              ),
            ),
           

          ]
        ),
        ),
      ),
      ),
      viewModelBuilder: () => MarketingHomePageViewModel(),
    );
  }
}
