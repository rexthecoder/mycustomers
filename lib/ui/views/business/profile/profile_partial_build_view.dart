import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mycustomers/ui/views/business/profile/profile_partial_build_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:flutter_screenutil/size_extension.dart';

class ProfilePartialBuildsView extends StatelessWidget {
  const ProfilePartialBuildsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        ScreenUtil.init(context, height: 1440, width: 720, allowFontScaling: true);

    return ViewModelBuilder<ProfilePartialBuildViewModel>.reactive(
      builder: (context, model, child) => _StringForm(),
      viewModelBuilder: () => ProfilePartialBuildViewModel(),
    );
  }
}

class _StringForm extends HookViewModelWidget<ProfilePartialBuildViewModel> {
  _StringForm({Key key}) : super(key: key, reactive: true);

  @override
  Widget buildViewModelWidget(
      BuildContext context, 
      ProfilePartialBuildViewModel model) {
    var userName = useTextEditingController();
    var businessName=useTextEditingController();
    var phoneNumber = useTextEditingController();

    return Container(
      height:580.h,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
      Expanded(
          child: Container(
          height:21.h,
          decoration: BoxDecoration(
            border:Border.all(
              color: ThemeColors.gray.shade700,
              width: 1),
              borderRadius: BorderRadius.circular(5.sp)
          ),
          
          child:Row(
           mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.left,
                  controller: businessName,
                  onChanged: model.updateBusinessName,
                  decoration:InputDecoration(
                    hintText:'John Wayforf',
                    hintStyle: model.fontSize,
                    border: OutlineInputBorder(
                      borderSide:BorderSide.none
                    )
                  )
                ),
              ),
             GestureDetector(
               onTap:(){},
               child:Padding(
                 padding:  EdgeInsets.all(8.h),
                 child: Icon(
                   Icons.border_color,
                   color: ThemeColors.gray.shade700,
                 ),
               )
             )
            ],)
        ),
      ),
      SizedBox(height: 24.h,),

      Expanded(
          child: Container(
          decoration: BoxDecoration(
            border:Border.all(
              color: ThemeColors.gray.shade700,
              width: 1),
              borderRadius: BorderRadius.circular(5.sp)

          ),
          child:Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                  child: Center(
                    child: TextField(
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.left,
                    controller:userName ,
                    onChanged: model.updateBusinessName,
                    decoration:InputDecoration(
                      hintText: 'Wike Oshiomole',
                      hintStyle: model.fontSize,
                      border: OutlineInputBorder(
                        borderSide:BorderSide.none
                      )

                    )
                ),
                  ),
              ),
              GestureDetector(
                onTap:(){},
                child:Padding(
                  padding:  EdgeInsets.all(8.h),
                  child: Icon(
                    Icons.border_color,
                    color:ThemeColors.gray.shade700
                  ),
                )
              )
            ],)
        ),
      ),
      SizedBox(height:24.h),

       Expanded(
            child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: ThemeColors.gray.shade700,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(4.sp)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(14.h),
                  child: DropdownButton(
                    underline: Container(),
                    value: model.dropDownValue,
                    items: model.countryCode
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      model.updateCountryCode(newValue);
                    },
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: ThemeColors.black,
                    ),
                  ),
                ),
                Container(
                    height: 24.h,
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(
                              color: ThemeColors.gray.shade700
                              )))),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      hintText: '0903 9393 9383',
                      hintStyle: model.fontSize,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    controller: phoneNumber,
                    onChanged: model.updateUserPhoneNumber,
                  ),
                )
              ],
            )),
       ),

 SizedBox(height:24.h),
       Expanded(
         child: Container(
           decoration: BoxDecoration(
             border:Border.all(
               color:ThemeColors.gray.shade700,
               width: 1 ),
               borderRadius: BorderRadius.circular(5.sp)
           ),
           child:Column(
             children: <Widget>[
              Expanded(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal:14.w),
                  child: GestureDetector(
                    onTap: (){
                       model.navigateToAddAssistantPage();
                    },
                        child: Row(
                      children: <Widget>[
                      Icon(Icons.people_outline,
                      color:ThemeColors.black),
                      SizedBox(width:16.w),
                      Text('Add Assistant',
                      style:TextStyle(
                        color:ThemeColors.gray.shade800,
                        fontSize: 28.sp,
                      )),
                      SizedBox(width: 65.w),
                      Spacer(),
                      Icon(Icons.add,
                      color: BrandColors.secondary,
                      ),
                      SizedBox(width:12.w),
                      
                      Text('Add',
                      style: TextStyle(
                        color:BrandColors.secondary,
                        fontSize: 30.sp
                      ),)

                      ],
                    ),
                  ),
                ),)

             ],
           ),
           )
         )
         ]
         ),
    );
    
         
        
      
  }
}




