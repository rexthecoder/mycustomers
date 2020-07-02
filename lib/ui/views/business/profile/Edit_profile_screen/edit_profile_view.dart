import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_text_style.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:flutter_screenutil/size_extension.dart';

import 'edit_profile_viewmodel.dart';

class EditProfileView extends StatelessWidget{
  TextEditingController _userName=TextEditingController(text: 'Casper');
  TextEditingController _businessName= TextEditingController(text: 'WearSmute');

  @override
  Widget build(BuildContext context){
    return ViewModelBuilder<EditProfileViewModel>.reactive(
      builder: (context,model, child) => Scaffold(
        appBar: AppBar(
          title:Text(model.pageTitle,
          style:kheadingText
          ),
          centerTitle: true,
          elevation:0.0,
          iconTheme: IconThemeData(
            color:BrandColors.primary
          ),
        ),
        body:SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                  child: CircleAvatar(
                  backgroundColor:ThemeColors.unselect,
                  child:model.addImage(context),
                  radius: 70,
                ),
              ),
              SizedBox(height:SizeConfig.yMargin(context, 2)),
              Container(
                height: SizeConfig.yMargin(context,8),
                width: SizeConfig.xMargin(context, 70),
                decoration: BoxDecoration(
                  color:BrandColors.primary,
                  borderRadius: BorderRadius.circular(8.sp)
                ),
                child:FlatButton(
                  onPressed: model.getImagefromGallery,//  Implement the action that should be taken once the button is clicked
                  child: Text(model.profilePicBtn,
                  textAlign: TextAlign.center,
                  style:TextStyle(
                    fontSize:SizeConfig.textSize(context,4),
                    color: ThemeColors.background
                  )
                  ),)
              ),
              Divider(
                color:ThemeColors.gray.shade600
              ),
              SizedBox(height:8),
              Expanded(
                  child: Column(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                        height: SizeConfig.yMargin(context,8),
                        width: SizeConfig.xMargin(context, 90),
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(5.sp),
                          border: Border.all(
                            color: ThemeColors.gray.shade600
                          )
                        ),
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: SizeConfig.xMargin(context, 4)),
                          child: TextField(
                          controller: _userName,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                      ),
                          style: TextStyle(
                            color:BrandColors.primary
                          ),
                      ),
                        ),
                      ),
                    ),

                    SizedBox(height:SizeConfig.yMargin(context,2)),

                    Expanded(
                        child: Container(
                        height: SizeConfig.yMargin(context,8),
                        width: SizeConfig.xMargin(context, 90),
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(5.sp),
                          border: Border.all(
                            color: ThemeColors.gray.shade600
                          )
                        ),
                        child:Padding(
                          padding: EdgeInsets.symmetric(horizontal: SizeConfig.xMargin(context, 4)),
                          child: TextField(
                          controller: _businessName,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border:InputBorder.none
                          ),
                          style: TextStyle(
                            color:BrandColors.primary
                          ),
                      ),
                        )        
                      ),
                    )
                   
                    ],),
              ),
              Spacer(),

             Container(
                   height: SizeConfig.yMargin(context, 8),
                   width: SizeConfig.xMargin(context, 95),
                   alignment: Alignment.center,
                   margin: EdgeInsets.only(bottom:18.h),
                   decoration: BoxDecoration(
                     borderRadius:BorderRadius.circular(8.sp),
                     color: BrandColors.primary
                     
                   ),
                   child:FlatButton(
                     onPressed:(){
                       // Implement function to save the values that have been updated
                     } ,
                     child: Text(
                       model.mainBtnText,
                       textAlign: TextAlign.center,
                       style:TextStyle(
                         color:ThemeColors.background,
                         fontStyle: FontStyle.normal,
                         fontWeight: FontWeight.bold,
                         fontSize: SizeConfig.yMargin(context, 2),
                       )
                     )) ,),
            ],

          ),)
      ), 

      viewModelBuilder: ()=> EditProfileViewModel()
      );
  }
}