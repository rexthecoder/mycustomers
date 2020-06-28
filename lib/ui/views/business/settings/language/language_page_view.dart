import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/alert_dialog.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_text_style.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/views/business/settings/settings_viewmodel.dart';
import 'package:mycustomers/ui/views/home/language/language_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/size_extension.dart';


class LanguageSettingPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsHomePageViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title:Text(model.pageTitle,
          style: kheadingText
          ),
          elevation:0.0,
          centerTitle: true,
          backgroundColor: ThemeColors.background,
          iconTheme: IconThemeData(
            color: BrandColors.primary
          ),
        ),
        body: SafeArea(
            child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children:<Widget>[
                   Expanded(child: LanguageSelectionPageView()),
                   Spacer(),          
                   Container(
                   height: 105.h,
                   alignment: Alignment.center,
                   margin: EdgeInsets.only(bottom:18.h),
                   decoration: BoxDecoration(
                     borderRadius:BorderRadius.circular(8.sp),
                     color: BrandColors.primary
                     
                   ),
                   child:FlatButton(
                     onPressed:(){
                       //TODO Implement the action to be completed once the user clicks the save button
                     } ,
                     child: Text(
                       model.btnText,
                       textAlign: TextAlign.center,
                       style:TextStyle(
                         color:ThemeColors.background,
                         fontStyle: FontStyle.normal,
                         fontWeight: FontWeight.bold,
                         fontSize: 32.sp,
                       )
                     )) ,),
                ]
              ),
            ),
      ),
      ),
      viewModelBuilder: () => SettingsHomePageViewModel(),
    );
  }
}


class LanguageSelectionPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LanguageViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
            child:languageSelection(model,context),
      ),
      ),
      viewModelBuilder: () =>LanguageViewModel(),
    );
  }
}


Widget languageSelection (LanguageViewModel model, BuildContext context) =>
Container(
        height: SizeConfig.yMargin(context, 60),
        width: SizeConfig.xMargin(context, 90),
        child: ListView.builder(
          shrinkWrap: true,
            itemCount: model.languages.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.all(SizeConfig.yMargin(context, 1)),
                child: InkWell(
                  onTap: () {
                   model.setLanguage(index);
                   showConfirmationMessage(context);
                  },
                  child: Container(
                    height: SizeConfig.yMargin(context, 10),
                    width: SizeConfig.xMargin(context, 100),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.yMargin(context, 1)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                SizeConfig.yMargin(context, 5)),
                            child: Image(
                              height: SizeConfig.yMargin(context, 10),
                              fit: BoxFit.contain,
                              image: AssetImage(
                                model.languages[index]['image'],
                              ),
                            ),
                          ),
                        ),
                        Text(
                          model.languages[index]['name'],
                          style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: SizeConfig.yMargin(context, 2),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
                );