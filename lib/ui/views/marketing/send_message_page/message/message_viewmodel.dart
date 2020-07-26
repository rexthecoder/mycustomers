import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:mycustomers/core/models/hive/customer_contacts/customer_contact_h.dart';
import 'package:mycustomers/core/repositories/store/store_repository.dart';
import 'package:mycustomers/core/services/customer_contact_service.dart';
import 'package:mycustomers/core/services/message_service.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:mycustomers/core/services/permission_service.dart';

import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';

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

class MessageViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final  _contactService = locator<CustomerContactService>();
  final  _messageService = locator<MessageService>();
  TextEditingController titleController =TextEditingController();
  TextEditingController messageController =TextEditingController();


  // Future navigateToSendMessage() async {
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
  // }

  List<CustomerContact> get selectedCustomers => _contactService.selectedC;
  String tit = '';
  String body = '';

  void select(Customer cust){
    CustomerContact temp = new CustomerContact(
      name: cust.displayName,
      phoneNumber: cust.phone,
      initials: cust.initials,
    );
    _contactService.addSelected(temp);
  }

  void deselect(Customer cust){
    CustomerContact temp = new CustomerContact(
      name: cust.displayName,
      phoneNumber: cust.phone,
      initials: cust.initials,
    );
    _contactService.removeSelectedS(temp);
  }

  bool checkselected(String name, String phone) {
    for(var item in selectedCustomers) {
      if(item.name == name && item.phoneNumber == phone) return true;
    }
    return false;
  }

  void send()async{
    List<CustomerContact> hold = [];
    for(var item in selectedCustomers){
      await _contactService.addContactmarket(item.phoneNumber, item.name, '', item.initials, StoreRepository.currentStore.id);
      //print(_contactService.contact.name);
      hold.add(_contactService.contact);
    }
    _contactService.selectAll(hold);
    for(var item in selectedCustomers) {
      //print(item.name);
      _messageService.addMessage(tit+', '+body, item.id);
    }
  }

  void setTitle(String value) {
    tit = value;
    notifyListeners();
  }

  void setBody(String value) {
    body = value;
    notifyListeners();
  }

  PermissionService _permission =  locator<IPermissionService>();
  Future<bool> checkPermission() async {
     return await _permission.getContactsPermission(); 
  }
  Future requestPermission() async{
    return await [Permission.contacts].request();
  }

  Future returnHome() async {
    _contactService.deselectAll();
    _navigationService.clearStackAndShow('/main');
    //  _navigationService.popUntil((route){
    //    if(route.settings.name == '/main'){
    //     //(route.settings.arguments as Map)['result'] = _selectedCustomers;
    //      return true;
    //    }else{
    //      return false;
    //    }
    //  });
    //_navigationService.clearStackAndShow(Routes.mainViewRoute);
  }

  StreamController _contactStream = StreamController<List<Customer>>();
  IOwnerServices iOwnerServices = locator<IOwnerServices>();
  List<Customer> allCustomers = List<Customer>();
  bool _busy = true;
  bool get isLoadBusy => _busy;
  MessageViewModel();
  Iterable<Contact> contacts;
  List<Customer> _selectedCustomers = [];
  //List<Customer> get selectedCustomers => _selectedCustomers;
  bool isSelected(Customer customer) => _selectedCustomers.contains(customer);
  // List<CustomerContact> _selectedCustomers = [];
  // List<Customer> _newSelectedCustomers = [];
  // List<Customer> _oldSelectedCustomers = [];
  // List<Customer> get oldSelectedCustomers => _oldSelectedCustomers;
  // List<Customer> get newSelectedCustomers => _newSelectedCustomers;
  // List<CustomerContact> get selectedCustomers => _selectedCustomers;
  // bool isSelected(Customer customer) => _newSelectedCustomers.contains(customer);
  List<Customer> _allFrequentCustomers = [];
  List<Customer> get allFrequentCustomers => _allFrequentCustomers;
  init({String query}) async {
   allCustomers.clear();
    for (Customer customer in (await iOwnerServices.getPhoneContacts(query: query))) {
      print('Iterate');
      if (_busy) {
        _busy = false;
        notifyListeners();
      }
      allCustomers.add(customer);
      _contactStream.add(allCustomers);
    }
  }
//   void oldSelected() {
//     for (var item in _selectedCustomers) {
//       _oldSelectedCustomers.add(Customer(name: item.name,
//           phone: item.phoneNumber,
//           lastName: '',
//           initials: item.initials));
//     }
// //    notifyListeners();
//   }

  String _searchTerm = '';
  Pattern get searchPattern => RegExp('$_searchTerm', caseSensitive: false);
  void selectCustomer(Customer customer) {
    //_newSelectedCustomers.add(customer);
    print(_selectedCustomers.length);
    notifyListeners();
  }
  void mergeSelectCustomer(List<Customer> customers) {

    //final merge = [...oldSelectedCustomers,...customers];
//    final merge = [..._selectedCustomers,...customers];


//    if(_selectedCustomers.)
//    final unique =

//    final merge = [..._selectedCustomers,...customers];
//    _selectedCustomers =unique;
    //_oldSelectedCustomers =merge.toSet().toList();
//    _selectedCustomers = merge.toSet().toList();
//    _selectedCustomers = [..._selectedCustomers,...customers];
//    print(_selectedCustomers.length);
    notifyListeners();
  }

  void initSelected(List<CustomerContact> customers){
    //_selectedCustomers = _selectedCustomers.length == 0?[..._selectedCustomers,...customers]
        //:_selectedCustomers;
//    notifyListeners();

  }

  void setQuickText(title, message){
    if(title.length !=0){
      titleController.text= title;
      tit = title;
      messageController.text = message;
      body = message;
    }
    
  }
  void getFrequentCustomers() {
    //todo: get frequent customers
//    allFrequentCustomers
  }

  void deselectCustomer(Customer customer) {
    print(customer.id);
    //_oldSelectedCustomers.removeWhere((element) => element.phone == customer.phone);
    notifyListeners();
  }
//  //todo: implement add new customer
  Future navigateToAddNewCustomer() async {

    final newContact= await _navigationService
        .navigateTo(Routes.addNewCustomerMarketing);

    await newContact!= null??
        allCustomers.add(newContact);
    selectedCustomers.add(newContact);
    notifyListeners();
    print(newContact.name);
  }
  /// View initialize and close section

  popView() {
    _navigationService.back();
  }
  returnCustomers() {
    _navigationService.back(result: _selectedCustomers);

  }



  TextEditingController searchController = TextEditingController();
  search(String keyword) async {
    _searchTerm = keyword;
    _busy = true;
    notifyListeners();
    init(query: _searchTerm);
  }

  @override
  Stream get stream => _contactStream.stream;

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [_contactService, _messageService];
}
