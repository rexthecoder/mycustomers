part of '../../views/main/main_view.dart';

///Created by Demilade Oladugba on 6/19/2020

PlatformNavBar mainViewNavBar(MainViewModel model, PageController controller) {
  return PlatformNavBar(
    currentIndex: model.currentPageIndex,
    itemChanged: (int index) {
      model.pageIndex = index;
      controller.animateToPage(index,
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    },
    items: [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          home,
          semanticsLabel: 'Home',
        ),
        title: PlatformText("Home"),
        activeIcon: SvgPicture.asset(
          homeActive,
          semanticsLabel: 'Home',
        ),
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          marketing,
          semanticsLabel: 'Marketing',
        ),
        title: PlatformText("Marketing"),
        activeIcon: SvgPicture.asset(
          marketingActive,
          semanticsLabel: 'Marketing',
        ),
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          profile,
          semanticsLabel: 'Profile',
        ),
        title: PlatformText("Your Company"),
        activeIcon: SvgPicture.asset(
          profileActive,
          semanticsLabel: 'Profile',
        ),
      ),
    ],
  );
}
