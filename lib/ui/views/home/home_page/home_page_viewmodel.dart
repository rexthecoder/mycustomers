import 'package:flutter/cupertino.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/models/business_model.dart';
import 'package:mycustomers/core/services/permissions.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';



class HomePageViewModel extends BaseViewModel {
  String _title = 'Home View';
  String get title => _title;


  final double _amount = 100.86;
  double get amount => _amount;

  void btnViewDetails() {
    print('hello');
  } 

  Business selectedBusiness = Business.business[0];

  void changeBusiness(value) {
    selectedBusiness = value;
    notifyListeners();
    // print(value.businessName); //Uncomment to see value in terminal

    // TODO: Create additional Function to Use Value and Change the Operation.
  }


  final NavigationService _navigationService = locator<NavigationService>();
   Permissions _permission =  locator<Permissions>();

  Future navigateToAddCustomer() async {
    final bool isPermitted =
        await _permission.getContactsPermission();
    if (isPermitted) _navigationService.navigateTo(Routes.importCustomerViewRoute);
    else _navigationService.navigateTo(Routes.addCustomerManually);
  }

  TextEditingController debtorsController = TextEditingController();
  void searchDebtors(value){
    notifyListeners();
    //todo: implement debtors search
  }
  TextEditingController creditorsController = TextEditingController();
  void searchCreditors(value){
    notifyListeners();
    //todo: implement creditors search
  }
  TextEditingController allCustomersController = TextEditingController();
  void searchAllCustomers(value){
    notifyListeners();
    //todo: implement allCustomers search
  }
}

