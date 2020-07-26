import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'edit_profile_viewmodel.dart';

class EditProfileView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditProfileViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: customizeAppBar(context, 0,
              children: [],
              title: AppLocalizations.of(context).editProfile,
              arrowColor: BrandColors.primary,
              backgroundColor: Theme.of(context).backgroundColor),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: SizeConfig.yMargin(context, 4)),
                  Align(
                    alignment: Alignment.topCenter,
                    child: _previewImage(context, model),
                  ),
                  SizedBox(height: SizeConfig.yMargin(context, 2)),
                  Container(
                    height: SizeConfig.yMargin(context, 6),
                    width: SizeConfig.xMargin(context, 60),
                    decoration: BoxDecoration(
                      color: BrandColors.primary,
                      borderRadius: BorderRadius.circular(8.sp),
                    ),
                    child: CustomRaisedButton(
                      txtColor: ThemeColors.background,
                      btnColor: BrandColors.primary,
                      btnText: model.currentStore.storePic == null
                          ? AppLocalizations.of(context).addProfilePicture
                          : AppLocalizations.of(context).changePic,
                      borderColor: BrandColors.primary,
                      child: Container(),
                      onPressed: model.getImagefromGallery,
                    ),
                  ),
                  SizedBox(height: SizeConfig.yMargin(context, 1.4)),
                  Divider(color: ThemeColors.gray.shade600),
                  SizedBox(height: SizeConfig.yMargin(context, 1.4)),
                  Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.yMargin(context, 0.7)),
                        //height: SizeConfig.yMargin(context, 8),
                        width: SizeConfig.xMargin(context, 90),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.sp),
                            border:
                                Border.all(color: ThemeColors.gray.shade600)),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.xMargin(context, 4),
                            ),
                            child: _StringForm()),
                      ),
                      SizedBox(height: SizeConfig.yMargin(context, 2)),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.yMargin(context, 0.7)),
                        //height: SizeConfig.yMargin(context, 8),
                        width: SizeConfig.xMargin(context, 90),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.sp),
                          border: Border.all(color: ThemeColors.gray.shade600),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.xMargin(context, 4),
                          ),
                          child: TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            onChanged: (value) =>
                                model.updateBusinessName(value),
                            initialValue: model.businessName,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText:
                                    AppLocalizations.of(context).businessName),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Theme.of(context).textSelectionColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.yMargin(context, 15),
                  ),
                  CustomRaisedButton(
                    txtColor: ThemeColors.background,
                    btnColor: BrandColors.primary,
                    borderColor: BrandColors.primary,
                    btnText: AppLocalizations.of(context).save,
                    child: Container(),
                    onPressed: () {
                      model.save();
                      flusher(AppLocalizations.of(context).save, context);
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.yMargin(context, 2),
                  )
                ],
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => EditProfileViewModel(),
      onModelReady: (model) {
        model.initt();
      },
    );
  }
}

class _StringForm extends HookViewModelWidget<EditProfileViewModel> {
  const _StringForm({Key key}) : super(key: key, reactive: false);

  @override
  Widget buildViewModelWidget(
      BuildContext context, EditProfileViewModel model) {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      initialValue: model.currentUser.firstName,
      keyboardType: TextInputType.text,
      onChanged: (value) => model.updateUserName(value),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: AppLocalizations.of(context).userName,
      ),
      style: TextStyle(
        color: Theme.of(context).textSelectionColor,
      ),
    );
  }
}

Widget _previewImage(BuildContext context, EditProfileViewModel model) {
//  final Text retrieveError = _getRetrieveErrorWidget(model);
//  if (retrieveError != null) {
//    return retrieveError;
//  }
//  print('here');

  return CircleAvatar(
    backgroundColor: ThemeColors.unselect,
    backgroundImage: model.currentStore.storePic == null
        ? null
        : MemoryImage(model.currentStore.storePic),
    child: model.currentStore.storePic == null
        ? Text(
            model.userName.isEmpty ? 'N' : model.userName.substring(0, 1),
            style: TextStyle(
              color: BrandColors.primary,
              fontSize: SizeConfig.textSize(context, 18),
              fontWeight: FontWeight.bold,
            ),
          )
        : Container(), // SizedBox.expand(child: Image.memory(model.currentStore.storePic, fit: BoxFit.cover)),
    radius: 70,
  );
}

//Text _getRetrieveErrorWidget(EditProfileViewModel model) {
//  if (model.retrieveDataError != null) {
//    final Text result = Text(model.retrieveDataError);
//    model.retrieveDataError = null;
//    return result;
//  }
//  return null;
//}
