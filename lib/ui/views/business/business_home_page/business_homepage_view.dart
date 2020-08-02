import 'dart:io';

import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/views/business/business_card_page/business_cardpage_view.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/ui/views/business/business_card_page/business_cardpage_viewmodel.dart';
import 'package:mycustomers/ui/widgets/shared/custom_share_button.dart';
import 'package:screenshot/screenshot.dart';
import 'package:stacked/stacked.dart';

import 'business_homepage_viewmodel.dart';

class BusinessHomePageView extends StatelessWidget {
  final String profile = 'assets/icons/svg/profile.svg';
  final String settings = 'assets/icons/svg/settings.svg';
  final String support = 'assets/icons/svg/support.svg';
  final String businessCard = 'assets/icons/svg/business_card.svg';
  final String phoneNumber = 'assets/icons/svg/phone.svg';
  final String share = 'assets/icons/svg/share.svg';
  final String info = 'assets/icons/svg/info.svg';
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusinessHomePageViewModel>.reactive(
      builder: (context, model, child) {
        model.init();
        print('Called init');
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: SizeConfig.yMargin(context, 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).backgroundColor.computeLuminance() >
                                  0.5
                              ? Colors.white
                              : ThemeColors.black,
                    ),
                    child: ListTile(
                      title: Text(
                        AppLocalizations.of(context).editProfile,
                        style: TextStyle(
                          fontSize: SizeConfig.textSize(context, 5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: BrandColors.primary,
                        backgroundImage: model.currentStore.storePic != null
                            ? MemoryImage(model.currentStore.storePic)
                            : null,
                        minRadius: SizeConfig.xMargin(context, 7),
                        maxRadius: SizeConfig.xMargin(context, 7.3),
                        child: model.currentStore.storePic != null
                            ? Container()
                            : Text(
                                model.profileCardTitle.substring(0, 1),
                                style: TextStyle(
                                  color: ThemeColors.background,
                                  fontSize: SizeConfig.textSize(context, 6),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: Theme.of(context).cursorColor,
                      ),
                      onTap: () {
                        model.navigateToProfilePage();
                      },
                    ),
                  ),

                  optionButton(
                    context: context,
                    icon: phoneNumber,
                    label: AppLocalizations.of(context).regPhoneNo,
                    subtitle: '${model.pNum}',
                    opens: false,
                    // onTap: () => _displayBusinessCardModal(context, model)
                  ),

                  // optionButton(
                  //   context: context,
                  //   icon: businessCard,
                  //   label: 'Issue Digital Reciept',
                  //   // onTap: () => _displayBusinessCardModal(context, model),
                  // ),
                  optionButton(
                    context: context,
                    icon: settings,
                    label: AppLocalizations.of(context).settings,
                    onTap: model.navigateToSettingsPage,
                  ),
                  optionButton(
                    context: context,
                    icon: support,
                    //TODO Help and Support Localization
                    label: 'Help and Support',
                    onTap: model.navigateToSupportPage,
                  ),
                  optionButton(
                    context: context,
                    icon: info,
                    label: 'About us',
                    onTap: model.navigateToAboutUsPage,
                  ),
                  SizedBox(height: SizeConfig.yMargin(context, 3)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: SizeConfig.xMargin(context, 7)),
                    child: ViewModelBuilder<BusinessCardPageViewModel>.reactive(
                      builder: (_, businessCardModel, ___) {
                        print(businessCardModel.init);
                        businessCardModel.init();
                        return Column(
                          children: <Widget>[
                            BusinessCardWidget(
                              showArrow: false,
                              screenshotController: screenshotController,
                            ),
                            SizedBox(height: SizeConfig.yMargin(context, 2)),
                            Container(
                              height: SizeConfig.yMargin(context, 5),
//                              width: SizeConfig.xMargin(context, 55),
                              child: CustomShareRaisedButton(
                                txtColor: ThemeColors.background,
                                btnColor: BrandColors.primary,
                                btnText: 'Share your business card',
                                borderColor: BrandColors.primary,
                                child: SvgPicture.asset(
                                  share,
                                  height: SizeConfig.xMargin(context, 5),
                                  color: ThemeColors.background,
                                ),
                                onPressed: () {
                                  screenshotController
                                      .capture(
                                    pixelRatio: ScreenUtil.pixelRatio,
                                    delay: Duration(milliseconds: 10),
                                  )
                                      .then(
                                    (File image) {
                                      businessCardModel.imageFile = image;
                                      FlushbarHelper.createSuccess(
                                        duration: const Duration(seconds: 5),
                                        message: 'Sharing...',
                                      ).show(context);
                                      businessCardModel.shareImageAndText();
                                      FlushbarHelper.createSuccess(
                                        duration: const Duration(seconds: 5),
                                        message: 'Loading...',
                                      ).show(context);
                                    },
                                  ).catchError(
                                    (onError) {
                                      FlushbarHelper.createError(
                                        duration: const Duration(seconds: 5),
                                        message: onError.toString(),
                                      ).show(context);
                                    },
                                  );
                                  return;
                                },
                              ),
                              constraints: BoxConstraints(
                                maxWidth: SizeConfig.xMargin(context, 68),
                              ),
                            )
                          ],
                        );
                      },
                      viewModelBuilder: () => BusinessCardPageViewModel(),
                      onModelReady: (model) => model.init(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => BusinessHomePageViewModel(),
    );
  }

  Container optionButton({
    BuildContext context,
    String label,
    Function onTap,
    String icon,
    String subtitle,
    bool opens: true,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor.computeLuminance() > 0.5
            ? Colors.white
            : ThemeColors.black,
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(label),
        subtitle: subtitle != null
            ? Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(subtitle),
                    Padding(
                      padding: EdgeInsets.only(
//                          left: SizeConfig.xMargin(context, 7),
                          right: SizeConfig.xMargin(context, 4)),
                      child: Divider(
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              )
            : null,
        leading: CircleAvatar(
          backgroundColor: ThemeColors.background,
          minRadius: SizeConfig.xMargin(context, 4),
          maxRadius: SizeConfig.xMargin(context, 6),
          child: SvgPicture.asset(
            icon,
            semanticsLabel: label,
            color: BrandColors.primary,
          ),
        ),
        trailing: opens
            ? Icon(
                Icons.chevron_right,
                color: Theme.of(context).cursorColor,
              )
            : null,
      ),
    );
  }
}
