import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/size_extension.dart';

import 'schedule_remider_viewmodel.dart';
class ScheduleReminders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context, width: width, height: height);
    return ViewModelBuilder<ScheduleReminderViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: ()=>Navigator.of(context).pop(),
            icon:Icon(Icons.arrow_back,color: BrandColors.primary),
          ),
          title: Text('Schedule Reminder',style:  TextStyle(
            fontSize: 18.sp,),),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Pick a date and type in your message',style:  TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,),),
                  SizedBox(height: 20.h,),
                  TextField(
                    style:  TextStyle(
                      fontSize: 16.sp,),
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.calendar_today),
                      hintText: 'Type a heading',
                      hintStyle: TextStyle(
                        fontSize: 16.sp,),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color:  ThemeColors.gray[500],),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder:  OutlineInputBorder(
                        borderSide: BorderSide(color:  BrandColors.primary,),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  TextField(
                    style:  TextStyle(
                      fontSize: 16.sp,),
                    decoration: InputDecoration(
                      hintText: 'Type a heading',
                      hintStyle: TextStyle(
                        fontSize: 16.sp,),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color:  ThemeColors.gray[500],),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder:  OutlineInputBorder(
                        borderSide: BorderSide(color:  BrandColors.primary,),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  TextField(
                    style:  TextStyle(
                      fontSize: 16.sp,),
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Start typing your message',
                      hintStyle: TextStyle(
                        fontSize: 16.sp,),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color:  ThemeColors.gray[500],),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder:  OutlineInputBorder(
                        borderSide: BorderSide(color:  BrandColors.primary,),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
          ),
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 20,
              ),
              child: Container(
                height: 50.h,

                child: Expanded(
                  child: InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: BrandColors.primary,
                        ),
                        child: Center(
                          child: Text('SCHEDULE',style:  TextStyle(fontSize: 18.sp,
                              color: Colors.white),
                          ),
                        ),
                      )),
                ),
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => ScheduleReminderViewModel(),
    );
  }
}
