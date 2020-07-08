import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/models/customer_contact_h.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@lazySingleton
class CustomerContactService with ReactiveServiceMixin {
  static const String _boxname = "contactBox";
  RxValue<List<CustomerContact>> _contacts = RxValue<List<CustomerContact>>(initial: []);
  List<CustomerContact> get contacts => _contacts.value;
  bool success, error;

  NavigationService _navigationService = locator<NavigationService>();
  var box = Hive.openBox<CustomerContact>(_boxname);

  RxValue<CustomerContact> _contact = RxValue<CustomerContact> (initial: null);
  CustomerContact get contact => _contact.value;

  CustomerContactService(){
    listenToReactiveValues([_contacts, contact]);
  }

  void getContacts() async {
    final bbox = await box;
    _contacts.value = bbox.values.toList();
  }

  void addContact(String customerPhoneNumber, String customerName, String dropDownValue)async {
    print(customerPhoneNumber);
    print(customerName);
    print(dropDownValue);
    if(customerName != null && customerPhoneNumber != null) {
      print('sent');
      final bbox = await box;
      CustomerContact contact = new CustomerContact(name: customerName, phoneNumber: dropDownValue + customerPhoneNumber, id: bbox.length + 1);
      bbox.add(contact).then((value){
        success = true;
        print(success);
        _contact.value = CustomerContact(name: customerName, phoneNumber: dropDownValue + customerPhoneNumber, id: bbox.length + 1);
        print(contact.id);
        _contacts.value = bbox.values.toList();
        _navigationService.navigateTo(Routes.mainTransaction);
      }).catchError((err){
        error = err;
        print(error);
        print('Failed To save Contact');
        success = false;
      });
      print(bbox.values.toList());
    }
  }

}