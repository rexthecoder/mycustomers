import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'transaction_details_viewmodel.dart';

class TransactionDetails extends StatelessWidget {
  final Color color = Colors.blueAccent[700];
  final Color bgColor = Colors.grey[200];
  final Color containerColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 1440, width: 720, allowFontScaling: true);
    return ViewModelBuilder<TransactionDetailsViewModel>.reactive(
      viewModelBuilder: ()=> TransactionDetailsViewModel(),
      builder: (context, model, child){
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  width: double.infinity,
                  height: 150.h,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },//TODO: implement backbutton
                        icon: Icon(
                          Icons.keyboard_backspace,
                          size: 50.sp,
                          color: color,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Transaction details',
                        style: TextStyle(fontSize: 35.sp, fontWeight: FontWeight.bold),
                      ),
                      Spacer(flex: 2,),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: bgColor,
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: containerColor,
                              border: Border.all(color: color),
                              borderRadius: BorderRadius.circular(15.sp)
                          ),
                          margin: EdgeInsets.only(left: 50.w, right: 50.w, top: 40.h, bottom: 0.0),
                          width: double.infinity,
                          //height: 550.w,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                                child: Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 60.0.sp,
                                      backgroundColor: color,
                                    ),
                                    SizedBox(width: 20.w,),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          model.name,
                                          style: TextStyle(
                                            fontSize: 40.sp,
                                          ),
                                        ),// TODO: implement Profile picture
                                        Text(
                                          model.phoneNumber.toString(),
                                          style: TextStyle(
                                            fontSize: 30.sp,
                                            color: Colors.grey[600],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: color,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 30.sp,left: 30.sp,right: 30.sp, bottom: 40.sp),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 20,
                                            child: Text(
                                              'Items purchased:',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 30.sp),
                                            ),
                                          ),
                                          SizedBox(width: 10.w,),
                                          Expanded(
                                            flex: 30,
                                            child: Text(
                                              model.itemsPurchased,
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontSize: 30.sp),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20.h,),
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 20,
                                            child: Text(
                                              'Cost of Items:',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 30.sp),
                                            ),
                                          ),
                                          SizedBox(width: 10.w,),
                                          Expanded(
                                            flex: 30,
                                            child: Text(
                                              'N${model.costOfItems}',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  color: color,
                                                  fontSize: 30.sp),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20.h,),
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 20,
                                            child: Text(
                                              'Amount paid:',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 30.sp),
                                            ),
                                          ),
                                          SizedBox(width: 10.w,),
                                          Expanded(
                                            flex: 30,
                                            child: Text(
                                              'N${model.amountPaid}',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  color: color,
                                                  fontSize: 30.sp),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 40.h,),
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 20,
                                            child: Text(
                                              'Amount Owing:',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 30.sp),
                                            ),
                                          ),
                                          SizedBox(width: 10.w,),
                                          Expanded(
                                            flex: 30,
                                            child: Text(
                                              'N${model.amountOwing}',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  color: Colors.red[800],
                                                  fontSize: 30.sp),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: (){},// TODO: implement delete button
                                      child: Container(
                                        height: 90.sp,
                                        decoration: BoxDecoration(
                                            color: containerColor,
                                            border: Border.all(color: color,),
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(15.sp), bottomLeft: Radius.circular(10.sp))
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Delete',
                                            style: TextStyle(
                                                fontSize: 30.sp,
                                                color: color,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: (){},// TODO: implement Edit button
                                      child: Container(
                                        height: 90.sp,
                                        decoration: BoxDecoration(
                                          color: color,
                                          //border: Border(top: BorderSide(color: Colors.blue)),
                                          borderRadius: BorderRadius.only(topRight: Radius.circular(15.sp), bottomRight: Radius.circular(15.sp)),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Edit',
                                            style: TextStyle(
                                              fontSize: 30.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.all(10.sp),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.horizontal(right: Radius.circular(40.sp),left: Radius.circular(40.sp))
                          ),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Spacer(flex: 50,),
                                  Center(child: Text('Share to', style: TextStyle(fontSize: 35.sp, fontWeight: FontWeight.bold, color: color,),)),
                                  Spacer(flex: 40,),
                                  IconButton(
                                    icon: Icon(Icons.close, color: color,size: 30.sp,),
                                    onPressed: (){},// TODO: implement 'x' button
                                  )
                                ],
                              ),
                              SizedBox(height: 5.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  BottomButton(text: 'Facebook',imagePath: 'assets/images/Subtract.svg',),
                                  BottomButton(text: 'Whatsapp',imagePath: 'assets/images/Page-1.svg',),
                                  BottomButton(text: 'Gmail',imagePath: 'assets/images/super-g.svg',),
                                ],
                              ),
                              SizedBox(height: 20.h,),
                              GestureDetector(
                                onTap: (){} ,// TODO: implement this part i dont understand
                                child: Container(
                                  height: 90.h,
                                  width: 350.w,
                                  decoration: BoxDecoration(
                                      color: color,
                                      borderRadius: BorderRadius.circular(15.sp)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SvgPicture.asset('assets/images/Vector.svg'),
                                      SizedBox(width: 20.w,),
                                      Text('Share' , style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 30.sp),)
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h,)
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
        );
      },
    );
  }
}

class BottomButton extends StatelessWidget {
  final String text;
  final String imagePath;
  final VoidCallback onTap;

  const BottomButton ({Key key, this.text, this.imagePath, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.horizontal(left: Radius.circular(20),right: Radius.circular(20))
      ),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: onTap,
            child: Container(
              margin: EdgeInsets.all(20.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey[200])
              ),
              child: Padding(
                padding: EdgeInsets.all(20.0.sp),
                child: Center(child: SvgPicture.asset(imagePath,height: 40.h, width: 40.w,)),
              ),
            ),
          ),
          Text(text,style: TextStyle(fontSize: 30.sp),)
        ],
      ),
    );
  }
}

