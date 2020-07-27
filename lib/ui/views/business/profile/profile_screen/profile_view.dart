import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/views/business/profile/profile_screen/profile_viewmodel.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:stacked/stacked.dart';

class ProfilePageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainProfilePageViewModel>.reactive(
        builder: (context, model, child) {
          TextEditingController _userName =
              TextEditingController(text: model.userName);
          TextEditingController _businessName =
              TextEditingController(text: model.businessName);

          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: customizeAppBar(context, 1.0,
                children: [
                  FlatButton(
                    onPressed: model.navigateToEditProfilePage,
                    child: Text(
                      AppLocalizations.of(context).edit,
                      style: TextStyle(
                        fontSize: SizeConfig.textSize(context, 4.4),
                        color: Theme.of(context).textSelectionColor,
                      ),
                    ),
                  )
                ],
                title: AppLocalizations.of(context).profile,
                arrowColor: BrandColors.primary,
                backgroundColor: Theme.of(context).backgroundColor),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: SizeConfig.yMargin(context, 5)),
                  Center(
                    child: CircleAvatar(
                      backgroundColor: ThemeColors.unselect,
                      radius: SizeConfig.yMargin(context, 10),
                      child:
                          (model?.currentStore?.storePic?.isNotEmpty ?? false)
                              ? Image.memory(
                                  model.currentStore.storePic,
                                  fit: BoxFit.cover,
                                )
                              : Text(
                                  model.currentStore?.name?.substring(0, 1) ?? '',
                                  style: TextStyle(
                                    color: BrandColors.primary,
                                    fontSize: SizeConfig.textSize(context, 15),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.yMargin(context, 4)),
                  Divider(color: ThemeColors.gray.shade600),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                        left: SizeConfig.yMargin(context, 4),
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  AppLocalizations.of(context).name + ":",
                                  style: TextStyle(
                                    color: BrandColors.primary,
                                    fontSize: SizeConfig.textSize(context, 5),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 30),
                                Expanded(
                                  child: TextField(
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    autofocus: false,
                                    controller: TextEditingController(text: model.currentStore.name),
                                    textAlign: TextAlign.left,
                                    decoration: InputDecoration(
                                      enabled: false,
                                      border: InputBorder.none,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  AppLocalizations.of(context).businessName +
                                      ":",
                                  style: TextStyle(
                                    color: BrandColors.primary,
                                    fontSize: SizeConfig.textSize(context, 5),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 18),
                                Expanded(
                                  child: TextField(
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    autofocus: false,
                                    controller: TextEditingController(text: model.currentStore.name),
                                    textAlign: TextAlign.left,
                                    decoration: InputDecoration(
                                      enabled: false,
                                      border: InputBorder.none,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        viewModelBuilder: () => MainProfilePageViewModel());
  }
}
