import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/views/business/business_home_page/business_homepage_view.dart';
import 'package:mycustomers/ui/views/home/home_page/home_page_view.dart';
import 'package:mycustomers/ui/views/marketing/marketing_home_page/marketing_homepage_view.dart';
import 'package:mycustomers/ui/widgets/animation/fade_in.dart';
import 'package:mycustomers/ui/widgets/stateful/lazy_index_stacked.dart';
import 'package:stacked/stacked.dart';

import 'main_viewmodel.dart';

class MainView extends StatelessWidget {
  final String home = 'assets/icons/svg/home.svg';
  final String marketing = 'assets/icons/svg/marketing.svg';
  final String business = 'assets/icons/svg/business.svg';
  final String profile = 'assets/icons/svg/profile.svg';
  final String settings = 'assets/icons/svg/settings.svg';
  final String support = 'assets/icons/svg/support.svg';
  final String businessCard = 'assets/icons/svg/business_card.svg';

  final _views = <Widget>[
    FadeIn(child: HomePageView()),
    FadeIn(child: MarketingHomePageView()),
    FadeIn(child: BusinessHomePageView()),
  ];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => MainViewModel(),
      builder: (context, model, child) => Scaffold(
        body: LazyIndexedStack(
          reuse: true,
          index: model.index,
          itemCount: _views.length,
          itemBuilder: (_, index) => _views[index],
        ),
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
                  icon: Icon(Icons.close),
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
              Text('Copyright, 2020')
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: BrandColors.primary,
          selectedItemColor: ThemeColors.background,
          unselectedItemColor: ThemeColors.unselect,
          currentIndex: model.index,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                title: Text('Home'),
                icon: SvgPicture.asset(
                  home,
                  color: ThemeColors.unselect,
                  semanticsLabel: 'Home',
                ),
                activeIcon: SvgPicture.asset(
                  home,
                  color: ThemeColors.background,
                  semanticsLabel: 'Home Navigator is Active',
                )),
            // Icon(Icons.home),

            BottomNavigationBarItem(
                title: Text('Marketing'),
                icon: SvgPicture.asset(
                  marketing,
                  color: ThemeColors.unselect,
                  semanticsLabel: 'Marketing',
                ),
                activeIcon: SvgPicture.asset(
                  marketing,
                  color: ThemeColors.background,
                  semanticsLabel: 'Marketing Navigator is Active',
                )),

            BottomNavigationBarItem(
                // icon: Icon(Icons.work),
                title: Text('Business'),
                icon: SvgPicture.asset(
                  business,
                  color: ThemeColors.unselect,
                  semanticsLabel: 'Business',
                ),
                activeIcon: SvgPicture.asset(
                  business,
                  color: ThemeColors.background,
                  semanticsLabel: 'Business Navigator is Active',
                )),
          ],
          onTap: model.changeTab,
        ),
      ),
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
