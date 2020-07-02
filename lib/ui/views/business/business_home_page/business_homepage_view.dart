import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mycustomers/core/enums/drawer_status.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:stacked/stacked.dart';

import 'business_homepage_viewmodel.dart';

class BusinessHomePageView extends StatelessWidget {
  final String profile = 'assets/icons/svg/profile.svg';
  final String settings = 'assets/icons/svg/settings.svg';
  final String support = 'assets/icons/svg/support.svg';
  final String businessCard = 'assets/icons/svg/business_card.svg';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusinessHomePageViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: GestureDetector(
          onTap: () {
                Scaffold.of(context).openEndDrawer();
              },
                  child: Container(
            child: Center(
              child: Text(
                'TEST MODE \n \n <-- Drag if Drawer did\'nt pop up',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        // endDrawerEnableOpenDragGesture: false,
        drawerEdgeDragWidth: SizeConfig.xMargin(context, 15.0),
        endDrawer: Container(
          decoration: BoxDecoration(
            color: BrandColors.primary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.xMargin(context, 5.0),
            vertical: SizeConfig.xMargin(context, 5.0),
          ),
          width: SizeConfig.xMargin(context, 85.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: ThemeColors.background,
                  ),
                  onPressed: () {
                    model.closeDrawer();
                  },
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    sideBarMenuButton(
                      context: context,
                      label: 'Profile',
                      onTap: () {
                        model.setActive(Active.profile);
                        model.navigateToProfilePage();
                      },
                      active: model.profileA,
                      icon: profile,
                    ),
                    SizedBox(
                      height: SizeConfig.xMargin(context, 10.0),
                    ),
                    sideBarMenuButton(
                      context: context,
                      label: 'Business Card',
                      onTap: () {
                        model.setActive(Active.businessCard);
                        model.navigateToBusinessCardPage();
                      },
                      active: model.businessCardA,
                      icon: businessCard,
                    ),
                    SizedBox(
                      height: SizeConfig.xMargin(context, 10.0),
                    ),
                    sideBarMenuButton(
                      context: context,
                      label: 'Support',
                      onTap: () {
                        model.setActive(Active.support);
                        model.navigateToSupportPage();
                      },
                      active: model.supportA,
                      icon: support,
                    ),
                    SizedBox(
                      height: SizeConfig.xMargin(context, 10.0),
                    ),
                    sideBarMenuButton(
                      context: context,
                      label: 'Settings',
                      onTap: () {
                        model.setActive(Active.settings);
                        model.navigateToSettingsPage();
                      },
                      active: model.settingsA,
                      icon: settings,
                    ),
                  ],
                ),
              ),
              Text(
                'Copyright, 2020',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
      viewModelBuilder: () => BusinessHomePageViewModel(),
    );
  }

  GestureDetector sideBarMenuButton(
      {BuildContext context,
      String label,
      Function onTap,
      bool active,
      String icon}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: <Widget>[
          SvgPicture.asset(
            icon,
            color: active ? const Color(0xFFFFFFFF) : const Color(0xFFADB1E6),
            semanticsLabel: label,
          ),
          SizedBox(
            width: SizeConfig.textSize(context, 4),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: SizeConfig.textSize(context, 8),
              color: active ? const Color(0xFFFFFFFF) : const Color(0xFFADB1E6),
              fontWeight: FontWeight.bold,
              letterSpacing: SizeConfig.textSize(context, -0.2),
            ),
          ),
        ],
      ),
    );
  }
}
