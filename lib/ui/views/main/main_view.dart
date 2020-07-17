import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/shape/gf_avatar_shape.dart';
import 'package:mycustomers/core/models/store.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/views/business/business_home_page/business_homepage_view.dart';
import 'package:mycustomers/ui/views/home/home_page/home_page_view.dart';
import 'package:mycustomers/ui/views/marketing/marketing_home_page/marketing_homepage_view.dart';
import 'package:mycustomers/ui/widgets/animation/fade_in.dart';
import 'package:mycustomers/ui/widgets/stateful/lazy_index_stacked.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:mycustomers/core/localization/app_localization.dart';

import 'main_view_model.dart';

part '../../widgets/main/menu_options.dart';

part '../../widgets/main/main_menu.dart';

part '../../widgets/main/business_menu.dart';

part '../../widgets/main/menu_buttons.dart';

part '../../widgets/main/main_header.dart';

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
      onModelReady: (model){
        //model.addlog();
        model.getcurr();
      },
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

  Widget mainView(BuildContext context, MainViewModel model) {
    return AnimatedPositioned(
      duration: model.duration,
      top: 0,
      bottom: 0,
      right: model.isCollapsed ? 0 : SizeConfig.xMargin(context, -25),
      left: model.isCollapsed ? 0 : SizeConfig.xMargin(context, 25),
//      child: GestureDetector(
//        onHorizontalDragUpdate: (details) {
//          if (details.delta.dx > 0) {
//            model.openMenu();
//          }
//        },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            MainHeader(),
            Expanded(
              child: LazyIndexedStack(
                reuse: true,
                index: model.index,
                itemCount: _views.length,
                itemBuilder: (_, index) => _views[index],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).backgroundColor,
          selectedItemColor: Theme.of(context).textSelectionColor,
          unselectedItemColor: ThemeColors.unselect,
          currentIndex: model.index,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                title: Text(AppLocalizations.of(context).home),
                icon: SvgPicture.asset(
                  home,
                  color: ThemeColors.unselect,
                  semanticsLabel: 'Home',
                ),
                activeIcon: SvgPicture.asset(
                  home,
                  color: Theme.of(context).textSelectionColor,
                  semanticsLabel: 'Home Navigator is Active',
                )),
            BottomNavigationBarItem(
                title: Text(AppLocalizations.of(context).marketing),
                icon: SvgPicture.asset(
                  marketing,
                  color: ThemeColors.unselect,
                  semanticsLabel: 'Marketing',
                ),
                activeIcon: SvgPicture.asset(
                  marketing,
                  color: Theme.of(context).textSelectionColor,
                  semanticsLabel: 'Marketing Navigator is Active',
                )),
            BottomNavigationBarItem(
                title: Text(AppLocalizations.of(context).business),
                icon: SvgPicture.asset(
                  business,
                  color: ThemeColors.unselect,
                  semanticsLabel: AppLocalizations.of(context).business,
                ),
                activeIcon: SvgPicture.asset(
                  business,
                  color: Theme.of(context).textSelectionColor,
                  semanticsLabel: 'Business Navigator is Active',
                )),
          ],
          onTap: model.changeTab,
        ),
      ),
//      ),
    );
  }
}
