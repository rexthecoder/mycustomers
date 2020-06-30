

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/size_extension.dart';

import '../home_page_viewmodel.dart';


class DebtorsViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context, width: width, height: height);
    return ViewModelBuilder<HomePageViewModel>.reactive(
      builder: (context, model, child) => Container(

        child: Column(

          children: <Widget>[
            Expanded(
              child:model.expectedTime !=null? Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Container(
                          height: 150.h,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Color(0xFF333CC1),
                              image: DecorationImage(
                                image: ExactAssetImage('assets/images/Mask Group.png',
                                ),
                                fit: BoxFit.fill
                              ),
                              borderRadius: BorderRadius.circular(5)
                          ),

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            textBaseline: TextBaseline.ideographic,
                            children: <Widget>[
                              Text('Customers are owing you', style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp
                              ),),
                              RichText(
                                text: TextSpan(
                                  text: 'NGN 20500.', style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 36.sp,
                                    fontWeight: FontWeight.bold),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '00.', style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold
                                    ),
                                    )
                                  ]
                                ),

                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 50.h,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: TextField(
                            controller: model.debtorsController,
                            onChanged: model.searchDebtors,
                            textAlign: TextAlign.justify,
                            style:  TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,),
                            decoration: InputDecoration(
                              hintText: 'Search by name',
                              hintStyle: TextStyle(
                                color: Color(0xFFACACAC),
                                fontSize: 14.sp,


                              ),
                              contentPadding:  const EdgeInsets.all(10.0),
                              prefixIcon:   Icon(Icons.search,color: BrandColors.primary,),
                              border: InputBorder.none

                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      Container(
                        height: 50,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: ExactAssetImage('assets/images/man.png'),
                              radius: 20.w,
                            ),
                            SizedBox(width: 10.w,),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('Seyi Onifade', style: TextStyle(
                                          fontSize: 16.sp,),),
                                      SizedBox(height:5.h),
                                      Text('Expected a week ago', style: TextStyle(
                                        fontSize: 13.sp,
                                      color: Color(0xFFADADBD))),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text('NGN ${model.amountOwing}', style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.red)),
                                      SizedBox(height:5.h),
                                      Container(
                                        color: Colors.red.withOpacity(0.1),
                                        child: Text('Overdue', style: TextStyle(
                                          fontSize: 16.sp,
                                        color: Colors.red)
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height:5.h),
                      Divider(color: Colors.black,),
                      Container(
                        height: 50,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: ExactAssetImage('assets/images/man.png'),
                              radius: 20.w,
                            ),
                            SizedBox(width: 10.w,),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('Cythia Ike', style: TextStyle(
                                          fontSize: 16.sp,),),
                                      SizedBox(height:5.h),
                                      Text('Expected in 2 weeks ', style: TextStyle(
                                        fontSize: 13.sp,
                                      color: Color(0xFFADADBD))),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text('NGN 500', style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.green)),
                                      SizedBox(height:5.h),
                                      Container(
                                        color: Colors.green.withOpacity(0.1),
                                        child: Text('Overdue', style: TextStyle(
                                          fontSize: 16.sp,
                                        color: Colors.green)
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height:5.h),
                      Divider(color: Colors.black,),


                    ],
                  ),
                ),
              ): Padding(
                padding: const EdgeInsets.all(10.0),
                child: Expanded(
                  child: Center(
                    child: Container(
                      height: 300.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/images/Notebook-pana 1.png'),
                          Text('You do not have any customer owing you money yet. Tap the big blue button at the bottom of the screen to add one',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: BrandColors.primary),),
                        ],
                      ),),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: InkWell(
                onTap: (){},
                child: Container(
                  height: 50.h,
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    color: BrandColors.primary,
                    borderRadius: BorderRadius.circular(5)
                  ),

                  child: Center(
                    child: Text('Add Customer owing you',
                      style: TextStyle(color: Colors.white,
                      fontSize: 12.sp,),
                    ),
                  ),),
              ),
            )
          ] ,
        ),
      ),
      viewModelBuilder: () => HomePageViewModel(),
    );
  }
}
