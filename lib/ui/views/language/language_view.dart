import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'language_viewmodel.dart';

class LanguageView extends StatelessWidget {

  
  @override
  
  Widget build(BuildContext context) {

     SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    //  statusBarBrightness: Brightness.dark,
    ),
     );

    return ViewModelBuilder<LanguageViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Color(0xFFFAFAFA),
        appBar: AppBar(
          title: Text(
            'Select Language',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
              color: Color(0xFF191919),
            ),
          ),
          centerTitle: false,
          backgroundColor: Colors.grey.shade200,
          elevation: 0,
//          automaticallyImplyLeading: false,
        ),

        body: SafeArea(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(bottom: 23.h),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(13, 71, 126, 200),
                      offset: Offset(0, 4),
                      blurRadius: 4,
                    )
                  ],
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Color(0xFFE8E8E8),
                  ),
                  color: Colors.white,
                ),
                child: Material(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 0.5 * 48.h,
                      backgroundColor: Color(0xFF1D6AFF),
                      child: Text(
                        model.languages[index]['code'].toUpperCase(),
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Color(0xFFF2F2F2),
                        ),
                      ),
                    ),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          model.languages[index]['name'],
                          style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFF333333),
                        ),
                      ],
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 11.5.h,
                    ),
                    onTap: () {
                      model.setLanguage(index);
                    },
                  ),
                ),
              );
            },
            itemCount: model.languages.length,
            padding: EdgeInsets.symmetric(
              horizontal: 19.w,
              vertical: 18.h,
            ),
          ),
        ),
      ),
      viewModelBuilder: () => LanguageViewModel(),
    );
  }
}
