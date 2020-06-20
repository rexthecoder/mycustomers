part of '../../views/main/main_view.dart';

///Created by Demilade Oladugba on 6/19/2020

BottomNavigationBar mainViewNavBar(MainViewModel model, PageController controller) {
  return BottomNavigationBar(
    currentIndex: model.currentPageIndex,
    onTap: (int index) {
      model.pageIndex = index;
      controller.animateToPage(index,
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    },
    items: [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          home,
          semanticsLabel: 'Home',
        ),
        title: Text(
          "Home",
          style: TextStyle(
            color: const Color.fromRGBO(51, 60, 193, 1),
          ),
        ),
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
        title: Text(
          "Marketing",
          style: TextStyle(
            color: const Color.fromRGBO(51, 60, 193, 1),
          ),
        ),
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
        title: Text(
          "Your Company",
          style: TextStyle(
            color: const Color.fromRGBO(51, 60, 193, 1),
          ),
        ),
        activeIcon: SvgPicture.asset(
          profileActive,
          semanticsLabel: 'Profile',
        ),
      ),
    ],
  );
}
