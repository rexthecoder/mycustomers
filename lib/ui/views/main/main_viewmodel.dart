import 'package:mycustomers/core/models/business_model.dart';
import 'package:stacked/stacked.dart';

class MainViewModel extends BaseViewModel {
  final Duration duration = const Duration(milliseconds: 300);
  final List<Business> businesses = Business.business;
  bool isCollapsed = true;

  final List<Menu> menus = [
    Menu(label: 'Home', icon: 'assets/icons/svg/home.svg'),
    Menu(label: 'Marketing', icon: 'assets/icons/svg/marketing.svg'),
    Menu(label: 'Business', icon: 'assets/icons/svg/business.svg'),
  ];

  final List<Menu> settings = [
    Menu(label: 'Add Customer', icon: 'assets/icons/svg/profile.svg'),
    Menu(label: 'Help', icon: 'assets/icons/svg/support.svg'),
  ];

  final List<Menu> signOut = [
    Menu(label: 'Sign Out', icon: 'assets/icons/svg/profile.svg'),
  ];

  int _index = 0;

  int get index => _index;

  void changeTab(int index) {
    _index = index;
    notifyListeners();
  }

  void openMenu() {
    isCollapsed = false;
    notifyListeners();
  }

  void closeMenu() {
    isCollapsed = true;
    notifyListeners();
  }
}

class Menu {
  final String label;
  final Function onTap;
  final bool active;
  final String icon;

  Menu({this.label, this.onTap, this.active, this.icon});
}
