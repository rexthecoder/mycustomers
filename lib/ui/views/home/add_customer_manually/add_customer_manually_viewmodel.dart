import 'package:hive/hive.dart';
import 'package:mycustomers/core/models/hive/customer_contacts/customer_contact_h.dart';
import 'package:mycustomers/core/services/customer_contact_service.dart';
import 'package:stacked/stacked.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked_services/stacked_services.dart';

class AddCustomerManuallyViewModel extends ReactiveViewModel {
  static const String _boxname = "contactBox";
  String _customerName;
  String _customerPhoneNumber;

  String _dropDownValue='+234';

  List<String> _countryCodes=['+234','+254','+250','+230'];

  String get customerName => _customerName;
  String get customerPhoneNumber => _customerPhoneNumber;

  

  List<String> get countryCode=>_countryCodes;
  String get dropDownValue=> _dropDownValue;
  bool success = false;
  String error;
  //NavigationService _navigationService = locator<NavigationService>();

  String _title='Add Customer';
  String _subTitle='Customer Details';

  String get title => _title;
  String get subTitle =>_subTitle;

  final _customerContactService = locator<CustomerContactService>();

  

  void updateName(String name){
    _customerName=name;
    print(customerName);
    notifyListeners();
  }

  void updateContact(String phoneNumber){
    _customerPhoneNumber=phoneNumber;
    notifyListeners();

  }

  void updateCountryCode(String value){
    _dropDownValue=value;
    notifyListeners();
  }

  void addContact()async {
    print(customerPhoneNumber);
    if(customerName != null && customerPhoneNumber != null) {
      _customerContactService.addContact(customerPhoneNumber, customerName, dropDownValue);
    }
    notifyListeners();
  }

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [_customerContactService];
}