import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/shape/gf_avatar_shape.dart';
import 'package:mycustomers/core/models/business_model.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/views/business/business_home_page/business_homepage_view.dart';
import 'package:mycustomers/ui/views/home/home_page/home_page_view.dart';
import 'package:mycustomers/ui/views/marketing/marketing_home_page/marketing_homepage_view.dart';
import 'package:mycustomers/ui/widgets/animation/fade_in.dart';
import 'package:mycustomers/ui/widgets/stateful/lazy_index_stacked.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import 'main_viewmodel.dart';

part '../../widgets/main/menu_options.dart';

part '../../widgets/main/main_menu.dart';

part '../../widgets/main/business_menu.dart';

part '../../widgets/main/business_menu_options.dart';

part '../../widgets/main/add_business_icon.dart';

class MainView extends StatelessWidget {
  final String home = 'assets/icons/svg/home.svg';
  final String marketing = 'assets/icons/svg/marketing.svg';
  final String business = 'assets/icons/svg/business.svg';

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
        body: Stack(
          children: <Widget>[
            mainView(context, model),
            MainMenu(),
          ],
        ),
      ),
    );
  }

//  Widget mainMenu(BuildContext context, MainViewModel model) {
//    return AnimatedPositioned(
//      right: model.isCollapsed ? SizeConfig.xMargin(context, 100) : 0,
//      top: 0,
//      bottom: 0,
//      left: model.isCollapsed ? SizeConfig.xMargin(context, -100) : 0,
//      duration: model.duration,
//      child: GestureDetector(
//        onHorizontalDragUpdate: (details) {
//          if (details.delta.dx < 0) {
//            model.closeMenu();
//          }
//        },
//        child: Scaffold(
//          backgroundColor: ThemeColors.black.withOpacity(0.7),
//          body: Container(
//            width: SizeConfig.xMargin(context, 80),
////            color: ThemeColors.primary,
//            child: Row(
//              children: <Widget>[
//                businessMenu(context, model),
//                menuOptions(context, model),
//              ],
//            ),
//          ),
//        ),
//      ),
//    );
//  }

  Widget mainView(BuildContext context, MainViewModel model) {
    return AnimatedPositioned(
      duration: model.duration,
      top: 0,
      bottom: 0,
      right: model.isCollapsed ? 0 : SizeConfig.xMargin(context, -80),
      left: model.isCollapsed ? 0 : SizeConfig.xMargin(context, 80),
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 0) {
            model.openMenu();
          }
        },
        child: Scaffold(
          body: LazyIndexedStack(
            reuse: true,
            index: model.index,
            itemCount: _views.length,
            itemBuilder: (_, index) => _views[index],
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: ThemeColors.background,
            selectedItemColor: BrandColors.primary,
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
                    color: BrandColors.primary,
                    semanticsLabel: 'Home Navigator is Active',
                  )),
              BottomNavigationBarItem(
                  title: Text('Marketing'),
                  icon: SvgPicture.asset(
                    marketing,
                    color: ThemeColors.unselect,
                    semanticsLabel: 'Marketing',
                  ),
                  activeIcon: SvgPicture.asset(
                    marketing,
                    color: BrandColors.primary,
                    semanticsLabel: 'Marketing Navigator is Active',
                  )),
              BottomNavigationBarItem(
                  title: Text('Business'),
                  icon: SvgPicture.asset(
                    business,
                    color: ThemeColors.unselect,
                    semanticsLabel: 'Business',
                  ),
                  activeIcon: SvgPicture.asset(
                    business,
                    color: BrandColors.primary,
                    semanticsLabel: 'Business Navigator is Active',
                  )),
            ],
            onTap: model.changeTab,
          ),
        ),
      ),
    );
  }
//
//  Widget buildMenuList(BuildContext context, List list) {
//    return Padding(
//      padding: EdgeInsets.symmetric(
//        horizontal: SizeConfig.xMargin(context, 5),
//      ),
//      child: Column(
//        children: <Widget>[
//          ListView.separated(
//            physics: NeverScrollableScrollPhysics(),
//            shrinkWrap: true,
//            itemBuilder: (context, index) {
//              var menu = list[index];
//              return sideBarMenuButton(
//                context: context,
//                label: menu.label,
//                active: false,
//                icon: menu.icon,
//                onTap: () {},
//              );
//            },
//            separatorBuilder: (context, index) => SizedBox(
//              height: SizeConfig.xMargin(context, 6),
//            ),
//            itemCount: list.length,
//          ),
//          SizedBox(
//            height: SizeConfig.xMargin(context, 5),
//          ),
//        ],
//      ),
//    );
//  }
//
//  Widget sideBarMenuButton({
//    BuildContext context,
//    String label,
//    Function onTap,
//    bool active,
//    String icon,
//  }) {
//    return GestureDetector(
//      onTap: onTap,
//      child: Row(
//        crossAxisAlignment: CrossAxisAlignment.center,
//        children: <Widget>[
//          SvgPicture.asset(
//            icon,
//            color: active ? BrandColors.primary : ThemeColors.black,
//            semanticsLabel: label,
//            height: SizeConfig.xMargin(context, 6),
//            width: SizeConfig.xMargin(context, 6),
//          ),
//          SizedBox(
//            width: SizeConfig.textSize(context, 3),
//          ),
//          Text(
//            label,
//            style: TextStyle(
//              fontSize: SizeConfig.textSize(context, 4.5),
//              color: active ? BrandColors.primary : ThemeColors.black,
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//
//  Widget addBusinessIcon(BuildContext context) {
//    return Column(
//      children: <Widget>[
//        Container(
//          height: SizeConfig.xMargin(context, 18),
//          width: SizeConfig.xMargin(context, 18),
//          decoration: BoxDecoration(
//            borderRadius: BorderRadius.circular(6),
////                              border: Border.all(
////                                color: BrandColors.primary,
////                                width: 2,
////                              ),
//            boxShadow: [
//              BoxShadow(
//                  color: ThemeColors.gray[600].withOpacity(0.5),
//                  blurRadius: 6,
//                  offset: Offset(0.3, 0.3)),
//            ],
//          ),
//          padding: EdgeInsets.all(
//            SizeConfig.yMargin(context, 0.7),
//          ),
//          child: GFAvatar(
//            shape: GFAvatarShape.standard,
//            backgroundColor: ThemeColors.background,
//            child: Icon(
//              Icons.add,
//              color: ThemeColors.black,
//              size: SizeConfig.textSize(context, 9),
//            ),
//            borderRadius: BorderRadius.circular(6),
//          ),
//        ),
//        Text(
//          'Add Business',
//          maxLines: 2,
//          textAlign: TextAlign.center,
//          style: TextStyle(
//            fontSize: SizeConfig.textSize(context, 4),
//          ),
//        )
//      ],
//    );
//  }
//
//  Widget businessMenu(BuildContext context, MainViewModel model) {
//    return Container(
//      constraints: BoxConstraints(
//        minWidth: SizeConfig.xMargin(context, 23),
//        maxWidth: SizeConfig.xMargin(context, 24),
//      ),
//      padding: EdgeInsets.symmetric(
//        horizontal: SizeConfig.xMargin(context, 2),
//      ),
//      color: ThemeColors.gray[400],
//      child: Column(
////        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          businessMenuOptions(context, model),
//          Divider(color: ThemeColors.gray[700]),
//          addBusinessIcon(context),
//        ],
//      ),
//    );
//  }
//
//  Widget businessMenuOptions(BuildContext context, MainViewModel model) {
//    return Container(
//      constraints: BoxConstraints(
//        maxHeight: SizeConfig.yMargin(context, 62),
//      ),
//      child: ListView.separated(
//        physics: BouncingScrollPhysics(),
//        scrollDirection: Axis.vertical,
//        itemCount: model.businesses.length,
//        itemBuilder: (context, index) =>
//            businessIcon(context, model.businesses[index]),
//        shrinkWrap: true,
//        separatorBuilder: (BuildContext context, int index) => SizedBox(
//          height: SizeConfig.yMargin(context, 2),
//        ),
//      ),
//    );
//  }
//
//  Widget businessIcon(BuildContext context, Business business) {
//    return Column(
//      children: <Widget>[
//        Container(
//          height: SizeConfig.xMargin(context, 18),
//          width: SizeConfig.xMargin(context, 18),
//          decoration: BoxDecoration(
//              borderRadius: BorderRadius.circular(8),
//              border: Border.all(
//                color: BrandColors.primary,
//                width: 2,
//              ),
//              boxShadow: [
//                BoxShadow(
//                    color: ThemeColors.gray[600].withOpacity(0.2),
//                    blurRadius: 6,
//                    offset: Offset(0.3, 0.3)),
//              ]),
//          padding: EdgeInsets.all(
//            SizeConfig.yMargin(context, 0.7),
//          ),
//          child: GFAvatar(
//            shape: GFAvatarShape.standard,
//            backgroundColor: ThemeColors.background,
//            child: Text(
//              business.businessName.substring(0, 1),
//              style: TextStyle(
//                color: ThemeColors.black,
//                fontSize: SizeConfig.textSize(context, 12),
//                fontWeight: FontWeight.bold,
//              ),
//            ),
//            borderRadius: BorderRadius.circular(8),
//          ),
//        ),
//        Text(
//          business.businessName,
//          maxLines: 1,
//          textAlign: TextAlign.center,
//          overflow: TextOverflow.ellipsis,
//          style: TextStyle(
//            fontSize: SizeConfig.textSize(context, 4),
//          ),
//        )
//      ],
//    );
//  }
//
//  Widget menuOptions(BuildContext context, MainViewModel model) {
//    return Expanded(
//      child: Container(
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Padding(
//              padding: EdgeInsets.symmetric(
//                horizontal: SizeConfig.xMargin(context, 5),
//              ),
//              child: RichText(
//                text: TextSpan(
//                  text: 'Wearsmute',
//                  style: TextStyle(
//                      fontSize: SizeConfig.textSize(context, 6),
//                      color: ThemeColors.black,
//                      fontWeight: FontWeight.bold),
//                  children: [
//                    TextSpan(
//                      text: '\nFashion Wears',
//                      style: TextStyle(
//                        fontSize: SizeConfig.textSize(context, 3),
//                        color: ThemeColors.black,
//                        fontWeight: FontWeight.normal,
//                      ),
//                    )
//                  ],
//                ),
//              ),
//            ),
//            Divider(
//              color: ThemeColors.gray[700],
//            ),
//            buildMenuList(context, model.menus),
//            Divider(
//              color: ThemeColors.gray[700],
//            ),
//            buildMenuList(context, model.settings),
//            Divider(
//              color: ThemeColors.gray[700],
//            ),
//            buildMenuList(context, model.signOut),
//          ],
//        ),
//      ),
//    );
//  }
}