import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
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
    );
  }
}
