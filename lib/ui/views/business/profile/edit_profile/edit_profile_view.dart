import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
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
    return ViewModelBuilder<EditProfileViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: customizeAppBar(context, 0,
              children: [
                Center(
                  child: FlatButton(
                    child: Text('Save'),
                    onPressed: model.save,
                  ),
                ),
              ],
              title: AppLocalizations.of(context).profile,
              arrowColor: BrandColors.primary,
              backgroundColor: Theme.of(context).backgroundColor),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          _previewImage(context, model),
                          SizedBox(width: SizeConfig.xMargin(context, 6),),
                          Text(
                            model.userName.isEmpty ? '' : model.userName,
                            style: TextStyle(
                              color: BrandColors.primary,
                              fontSize: SizeConfig.textSize(context, 6),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: SizeConfig.xMargin(context, 5),),
                          Icon(Icons.edit, color: Theme.of(context).brightness== Brightness.dark
                            ?Colors.white:Colors.black,)
                        ],
                      ),
                      SizedBox(height: SizeConfig.yMargin(context, 5),),
                      EditField(
                        fieldName:  AppLocalizations.of(context).storeName,
                        hintText: AppLocalizations.of(context).storeName,
                      ),
                      Divider(),
                      EditField(
                        fieldName: AppLocalizations.of(context).phoneNumber,
                        hintText: AppLocalizations.of(context).phoneNumber,
                      ),
                      Divider(),
                      EditField(
                        fieldName: AppLocalizations.of(context).emailAddress,
                        hintText: AppLocalizations.of(context).emailAddress,
                      ),
                      Divider(),
                      EditField(
                        //TODO:  Localize Location
                        fieldName:  'Address',
                        hintText: 'Address',
                      ),
                      Divider(),
                      EditField(
                        //TODO:  Localize tagline
//                        fieldName: AppLocalizations.of(context).companyTagLine,
//                        hintText: AppLocalizations.of(context).companyTagLine,
                        fieldName: 'Tag Line',
                        hintText: 'Tag Line',
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
                      Icon(Icons.power_settings_new,color: ThemeColors.background,),
                      SizedBox(width: SizeConfig.xMargin(context, 2),),
                      Text(AppLocalizations.of(context).signOut,style: TextStyle(
                        color: ThemeColors.background,
                      ),)
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
        model.initt();
      },
    );
  }
}

// ignore: must_be_immutable
class EditField extends HookViewModelWidget<EditProfileViewModel> {
  final String fieldName;
  final String hintText;
  final Function(String value,
      {EditProfileViewModel model, TextEditingController controller}) onChanged;
  TextEditingController controller;
  final String initialValue;

  EditField(
      {Key key,
      this.hintText: '',
      this.initialValue,
      @required this.fieldName,
      this.onChanged,
      this.controller})
      : super(key: key, reactive: false) {
    assert(controller == null || initialValue == null);
    if (controller == null) {
      controller = TextEditingController(text: initialValue);
    }
  }
  @override
  Widget buildViewModelWidget(
      BuildContext context, EditProfileViewModel viewModel) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              '$fieldName:',
            ),
          ),
          Expanded(
            flex: 2,
            child: TextFormField(
              decoration: InputDecoration.collapsed(hintText: hintText),
              controller: controller,
              onChanged: (val) {
                if (onChanged != null) {
                  onChanged(val,
                      model: viewModel,
                      controller: controller);
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
            model.userName.isEmpty ? '' : model.userName.substring(0, 1),
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
