import 'package:flutter/foundation.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
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
            AppLocalizations.of(context).editProfile,
            style: TextStyle(
              color: Theme.of(context).cursorColor,
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
                    child: !kIsWeb &&
                            defaultTargetPlatform == TargetPlatform.android
                        ? FutureBuilder<void>(
                            future: model.retrieveLostData(),
                            builder: (BuildContext context,
                                AsyncSnapshot<void> snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                case ConnectionState.waiting:
                                  return CircleAvatar(
                                    child: Text(
                                      AppLocalizations.of(context).notPickedImage,
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                case ConnectionState.done:
                                  return _previewImage(context, model);
                                default:
                                  if (snapshot.hasError) {
                                    return Text(
                                      'Pick image: ${snapshot.error}}',
                                      textAlign: TextAlign.center,
                                    );
                                  } else {
                                    return Text(
                                       AppLocalizations.of(context).notPickedImage,
                                      textAlign: TextAlign.center,
                                    );
                                  }
                              }
                            })
                        : _previewImage(context, model)),
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
                    child: Text(
                      model.image == null
                          ?  AppLocalizations.of(context).addProfilePicture
                          :  AppLocalizations.of(context).changePic,
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
                          onChanged: (value) => model.updateBusinessName(value),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                              color: Theme.of(context).textSelectionColor),
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
                          onChanged: (_businessName) =>
                              model.updateBusinessName(_businessName),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(border: InputBorder.none),
                          style: TextStyle(
                              color: Theme.of(context).textSelectionColor),
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
                    AppLocalizations.of(context).save,
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

Widget _previewImage(BuildContext context, EditProfileViewModel model) {
  final Text retrieveError = _getRetrieveErrorWidget(model);
  if (retrieveError != null) {
    return retrieveError;
  }

  return CircleAvatar(
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
  );
}

Text _getRetrieveErrorWidget(EditProfileViewModel model) {
  if (model.retrieveDataError != null) {
    final Text result = Text(model.retrieveDataError);
    model.retrieveDataError = null;
    return result;
  }
  return null;
}
