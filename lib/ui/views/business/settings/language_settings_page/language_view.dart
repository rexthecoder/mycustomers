import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'language_viewmodel.dart';
class LanguageSettings extends StatelessWidget {

  final Color color = ThemeColors.primary;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 1440, width: 720);
    return ViewModelBuilder<LanguageSettingsViewModel>.reactive(
      viewModelBuilder: ()=> LanguageSettingsViewModel(),
      builder: (context, model, child){
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: <Widget>[
              SizedBox(height: 40.h,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 130.h,
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: (){},// TODO: implement back button
                      icon: Icon(
                        Icons.keyboard_backspace,
                        color: color,
                      ),
                    ),
                    Spacer(),
                    Text('Settings',
                      style: TextStyle(
                          fontSize: 35.sp,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Spacer(flex: 2,),
                  ],
                ),
              ),
              Divider(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 60.w, right: 40.w, top: 40.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Select your language',
                        style: TextStyle(fontSize: 30.sp,fontWeight: FontWeight.w500),
                      ),
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: model.languages.map((language){
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: GestureDetector(
                                onTap: model.languageBoxColorChanger(model, language),// TODO: implement language button function
                                child: Container(
                                    padding: EdgeInsets.all(20.sp),
                                    alignment: Alignment.centerLeft,
                                    width: double.infinity,
                                    height: 120.h,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: model.currentIndex == model.languages.indexOf(language)? color : Colors.grey[200],
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(15.sp),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                            color: Colors.grey[100],
                                            //offset: Offset()
                                          ),
                                        ]),
                                    child: Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundColor: color,
                                          radius: 60.sp,
                                          // TODO: implement Language image
                                        ),
                                        Spacer(
                                          flex: 1,
                                        ),
                                        Text(
                                          language.language,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w500),
                                        ),
                                        Spacer(
                                          flex: 2,
                                        )
                                      ],
                                    )
                                  /*ListTile(
                                onTap:
                                leading: CircleAvatar(
                                  backgroundColor: color,
                                  radius: 60.sp,
                                ),
                                title: Text(language.language),
                              ),*/
                                ),
                              ),
                            );},
                          ).toList(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.h),
                        child: GestureDetector(
                          onTap: (){},// TODO: implement save button
                          child: Container(
                            width: double.infinity,
                            height: 100.h,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(15.sp),
                            ),
                            child: Center(
                              child: Text(
                                'Save',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30.sp,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50.h,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}


