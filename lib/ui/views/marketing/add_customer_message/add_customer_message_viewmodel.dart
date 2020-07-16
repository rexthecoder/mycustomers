import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/models/customer.dart';
import 'package:mycustomers/core/services/customer_services.dart';
import 'package:mycustomers/core/services/owner_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddCustomerMessageViewModel extends FutureViewModel {
  // Get the services required
  NavigationService _navigationService = locator<NavigationService>();
  ICustomerService _customerService = locator<ICustomerService>();
  OwnerServices _ownerService = OwnerServices();
  Iterable<Contact> contacts;

  List<Customer> _selectedCustomers = [];
  List<Customer> get selectedCustomers => _selectedCustomers;

  List<Customer> _allFrequentCustomers = [];
  List<Customer> get allFrequentCustomers => _allFrequentCustomers;

  String _searchTerm = '';
  Pattern get searchPattern => RegExp('$_searchTerm', caseSensitive: false);

  List<Customer> _allCustomers = [];
  List<Customer> get allCustomers => _allCustomers;
  List<Customer> get searchedCustomer => allCustomers.where(
        (Customer customer) =>
            customer.name.contains(searchPattern) ||
            customer.lastName.contains(searchPattern) ||
            customer.phone.contains(searchPattern)||
            customer.email.contains(searchPattern),
      ).toList();


  /// Data checking section

  bool get hasData => _allCustomers.isNotEmpty;
  bool get hasSelected => _selectedCustomers.isNotEmpty;
  int get numberOfSelected => _selectedCustomers.length;
  bool isSelected(Customer customer) => _selectedCustomers.contains(customer);
  bool get allSelected => _allCustomers.length == _selectedCustomers.length;

  TextEditingController searchController = TextEditingController();
  search(String keyword) {
    _searchTerm = keyword;
//    allCustomers = _allCustomers.where(
//          (Customer customer) =>
//      customer.name.contains(searchPattern) ||
//          customer.lastName.contains(searchPattern) ||
//          customer.phone.contains(searchPattern) ||
//          customer.email.contains(searchPattern),
//    ).toList();
    notifyListeners();
  }

  void addCustomer(Customer customer) {
    _selectedCustomers.add(customer);
    notifyListeners();
  }

  void getFrequentCustomers() {
    //todo: get frequent customers
//    allFrequentCustomers
  }

  void deselectCustomer(Customer customer) {
    _selectedCustomers.removeWhere((element) => element.id == customer.id);
    notifyListeners();
  }

  //todo: implement add new customer

//  Future navigateToAddNewCustomer() async {
//
//    final newContact= await _navigationService
//        .navigateTo(Routes.addNewCustomerMarketing);
//
//   await newContact!= null??
//       _allCustomers.add(newContact);
//   selectedCustomers.add(newContact);
//    notifyListeners();
//    print(newContact.name);
//  }



  /// View initialize and close section

  popView() {
    _navigationService.back();
  }

  returnCustomers() {
    _navigationService.back(result: _selectedCustomers);

  }

  @override
  Future futureToRun() async {
//    _allCustomers = await _customerService.getCustomers('1');

    final contactList = await _ownerService.getPhoneContacts();
    contactList.forEach((contact) {
      _allCustomers.add(contact);
    });
    notifyListeners();
  }

}

//class Contacts{
//  String displayName,
//}