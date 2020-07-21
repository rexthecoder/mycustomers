import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/views/business/business_card_page/business_cardpage_view.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/ui/views/business/business_card_page/business_cardpage_viewmodel.dart';
import 'package:screenshot/screenshot.dart';
import 'package:stacked/stacked.dart';

import 'business_homepage_viewmodel.dart';

class BusinessHomePageView extends StatelessWidget {
  final String profile = 'assets/icons/svg/profile.svg';
  final String settings = 'assets/icons/svg/settings.svg';
  final String support = 'assets/icons/svg/support.svg';
  final String businessCard = 'assets/icons/svg/business_card.svg';
  final String phoneNumber = 'assets/icons/svg/phone.svg';
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusinessHomePageViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: SizeConfig.yMargin(context, 11),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor.computeLuminance() > 0.5 ? Colors.white : ThemeColors.black,
                ),
                child: ListTile(
                  // subtitle: Text(
                  //   model.profileCardSubtitle,
                  //   style: TextStyle(
                  //     fontSize: SizeConfig.textSize(context, 3.4),
                  //   ),
                  // ),
                  title: Text(
                    model.profileCardTitle,
                    style: TextStyle(
                      fontSize: SizeConfig.textSize(context, 5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: BrandColors.primary,
                    minRadius: SizeConfig.xMargin(context, 7),
                    maxRadius: SizeConfig.xMargin(context, 8),
                    child: Text(
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
                  onTap: model.navigateToProfilePage,
                ),
              ),
              optionButton(
                context: context,
                icon: phoneNumber,
                label: 'Registered Phone Number',
                subtitle: '${model.businessCard.phoneNumber}',
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
                label: AppLocalizations.of(context).support,
                onTap: model.navigateToSupportPage,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: SizeConfig.xMargin(context, 7)),
                child:
                    ViewModelBuilder<BusinessCardPageViewModel>.nonReactive(
                  builder: (_, __, ___) => BusinessCardWidget(
                      screenshotController: screenshotController),
                  viewModelBuilder: () => BusinessCardPageViewModel(),
                  onModelReady: (model) => model.init(),
                ),
              ),
            ],
          ),
        ),
      ),
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
        color: Theme.of(context).backgroundColor.computeLuminance() > 0.5 ? Colors.white : ThemeColors.black,
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(label),
        subtitle: subtitle != null
            ? Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(subtitle),
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

void _displayBusinessCardModal(context, model) {
  ScreenshotController screenshotController = new ScreenshotController();

  showModalBottomSheet(
    enableDrag: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          left: SizeConfig.xMargin(context, 5),
          right: SizeConfig.xMargin(context, 5),
          top: SizeConfig.yMargin(context, 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(AppLocalizations.of(context).buisnessCard),
                FlatButton(
                  color: const Color(0xFFDEE9FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onPressed: model.navigateToBusinessCardPage,
                  child: Text(
                    AppLocalizations.of(context).edit,
                    style: TextStyle(
                      fontSize: SizeConfig.textSize(context, 3.5),
                      color: BrandColors.primary,
                    ),
                  ),
                )
              ],
            ),
            BusinessCardModal(
              screenshotController: screenshotController,
            ),
            SizedBox(height: SizeConfig.yMargin(context, 2)),
            BottomSheetButtons(
              screenshotController: screenshotController,
            ),
            SizedBox(height: SizeConfig.yMargin(context, 3))
          ],
        ),
      );
    },
  );
}
