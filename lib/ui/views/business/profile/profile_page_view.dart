import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/views/business/profile/profile_page_viewmodel.dart';
import 'package:mycustomers/ui/views/business/profile/profile_partial_build_view.dart';
import 'package:stacked/stacked.dart';
import 'package:mycustomers/ui/shared/const_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class ProfilePageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfilePageViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeColors.background,
          centerTitle:true,
          elevation: 1.0,
          title:Text(model.title,
          style:kheadingText,
          ),
          iconTheme: IconThemeData(
            color: BrandColors.secondary),
        ),
      
        
        body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:20.w),
              child: Stack(
               children: <Widget>[
                 Align(
                   alignment: Alignment.topCenter,
                   child: Container(
                     child: CircleAvatar(
                       backgroundColor: ThemeColors.gray.shade800,
                          radius: 40.0,
                          child:GestureDetector(
                            onTap:(){},
                            child:Icon(
                              Icons.add_a_photo,
                              color: ThemeColors.gray.shade600,
                            ) ,)
                     ),
                   )),
              
                  Align(
                    alignment: Alignment.center,
                    child: ProfilePartialBuildsView()),
                  Align(
                    alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 50,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom:15.0),
                      decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(5.0),
                        color: BrandColors.secondary
                        
                      ),
                      child:FlatButton(
                        onPressed: null, 
                        child: Text(
                          model.btnText,
                          textAlign: TextAlign.center,
                          style:TextStyle(
                            color:ThemeColors.background,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          )
                        )) ,),
                  )
                ],),
            ),
      ),
      ),
      viewModelBuilder: () => ProfilePageViewModel(),
    );
  }
}
