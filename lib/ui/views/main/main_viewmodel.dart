import 'package:mycustomers/app/locator.dart';
// import 'package:mycustomers/app/router.dart';
// import 'package:mycustomers/core/models/business_model.dart';
import 'package:mycustomers/core/data_sources/store/store_repositories.dart';
import 'package:mycustomers/core/models/store.dart';
import 'package:mycustomers/core/services/auth/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MainViewModel extends BaseViewModel {
  /// Fields
  final NavigationService _navigationService = locator<NavigationService>();
  static AuthService _auth = locator<AuthService>();
  final Duration duration = const Duration(milliseconds: 300);
  List<Store> _stores = StoreRepository.stores;

  List<Store> get stores => _stores;
  Store get currStore => StoreRepository.currentStore;

  final List<Menu> menus = [
    Menu(
      label: 'Home',
      icon: 'assets/icons/svg/home.svg',
      active: false,
    ),
    Menu(
      label: 'Marketing',
      icon: 'assets/icons/svg/marketing.svg',
      active: false,
    ),
    Menu(
      label: 'Business',
      icon: 'assets/icons/svg/business.svg',
      active: false,
    ),
  ];

  final List<Menu> settings = [
    Menu(label: 'Add Customer', icon: 'assets/icons/svg/profile.svg'),
    Menu(label: 'Help', icon: 'assets/icons/svg/support.svg'),
  ];

  final List<Menu> signOut = [
    Menu(label: 'Sign Out', icon: 'assets/icons/svg/profile.svg', onTap: _auth.signOut)
  ];

  int _index = 0;

  bool isCollapsed = true;

  /// Getters
  int get index => _index;

  /// Setters

  /// Methods/Functions
  void changeTab(int index) {
    _index = index;
    if (!isCollapsed){
      isCollapsed = !isCollapsed;
    }
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

  void changeBusiness(String id) {
    StoreRepository.changeSelectedStore(id);
    notifyListeners();
    // print(value.businessName); //Uncomment to see value in terminal

    // TODO: Create additional Function to Use Value and Change the Operation.
  }

  Future navigateToAddBusiness() async {
    // TODO Navigate to add Business page
//    await _navigationService.navigateTo(Routes.);
  }
}

class Menu {
  final String label;
  final Function onTap;
  final bool active;
  final String icon;

  Menu({this.label, this.onTap, this.active, this.icon});
}
