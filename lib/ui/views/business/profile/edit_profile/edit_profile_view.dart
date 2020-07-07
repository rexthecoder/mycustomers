import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:flutter_screenutil/size_extension.dart';

import 'edit_profile_viewmodel.dart';

class EditProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _userName = TextEditingController(text: 'Casper');
    TextEditingController _businessName =
        TextEditingController(text: 'WearSmute');

    return ViewModelBuilder<EditProfileViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            'Edit Profile',
            style: TextStyle(
              color: ThemeColors.black,
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.textSize(context, 6),
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          iconTheme: IconThemeData(color: BrandColors.primary),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: CircleAvatar(
                    backgroundColor: ThemeColors.unselect,
                    child: model.image == null
                        ? Text(
                            'C',
                            style: TextStyle(
                              color: BrandColors.primary,
                              fontSize: SizeConfig.textSize(context, 18),
                            ),
                          )
                        : ClipOval(
                            child: Image.file(
                              model.image,
                              width: SizeConfig.xMargin(context, 50),
                              height: SizeConfig.xMargin(context, 50),
                              fit: BoxFit.cover,
                            ),
                          ),
                    radius: 70,
                  ),
                ),
                SizedBox(height: SizeConfig.yMargin(context, 2)),
                Container(
                  height: SizeConfig.yMargin(context, 8),
                  width: SizeConfig.xMargin(context, 70),
                  decoration: BoxDecoration(
                    color: BrandColors.primary,
                    borderRadius: BorderRadius.circular(8.sp),
                  ),
                  child: FlatButton(
                    onPressed: model.getImagefromGallery,
                    //  TODO Implement the action that should be taken once the button is clicked
                    child: Text(
                      model.image == null
                          ? 'Add a Profile Picture'
                          : 'Change Profile Picture',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: SizeConfig.textSize(context, 4),
                          color: ThemeColors.background),
                    ),
                  ),
                ),
                Divider(color: ThemeColors.gray.shade600),
                SizedBox(height: SizeConfig.yMargin(context, 2.5)),
                Column(
                  children: <Widget>[
                    Container(
                      height: SizeConfig.yMargin(context, 8),
                      width: SizeConfig.xMargin(context, 90),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.sp),
                          border: Border.all(color: ThemeColors.gray.shade600)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.xMargin(context, 4),
                        ),
                        child: TextField(
                          controller: _userName,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: TextStyle(color: BrandColors.primary),
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.yMargin(context, 2)),
                    Container(
                      height: SizeConfig.yMargin(context, 8),
                      width: SizeConfig.xMargin(context, 90),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.sp),
                          border: Border.all(color: ThemeColors.gray.shade600)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.xMargin(context, 4)),
                        child: TextField(
                          controller: _businessName,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(border: InputBorder.none),
                          style: TextStyle(color: BrandColors.primary),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: SizeConfig.yMargin(context, 18),
                ),
                FlatButton(
                  color: BrandColors.primary,
                  onPressed: () {
                    // TODO Implement function to save the values that have been updated
                  },
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.xMargin(context, 41),
                    vertical: SizeConfig.yMargin(context, 2.6),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Save',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ThemeColors.background,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.yMargin(context, 2),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.yMargin(context, 2),
                )
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => EditProfileViewModel(),
    );
  }
}
