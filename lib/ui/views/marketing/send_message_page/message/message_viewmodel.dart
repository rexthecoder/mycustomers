import 'dart:io';

import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/material.dart';
//import 'package:url_launcher/url_launcher.dart';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:mycustomers/core/models/customer.dart';
import 'package:mycustomers/core/services/customer_services.dart';
import 'package:mycustomers/core/services/owner_services.dart';

class MessageViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  TextEditingController titleController =TextEditingController();
  TextEditingController messageController =TextEditingController();

  String _upperBoxText = 'Happy New Year!';
  String get upperBoxText => _upperBoxText;

  String lowerBoxText = 'Happy New Year \n Best wishes from me';

  List<String> templateList = [
    'Happy New Year \n Best wishes from me',
    'Seasons Greetings! \n Wishing you a happ new year',
    'Seasons Greetings! \n Wishing you a happ new year',
    'Seasons Greetings! \n Wishing you a happ new year',
    'Reloaded 3 of 692 libraries in 1,777ms.',
    'Reloaded 3 of 692 libraries in 1,777ms.'
  ];

  int numberOfSelectedCustomers = 3;

  bool checkBoxValue = true;
  checkBoxFunction(bool val) {
    checkBoxValue = val;
    val = !val;
  }

  Future navigateToSendMessage() async {
//    await _navigationService.navigateTo(Routes.messageSntDialog,);
//  const uri = 'sms: +60000000000?body=message';
//  if(Platform.isAndroid){
//    if(await canLaunch(uri)){
//      await launch(uri);
//
//    }else{
//      print('no');
//    }
//    url ='sms: +60000000000?body=message';
//    await launch(uri);
//  }
//  else if(Platform.isIOS){
//    const url ='sms: +60000000000?body=message';
//    await launch(url);
//  }
  }

  Future returnHome() async {
     _navigationService.popRepeated(3);
  }

  int currentIndex = 0;
  onTap(template) {
    currentIndex = templateList.indexOf(template);
  }

  // Function to serve as a helper for the navigation
  Future navigateTo() async {
    // await _navigationService.navigateTo(Routes.quickMessageView);
  }

  ICustomerService _customerService = locator<ICustomerService>();
  OwnerServices _ownerService = OwnerServices();
  Iterable<Contact> contacts;

  List<Customer> _selectedCustomers = [];
  List<Customer> get selectedCustomers => _selectedCustomers;

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

  bool get hasData => _allCustomers.isNotEmpty;
  bool get hasSelected => _selectedCustomers.isNotEmpty;
  int get numberOfSelected => _selectedCustomers.length;
  bool isSelected(Customer customer) => _selectedCustomers.contains(customer);
  bool get allSelected => _allCustomers.length == _selectedCustomers.length;
  @override
  Future futureToRun() async {
//    _allCustomers = await _customerService.getCustomers('1');

    final contactList = await _ownerService.getPhoneContacts();
    contactList.forEach((contact) {
      _allCustomers.add(contact);
    });
    print(contactList.toList()[1].displayName);
    notifyListeners();
  }
}
