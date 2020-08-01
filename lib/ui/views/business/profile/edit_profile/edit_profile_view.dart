import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/theme/theme_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/widgets/shared/partial_build.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'edit_profile_viewmodel.dart';

class EditProfileView extends HookWidget {
  @override
  Widget build(BuildContext context) {
//    return ViewModelBuilder<EditProfileViewModel>.reactive(
//      builder: (context, model, child) {
//        return Scaffold(
//          resizeToAvoidBottomInset: false,
//          appBar: customizeAppBar(context, 0,
//              children: [
//                FlatButton(
//                  child: Text('Save'),
//                  onPressed: model.save,
//                ),
//              ],
//              title: AppLocalizations.of(context).editProfile,
//              arrowColor: BrandColors.primary,
//              backgroundColor: Theme.of(context).backgroundColor),
//          body: SafeArea(
//            child: SingleChildScrollView(
//              child: Center(
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: <Widget>[
//                        _previewImage(context, model),
//                      ],
//                    ),
//                    EditField(
//                      fieldName: 'Store name',
//                    ),
//                    EditField(
//                      fieldName: 'Phone number',
//                    ),
//                    CustomRaisedButton(
//                      txtColor: ThemeColors.background,
//                      btnColor: ThemeColors.error,
//                      borderColor: ThemeColors.error,
//                      btnText: AppLocalizations.of(context).signOut,
//                      child: Container(),
//                      onPressed: () {
//                        model.save();
//                        flusher(AppLocalizations.of(context).save, context);
//                      },
//                    ),
//                    SizedBox(
//                      height: SizeConfig.yMargin(context, 2),
//                    )
//                  ],
//                ),
//              ),
//            ),
//          ),
//        );
//      },
//      viewModelBuilder: () => EditProfileViewModel(),
//      onModelReady: (model) {
//        model.initt();
//      },
//    );
    return ViewModelBuilder<EditProfileViewModel>.nonReactive(
      builder: (context, model, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: customizeAppBar(
            context,
            0,
            children: [
              Center(
                child: CustomPartialBuild<SettingManagerModel>(
                  builder: (_, __) => FlatButton(
                    child: Text('Save'),
                    onPressed: () async {await model.save(); __.reload();},
                  ),
                ),
              ),
            ],
            title: AppLocalizations.of(context).profile,
            arrowColor: BrandColors.primary,
            backgroundColor: Theme.of(context).backgroundColor,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              CustomPartialBuild<EditProfileViewModel>(
                                builder: (context, model) =>
                                    _previewImage(context, model),
                                reactive: true,
                              ),
                              Positioned(
                                top: -SizeConfig.xMargin(context, 2),
                                right: -SizeConfig.xMargin(context, 2),
                                child: GestureDetector(
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ThemeColors.gray,
                                      border: Border.all(
                                        color: ThemeColors.background,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.photo_camera,
                                      size: SizeConfig.xMargin(context, 5),
                                      color: ThemeColors.background,
                                    ),
                                  ),
                                  onTap: model.getImagefromGallery,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: SizeConfig.xMargin(context, 6),
                          ),
                          Expanded(
                            child: NameEditWidget(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.yMargin(context, 5),
                      ),
                      EditField(
                        fieldName: AppLocalizations.of(context).storeName,
                        hintText: AppLocalizations.of(context).storeName,
                        initialValue: model.currentStore.name,
                        onChanged: model.updateBusinessName,
                      ),
                      Divider(),
                      EditField(
                        fieldName: AppLocalizations.of(context).phoneNumber,
                        hintText: AppLocalizations.of(context).phoneNumber,
                        initialValue: model.currentUser.phoneNumber,
                        onChanged: model.updatePNum,
                      ),
                      Divider(),
                      EditField(
                        fieldName: AppLocalizations.of(context).emailAddress,
                        hintText: AppLocalizations.of(context).emailAddress,
                        initialValue: model.currentUser.email,
                        onChanged: model.updateEmail,
                      ),
                      Divider(),
                      EditField(
                        //TODO:  Localize Location
                        fieldName: 'Address',
                        hintText: 'Address',
                        initialValue: model.address ?? model.currentStore.address,
                        onChanged: model.updateAddress,
                      ),
                      Divider(),
                      EditField(
                        //TODO:  Localize tagline
//                        fieldName: AppLocalizations.of(context).companyTagLine,
//                        hintText: AppLocalizations.of(context).companyTagLine,
                        fieldName: 'Tag Line',
                        hintText: 'Tag Line',
                        initialValue: model.currentStore.tagline,
                        onChanged: model.updateTagline,
                      ),
                      Divider(),
                    ],
                  ),
                ),
                CustomRaisedButton(
                  txtColor: ThemeColors.background,
                  btnColor: Colors.red,
                  borderColor: ThemeColors.error,
                  btnText: '',
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.power_settings_new,
                        color: ThemeColors.background,
                      ),
                      SizedBox(
                        width: SizeConfig.xMargin(context, 2),
                      ),
                      Text(
                        AppLocalizations.of(context).signOut,
                        style: TextStyle(
                          color: ThemeColors.background,
                        ),
                      )
                    ],
                  ),
                  onPressed: () {
                    model.save();
                    flusher(AppLocalizations.of(context).save, context);
                  },
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => EditProfileViewModel(),
      onModelReady: (model) {
        // TODO: Implement init
      },
    );
  }
}

class NameEditWidget extends ViewModelWidget<EditProfileViewModel> {
  const NameEditWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, EditProfileViewModel model) {
    return model.editing ? Row(
      children: <Widget>[
        Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).dividerColor,
                  ),
                ),
              ),
              child: TextFormField(
                initialValue: (model.currentUser?.firstName?.isEmpty ?? true)
                    ? ''
                    : model.currentUser.firstName,
                onChanged: model.updateUserName,
                decoration: InputDecoration.collapsed(hintText: 'Your name'),
                autofocus: true,
              ),
            ),
          ),

        SizedBox(
          width: SizeConfig.xMargin(context, 3),
        ),
        CustomPartialBuild<SettingManagerModel>(
          builder: (_, __) => IconButton(
            icon: Icon(
              Icons.save,
              color:
              Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ), onPressed: () async {
                await model.switchEditingState();
                __.reload();
              },
          ),
        ),
      ],
    ) : Row(
      children: <Widget>[
        Expanded(
          child: Text(
            (model.currentUser?.firstName?.isEmpty ?? true)
                ? ''
                : model.currentUser.firstName,
            style: TextStyle(
              color: BrandColors.primary,
              fontSize: SizeConfig.textSize(context, 6),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: SizeConfig.xMargin(context, 5),
        ),
        IconButton(
          icon: Icon(
            Icons.edit,
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
          ), onPressed: model.switchEditingState,
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class EditField extends ViewModelWidget<EditProfileViewModel> {
  final String fieldName;
  final String hintText;
  final Function(String value) onChanged;
  final Function(String value,
      {EditProfileViewModel model,
      TextEditingController controller}) onChangedWithExtra;
  TextEditingController controller;
  final String initialValue;

  EditField(
      {Key key,
      this.hintText: '',
      this.initialValue,
      this.onChangedWithExtra,
      @required this.fieldName,
      this.onChanged,
      this.controller})
      : super(key: key, reactive: false) {
    assert(controller == null || initialValue == null);
    assert(onChanged == null || onChangedWithExtra == null);
    if (controller == null) {
      controller = TextEditingController.fromValue(TextEditingValue(text: initialValue ?? ''));
    }
  }
  @override
  Widget build(
      BuildContext context, EditProfileViewModel viewModel) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              '$fieldName:',
            ),
          ),
          SizedBox(width: 3),
          Expanded(
            flex: 2,
            child: TextFormField(
              decoration: InputDecoration.collapsed(hintText: hintText),
              controller: controller,
              onChanged: (val) {
                if (onChanged != null) {
                  onChanged(val);
                } else if (onChangedWithExtra != null) {
                  onChangedWithExtra(val,
                      model: viewModel, controller: controller);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget _previewImage(BuildContext context, EditProfileViewModel model) {
  return CircleAvatar(
    backgroundColor: ThemeColors.unselect,
    backgroundImage: model.currentStore.storePic == null
        ? null
        : MemoryImage(model.currentStore.storePic),
    child: model.currentStore.storePic == null
        ? Text(
            (model.currentUser.firstName?.isEmpty ?? true)
                ? ''
                : model.currentUser.firstName.substring(0, 1),
            style: TextStyle(
              color: BrandColors.primary,
              fontSize: SizeConfig.textSize(context, 8),
              fontWeight: FontWeight.bold,
            ),
          )
        : Container(), // SizedBox.expand(child: Image.memory(model.currentStore.storePic, fit: BoxFit.cover)),
    radius: SizeConfig.xMargin(context, 10),
  );
}
//Widget _previewImage(BuildContext context, EditProfileViewModel model) {
////  final Text retrieveError = _getRetrieveErrorWidget(model);
////  if (retrieveError != null) {
////    return retrieveError;
////  }
////  print('here');
//
//  return CircleAvatar(
//    backgroundColor: ThemeColors.unselect,
//    backgroundImage: model.currentStore.storePic == null
//        ? null
//        : MemoryImage(model.currentStore.storePic),
//    child: model.currentStore.storePic == null
//        ? Text(
//            model.userName.isEmpty ? '' : model.userName.substring(0, 1),
//            style: TextStyle(
//              color: BrandColors.primary,
//              fontSize: SizeConfig.textSize(context, 18),
//              fontWeight: FontWeight.bold,
//            ),
//          )
//        : Container(), // SizedBox.expand(child: Image.memory(model.currentStore.storePic, fit: BoxFit.cover)),
//    radius: 70,
//  );
//}

//Text _getRetrieveErrorWidget(EditProfileViewModel model) {
//  if (model.retrieveDataError != null) {
//    final Text result = Text(model.retrieveDataError);
//    model.retrieveDataError = null;
//    return result;
//  }
//  return null;
//}
