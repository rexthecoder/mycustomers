import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/models/business_model.dart';
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

  Future navigateToAddCustomer() async {
    await _navigationService.navigateTo(Routes.addcustomerRoute);
  }
}

